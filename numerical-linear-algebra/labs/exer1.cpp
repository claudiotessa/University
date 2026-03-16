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
    // POINT 5)

    SparseMatrix<double> A;
    if (!loadMarket(A, "Aex1.mtx")) {
        cout << "ERROR: could not load Mex1.mtx" << endl;
        return 1;
    }

    cout << "||A|| = " << A.norm() << endl;
    cout << "||A^T A|| = " << (A.transpose() * A).norm() << endl;
    cout << endl;

    // POINT 6)

    VectorXd x_star(A.rows());
    for (int i = 0; i < x_star.size(); i++) {
        x_star(i) = (i % 2 == 0) ? 2.0 : 0.0;
    }

    VectorXd b = A * x_star;

    cout << "||b|| = " << b.norm() << endl;
    cout << endl;

    // POINT 7) LU

    MatrixXd Adense = MatrixXd(A);
    VectorXd x_lu = Adense.lu().solve(b);

    cout << "Solving Ax = b using LU decomposition" << endl;
    cout << "||x_lu - x_star|| = " << (x_lu - x_star).norm() << endl;
    cout << endl;

    // POINT 8) SparseQR

    SparseQR<SparseMatrix<double>, COLAMDOrdering<int>> sparseQrSolver;
    sparseQrSolver.compute(A);

    if (sparseQrSolver.info() != Success) {
        cout << "ERROR: LU decomposition failed" << endl;
        return 1;
    }

    VectorXd x_sqr = sparseQrSolver.solve(b);

    if (sparseQrSolver.info() != Success) {
        cout << "ERROR: LU solving failed" << endl;
        return 1;
    }

    cout << "Solving Ax = b using QR decomposition" << endl;
    cout << "||x_sqr - x_star|| = " << (x_sqr - x_star).norm() << endl;
    cout << endl;

    // POINT 9) Cholesky

    SparseMatrix<double> ATA = A.transpose() * A;
    VectorXd ATb = A.transpose() * b;

    SimplicialLDLT<Eigen::SparseMatrix<double>> choleskySolver(ATA);
    choleskySolver.compute(ATA);
    if (choleskySolver.info() != Success) {
        cout << "ERROR: Cholesky decomposition failed" << endl;
        return 0;
    }

    VectorXd x_ch = choleskySolver.solve(ATb);
    if (choleskySolver.info() != Success) {
        cout << "ERROR: Cholesky solving failed" << endl;
        return 0;
    }

    cout << "Solving A^T A x = A^T b using Cholesky" << endl;
    cout << "||x_ch - x_star|| = " << (x_ch - x_star).norm() << endl;
    cout << "||x_ch - x_sqr|| = " << (x_ch - x_sqr).norm() << endl;
    cout << endl;
}
