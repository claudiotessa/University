#include <Eigen/Eigenvalues>
#include <Eigen/Sparse>
#include <fstream>
#include <iostream>
#include <string>
#include <unsupported/Eigen/SparseExtra>
#include <vector>

#include "cg.hpp"
#include "grad.hpp"

using namespace std;

using namespace LinearAlgebra;
using SpMat = Eigen::SparseMatrix<double>;

int main() {
    // EXERCISE 1
    // (6)
    // Load matrix
    SpMat A;
    Eigen::loadMarket(A, "Aex1.mtx");
    A = SpMat(A.transpose()) + A;

    // Check symmetry
    SpMat B = SpMat(A.transpose()) - A;
    std::cout << "Norm of A - A^T: " << B.norm() << endl;

    // Norm of A
    std::cout << "Norm of A:" << A.norm() << endl;

    // (7)
    // x_e = (1, -1, 1, -1, ..., 1)^T with length equal to number of columns of
    // A
    const int n = static_cast<int>(A.cols());
    Eigen::VectorXd x_e(n);
    for (int i = 0; i < n; ++i) {
        // 1 in even idx, -1 in odd idx
        x_e[i] = (i % 2 == 0) ? 1.0 : -1.0;
    }

    // b = A * x_e
    Eigen::VectorXd b = A * x_e;

    // Print a short preview of b
    std::cout << "b (n=" << b.size() << ") first entries: ";
    for (int i = 0; i < std::min(static_cast<int>(b.size()), 10); ++i)
        std::cout << b[i] << " ";
    if (b.size() > 10) std::cout << "...";
    std::cout << std::endl;

    // Euclidean (2-)norm of b
    double b_norm = b.norm();
    std::cout << "Euclidean norm of b: " << b_norm << std::endl;

    return 0;
}