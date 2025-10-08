#include <iostream>
#include <Eigen/Dense>
#include <Eigen/Sparse>
#include <unsupported/Eigen/SparseExtra>
#include <cstdlib> //needed for rand() and srand()
#include <ctime> //needed for time()


#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image.h" //needed for loading the image
#include "stb_image_write.h" //needed for saving an image

using Eigen::VectorXd;
using Eigen::MatrixXd;
using Eigen::Matrix;
using Eigen::SparseMatrix;
using Eigen::Dynamic;
using Eigen::RowMajor; 
using std::cout;
using std::endl;
using std::string;

typedef Eigen::Triplet<double> T;

bool isSymmetric(std::list<T> &triplets){
    while(!triplets.empty()){
        std::list<T>::iterator it = triplets.begin();
        int row = it->row();
        int col = it->col();
        int val = it->value();

        it = triplets.erase(it);

        if(row!=col){
            bool found = false;
            for(std::list<T>::iterator jt = triplets.begin(); jt!=triplets.end() && !found; jt++){
                if(row == jt->col() && col == jt->row() && val == jt->value()){
                    found = true;
                    triplets.erase(jt);
                }
            }
            if(!found) return false;
        }
        
    }
    return true;
}

int main(){
    //First request

    int height, width, channels;
    unsigned char* image_data = stbi_load("uma.jpg", &width, &height, &channels, 1);
    if(!image_data){
        cout<<"An issue occured when loading the image";
        return -1;
    }

    MatrixXd F(height, width);
    for(int i=0; i<height; i++){
        for (int j=0; j<width; j++){
            F(i,j) = static_cast<double>(image_data[i * width + j])/255.0;
        }
    }
    
    stbi_image_free(image_data); //I free the memory

    cout<<"The matrix F has "<<height<<" rows and "<<width<<" columns."<<endl;


    //Second request

    MatrixXd F_noisy(height, width);
    srand(time(0));
    for(int i=0; i<height; i++){
        for (int j=0; j<width; j++){
            double rand_value = (rand()%81)-40;
            double new_value = F(i,j)*255 + rand_value;
            if(new_value<0.0) new_value = 0.0;
            else if(new_value>255.0) new_value = 255.0;
            F_noisy(i,j) = new_value/255.0;
        }
    }

    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> noisy_image(height, width); //byte matrix
    noisy_image = F_noisy.unaryExpr([](double val) -> unsigned char {
        return static_cast<unsigned char>(val * 255.0); //map F from [0.0, 1.0] to [0, 255]
    });
    const string output_path_1 = "imageWithNoise.png";
    if(stbi_write_png(output_path_1.c_str(), width, height, 1,
                    noisy_image.data(), width) == 0){
        cout << "An issue occured when saving the image with noise";
        return -1;
    }

    cout<<"The image with noise was saved as "<<output_path_1<<endl;
    

    //Third request

    VectorXd v(F.size());
    for(int i=0; i<height;i++){
        v.segment(i*width, width) = F.row(i).transpose();
    }
    VectorXd w(F_noisy.size());
    for(int i=0; i<height;i++){
        w.segment(i*width, width) = F_noisy.row(i).transpose();
    }

    if(v.size()!=w.size() || v.size()!=height*width){
        cout<<"An error occured when reshaping the images as vectors";
        return -1;
    }
    cout<<"The images were succesfully reshaped as vectors and their size is "<<v.size()<<endl;
    cout<<"The norm of v is "<<v.norm()<<endl;

    
    //Fourth request

    MatrixXd Hav1 = MatrixXd::Zero(3,3);
    Hav1(0,0) = Hav1(1, 0) = Hav1(0, 1) = Hav1(1, 2) = Hav1(2, 1) = Hav1(2,2) = 1.0/8.0;
    Hav1(1, 1) = 1.0/4.0;

    std::vector<T> tripletVector;
    
    for(int i=0; i<height; i++){
        for(int j=0; j<width; j++){
            int currentPixel = width*i+j;

            for(int ki=-1; ki<=1; ki++){
                for(int kj=-1; kj<=1; kj++){
                    int adjPixelRow = i + ki;
                    int adjPixelCol = j + kj;

                    if(adjPixelRow>=0 && adjPixelRow<height && adjPixelCol>=0 && adjPixelCol<width){
                        int adjPixel = width * adjPixelRow + adjPixelCol;
                        tripletVector.push_back(T(currentPixel, adjPixel, Hav1(ki+1, kj+1)));
                    }
                }
            }
        }
    }
        
    SparseMatrix<double, RowMajor>A1(v.size(), v.size());
    A1.setFromTriplets(tripletVector.begin(), tripletVector.end());

    cout<<"A1 has "<<tripletVector.size()<<" non-zero elements"<<endl;



    //Fifth request
    
    VectorXd F_av1_vector = A1*w;

    MatrixXd F_av1(height, width);
    for(int i=0; i<height; i++){
        F_av1.row(i) = F_av1_vector.segment(i*width, width).transpose();
    }

    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> smooth_image(height, width); //byte matrix
    smooth_image = F_av1.unaryExpr([](double val) -> unsigned char {
        return static_cast<unsigned char>(val * 255.0); //map F from [0.0, 1.0] to [0, 255]
    });
    const string output_path_2 = "imageFilteredWithAv1.png";
    if(stbi_write_png(output_path_2.c_str(), width, height, 1,
                    smooth_image.data(), width) == 0){
        cout << "An issue occured when saving the filtered (av1) image";
        return -1;
    }

    cout<<"The filtered (av1) image was saved as "<<output_path_2<<endl;


    //Sixth request

    MatrixXd Hsh1 = MatrixXd::Zero(3,3);
    Hsh1(1, 0) = Hsh1(0, 1) = Hsh1(1, 2) = Hsh1(2, 1) = -2;
    Hsh1(1, 1) = 9;

    
    std::vector<T> tripletVector2;
    
    for(int i=0; i<height; i++){
        for(int j=0; j<width; j++){
            int currentPixel = width*i+j;

            for(int ki=-1; ki<=1; ki++){
                for(int kj=-1; kj<=1; kj++){
                    int adjPixelRow = i + ki;
                    int adjPixelCol = j + kj;

                    if(adjPixelRow>=0 && adjPixelRow<height && adjPixelCol>=0 && adjPixelCol<width){
                        int adjPixel = width * adjPixelRow + adjPixelCol;
                        double coeff = Hsh1(ki+1, kj+1);
                        if(coeff!=0.0)
                        tripletVector2.push_back(T(currentPixel, adjPixel, coeff));
                    }
                }
            }
        }
    }
        
    SparseMatrix<double, RowMajor>A2(v.size(), v.size());
    A2.setFromTriplets(tripletVector2.begin(), tripletVector2.end());

    cout<<"A2 has "<<tripletVector2.size()<<" non-zero elements"<<endl;

    std::list<T> tripletList2(tripletVector2.begin(), tripletVector2.end());

    /*
        *********WORKS, BUT I DEACTIVATED IT TO SAVE SOME TIME**************
        if(isSymmetric(tripletList2)) cout<<"A2 is symmetric"<<endl;
        else cout<<"A2 is NOT symmetric"<<endl;
    */
    


    //Seventh request

    VectorXd F_sh1_vector = A2*v;

    MatrixXd F_sh1(height, width);
    for(int i=0; i<height; i++){
        F_sh1.row(i) = F_sh1_vector.segment(i*width, width).transpose();
    }

    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> sharp_image(height, width); //byte matrix
    
    sharp_image = F_sh1.unaryExpr([](double val) -> unsigned char {
        val = std::max(0.0, std::min(1.0, val));
        return static_cast<unsigned char>(val * 255.0);
    });
    const string output_path_3 = "imageFilteredWithSh1.png";
    if(stbi_write_png(output_path_3.c_str(), width, height, 1,
                    sharp_image.data(), width) == 0){
        cout << "An issue occured when saving the filtered (sh1) image";
        return -1;
    }

    cout<<"The filtered (sh1) image was saved as "<<output_path_3<<endl;


    //Eighth request

    Eigen::saveMarket(A2, "A2_matrix.mtx");
    Eigen::saveMarketVector(w, "w_vector.mtx");

    cout<<"Exported A2 and w succesfully"<<endl;
    
    //I use the Conjugate Gradient method with diagonal preconditioning
    double tol = 1e-14;
    Eigen::ConjugateGradient<SparseMatrix<double>, Eigen::Lower|Eigen::Upper, Eigen::DiagonalPreconditioner<double>> cg;
    cg.setTolerance(tol);
    cg.compute(A2);
    VectorXd x = cg.solve(w);

    cout<<"The system has been solved in "<<cg.iterations()<<" iterations. The relative residual is "<<cg.error()<<endl;


    //Ninth request

    //I convert x to a matrix
    MatrixXd x_matrix(height, width);
    for(int i=0; i<height; i++){
        x_matrix.row(i) = x.segment(i*width, width).transpose();
    }

    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> x_image(height, width); //byte matrix
    
    x_image = x_matrix.unaryExpr([](double val) -> unsigned char {
        val = std::max(0.0, std::min(1.0, val)); //I saturate the values because idk if x contains values in [1,0]
        return static_cast<unsigned char>(val * 255.0);
    });
    const string output_path_4 = "imageX.png";
    if(stbi_write_png(output_path_4.c_str(), width, height, 1,
                    x_image.data(), width) == 0){
        cout << "An issue occured when saving x as an image";
        return -1;
    }

    cout<<"The vector x was saved in .png as  "<<output_path_4<<endl;


    //Tenth request

    MatrixXd Hed2 = MatrixXd::Zero(3,3);
    Hed2(0,0) = Hed2(0,2) = -1;
    Hed2(0,1) = -2;
    Hed2(2,0) = Hed2(2,2) = 1;
    Hed2(2,1) = 2;

    std::vector<T> tripletVector3;
    
    for(int i=0; i<height; i++){
        for(int j=0; j<width; j++){
            int currentPixel = width*i+j;

            for(int ki=-1; ki<=1; ki++){
                for(int kj=-1; kj<=1; kj++){
                    int adjPixelRow = i + ki;
                    int adjPixelCol = j + kj;

                    if(adjPixelRow>=0 && adjPixelRow<height && adjPixelCol>=0 && adjPixelCol<width){
                        int adjPixel = width * adjPixelRow + adjPixelCol;
                        double coeff = Hed2(ki+1, kj+1);
                        if(coeff!=0.0)
                            tripletVector3.push_back(T(currentPixel, adjPixel, coeff));
                    }
                }
            }
        }
    }
        
    SparseMatrix<double, RowMajor>A3(v.size(), v.size());
    A3.setFromTriplets(tripletVector3.begin(), tripletVector3.end());

    cout<<"A3 has "<<tripletVector3.size()<<" non-zero elements"<<endl;

    std::list<T> tripletList3(tripletVector3.begin(), tripletVector3.end());

    /*
        *********WORKS, BUT I DEACTIVATED IT TO SAVE SOME TIME**************
        if(isSymmetric(tripletList3)) cout<<"A3 is symmetric"<<endl;
        else cout<<"A3 is NOT symmetric"<<endl;
    */
    

    //Eleventh request

    VectorXd F_ed2_vector = A3*v;

    MatrixXd F_ed2(height, width);
    for(int i=0; i<height; i++){
        F_ed2.row(i) = F_ed2_vector.segment(i*width, width).transpose();
    }


    Matrix<unsigned char, Dynamic, Dynamic, RowMajor> edgy_image(height, width); //byte matrix

    
    edgy_image = F_ed2.unaryExpr([](double val) -> unsigned char {
        val = std::max(0.0, std::min(1.0, val));
        return static_cast<unsigned char>(val * 255.0);
    });
    const string output_path_5 = "imageFilteredWithEd2.png";
    if(stbi_write_png(output_path_5.c_str(), width, height, 1,
                    edgy_image.data(), width) == 0){
        cout << "An issue occured when saving the filtered (ed2) image";
        return -1;
    }

    cout<<"The filtered (ed2) image was saved as "<<output_path_5<<endl;


    //Twelfth request

    /*
    SparseMatrix<double, RowMajor> I(height*width, height*width);
    I.setIdentity();
    SparseMatrix<double, RowMajor> A4 = 3*I + A3;
    */

    /*for (int k = 0; k < A3.rows(); ++k) {
        A3.coeffRef(k,k) += 3.0;
    }


    tol = 1e-8;
    Eigen::ConjugateGradient<SparseMatrix<double>, Eigen::Lower|Eigen::Upper> cg2;
    cg2.setTolerance(tol);
    cg2.compute(A3);
    VectorXd y = cg2.solve(w);

    cout<<"The system has been solved in "<<cg2.iterations()<<" iterations. The relative residual is "<<cg2.error()<<endl;
    
    */


    return 0;
}