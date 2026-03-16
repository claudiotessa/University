#include <Eigen/Eigenvalues>
#include <Eigen/IterativeLinearSolvers>
#include <Eigen/Sparse>
#include <Eigen/SparseQR>
#include <fstream>
#include <iostream>
#include <string>
#include <unsupported/Eigen/IterativeSolvers>
#include <unsupported/Eigen/SparseExtra>
#include <vector>

using namespace Eigen;
using namespace std;

int main() {
    // POINT 4)

    SparseMatrix<double> A;
    if (!loadMarket(A, "Aex2.mtx")) {
        cout << "ERROR: could not load Aex2.mtx" << endl;
        return 1;
    }

    cout << "size of A = " << A.rows() << "x" << A.cols() << endl;
    cout << "||A^T A|| = " << (A.transpose() * A).norm() << endl;
    cout << endl;

    // POINT 5) BDCSVD to calculate SVD factorization of A = U Sigma V

    MatrixXd Adense = MatrixXd(A);
    BDCSVD<MatrixXd, ComputeThinU | ComputeThinV> svd(Adense);
    MatrixXd U = svd.matrixU();
    MatrixXd V = svd.matrixV();
    VectorXd Sigma = svd.singularValues();

    MatrixXd A_svd = U * Sigma.asDiagonal() * V.transpose();
    cout << "||A - A_svd|| = " << (Adense - A_svd).norm() << endl;
    cout << endl;

    // POINT 6) singular values of A using BDCSVD

    // they are sorted largest to smallest
    cout << "Largest singular value:" << Sigma(0) << endl;
    cout << "Smallest singular value:" << Sigma(Sigma.size() - 1) << endl;
    cout << endl;

    // POINT 7) Solve A^T A v = lambda v

    MatrixXd ATA = A.transpose() * A;
    SelfAdjointEigenSolver<MatrixXd> eigensolver(ATA);

    if (eigensolver.info() != Success) {
        cerr << "ERROR: eigenvalue decomposition failed" << endl;
        return 1;
    }

    VectorXd eigenvalues = eigensolver.eigenvalues();

    cout << "Smallest eigenvalue:" << eigenvalues(0) << endl;
    cout << "Largest eigenvalue:" << eigenvalues(eigenvalues.size() - 1)
         << endl;
    cout << endl;

    // POINT 8) lambda contains the square roots of the eigenvalues of A^T A

    VectorXd lambda = eigenvalues.reverse().cwiseSqrt();

    cout << "||lambda - sigma|| = " << (lambda - Sigma).norm();
}
