#include <Eigen/Dense>
#include <cstdlib>  // for rand()
#include <iostream>

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

using namespace Eigen;
using namespace std;

int main(int argc, char* argv[]) {
    // PUNTO 1

    const char* image_path = "uma.jpg";

    int height, width, channels;
    unsigned char* image_data =
        stbi_load(image_path, &width, &height, &channels, 1);

    if (!image_data) {
        cerr << "Error: could not load image " << image_path << endl;
        return 1;
    }

    MatrixXd F(height, width);

    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            int index = i * width + j;
            F(i, j) = static_cast<double>(image_data[index]) / 255.0;
        }
    }

    cout << "Image loaded: width: " << width << ", height: " << height << endl;
    stbi_image_free(image_data);  // free memory

    // PUNTO 2

    MatrixXd F_noisy(height, width);
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            double noise = (rand() / (double)RAND_MAX) * 80.0 - 40.0;
            double newval = F(i, j) * 255.0 + noise;
            newval = clamp(newval, 0.0, 255.0);  // constrain between 0 and 255
            F_noisy(i, j) = newval / 255.0;      // normalize to [0, 1]
        }
    }

    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> noisy_image(height,
                                                                  width);
    noisy_image = F_noisy.unaryExpr([](double val) -> unsigned char {
        return static_cast<unsigned char>(val * 255.0);
    });
    const string output_path = "uma_noisy.png";
    if (stbi_write_png(output_path.c_str(), width, height, 1,
                       noisy_image.data(), width) == 0) {
        cout << "Could not save noisy image";
        return -1;
    }

    cout << "The noisy image was saved as " << output_path << endl;

    // PUNTO 3

    VectorXd v(F.size()), w(F_noisy.size());

    if (v.size() != height * width || w.size() != height * width) {
        cout << "Error while reshaping the images as vectors" << endl;
        return 1;
    }

    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            int index = i * width + j;
            v[index] = F(i, j);
            w[index] = F_noisy(i, j);
        }
    }

    cout << "Norm of v:" << v.norm() << endl;

    // PUNTO 4

    MatrixXd Hav1(3, 3);
    Hav1(0, 0) = Hav1(1, 0) = Hav1(0, 1) = Hav1(1, 2) = Hav1(2, 1) =
        Hav1(2, 2) = 1.0 / 8.0;
    Hav1(1, 1) = 1.0 / 4.0;
    Hav1(0, 2) = Hav1(2, 0) = 0.0;

    return 0;
}