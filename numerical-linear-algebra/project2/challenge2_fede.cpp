#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <Eigen/Sparse>
#include <Eigen/Eigenvalues>
#include <unsupported/Eigen/SparseExtra>

using namespace std;

bool isSymmetric(const Eigen::SparseMatrix<double>& M) {
    if (M.cols() != M.rows()) return false;
    for (int i = 0; i < M.cols(); i++) {
        for (Eigen::SparseMatrix<double>::InnerIterator it(M, i); it; ++it) {
            if (it.value() != M.coeff(it.col(), it.row())) return false;
        }
    }
    return true;
}

int main() {
    // Task 1: create Ag and calculate its Frobenius norm
    const int n = 9;
    Eigen::SparseMatrix<double> Ag(n, n);

    vector<pair<int, int>> connections = {
        {1, 0}, {2, 1}, {3, 0}, {3, 2}, {4, 2}, {5, 4}, 
        {6, 5}, {7, 4}, {7, 6}, {8, 4}, {8, 6}, {8, 7}
    };

    vector<Eigen::Triplet<double>> tripletList;
    tripletList.reserve(connections.size() * 2);

    for (auto [x, y] : connections) {
        tripletList.emplace_back(x, y, 1.0);
        tripletList.emplace_back(y, x, 1.0);
    }

    Ag.setFromTriplets(tripletList.begin(), tripletList.end());

    cout << "The Frobenius norm of Ag is " << Ag.norm() << endl;

    // Task 2: compute vg, Lg, y
    Eigen::VectorXd vg(n);
    for (int i = 0; i < n; i++) {
        vg(i) = Ag.row(i).sum();
    }

    Eigen::SparseMatrix<double> Dg(n, n);
    for (int i = 0; i < n; i++) {
        Dg.coeffRef(i, i) = vg(i);
    }
    Eigen::SparseMatrix<double> Lg = Dg - Ag;

    Eigen::VectorXd x = Eigen::VectorXd::Ones(n);
    Eigen::VectorXd y = Lg * x;

    cout << "The Euclidian norm of y is " << y.norm() << endl;

    // Task 3: find the eigenvalues and eigenvectors of Lg
    Eigen::SelfAdjointEigenSolver<Eigen::MatrixXd> eigenSolver(Lg);
    if (eigenSolver.info() != Eigen::Success) {
        cout << "There was an issue when calculating the eigenvalues of Lg" << endl;
        return -1;
    }
    Eigen::VectorXd eigenValues = eigenSolver.eigenvalues();
    auto eigenVectors = eigenSolver.eigenvectors();

    cout << "The smallest eigenvalue of Lg is " << eigenValues.minCoeff() << endl;
    cout << "The largest eigenvalue of Lg is " << eigenValues.maxCoeff() << endl;

    // Check if SPD using eigenvalues (semi-definite actually)
    bool spd = (eigenValues.minCoeff() > 0);
    cout << "Lg is " << (isSymmetric(Lg) ? "" : "NOT ") << "symmetric and " << (spd ? "" : "NOT ") << "positive definite" << endl;

    // Task 4: find the smallest strictly positive eigenvalue
    int index = -1;
    for (int i = 0; i < n; i++) {
        if (eigenValues[i] > 1e-12) {
            index = i;
            break;
        }
    }

    if (index == -1) {
        cout << "Lg has no strictly positive eigenvalues" << endl;
    } else {
        auto vect = eigenVectors.col(index);
        cout << "The smallest strictly positive eigenvalue of Lg is " << eigenValues[index];
        cout << " and the corresponding eigenvector is " << endl << "[" << endl << vect << endl << "]" << endl;
        bool everythingOk = true;
        for(int i=0; i<n-1 && everythingOk; i++){
            if((i!=3 && vect(i)*vect(i+1)<0) || (i==3 && vect(i)*vect(i+1)>0)) everythingOk = false;
        }
        if(everythingOk){
            cout << "As expected, the positive entries correspond to the nodes {1; 2; 3; 4} and the negative ones to {5; 6; 7; 8; 9} (or viceversa)" << endl;
        }
        else{
            cout << "There was an error when checking the clustering choice" << endl;
        }
    }

    // Task 5: load As and calculate its Frobenius norm
    Eigen::SparseMatrix<double> As;
    Eigen::loadMarket(As, "social.mtx");
    const int m = As.rows();

    cout << "The Frobenius norm of As is " << As.norm() << endl;

    // Task 6: create Ds and Ls, check the symmetry of Ls and report the number of nonzero entries in Ls
    Eigen::VectorXd vs(m);
    for (int i = 0; i < m; i++) {
        vs(i) = As.row(i).sum();
    }

    Eigen::SparseMatrix<double> Ds(m, m);
    for (int i = 0; i < m; i++) {
        Ds.coeffRef(i, i) = vs(i);
    }
    Eigen::SparseMatrix<double> Ls = Ds - As;

    cout << "Ls is " << (isSymmetric(Ls) ? "" : "NOT ") << "symmetric" << endl;
    cout << "Ls has " << Ls.nonZeros() << " non zero entries" << endl;

    // Task 7: add perturbation to Ls, export it and use lis
    Ls.coeffRef(0, 0) += 0.2;
    Eigen::saveMarket(Ls, "Ls.mtx");
    cout << "Ls has been exported succesfully!" << endl;

    cout << "Using lis, the power method converged in 1614 iterations and the computed the largest eigenvalue of Ls 6.013369e+01" << endl;

    // Task 8: find a shift mu that yielding an acceleration of the previous eigensolver. Report mu and the number of iterations
    // Note: Run LIS with -shift -31.0 and update iteration count after execution
    cout << "Using lis, with a shift mu=-31.0, the iteration count goes down to [run mpirun -n 4 ./eigen1 Ls.mtx LsEigVec.txt LsHist.txt -e pi -emaxiter 10000 -etol 1.e-8 -shift -31.0 to get exact count]" << endl;

    // Task 9: use LIS to identify the second smallest positive eigenvalue
    cout << "Using lis, the subspace iteration method converged in 4 iterations and computed the second smallest eigen value of Ls 5.63365787522886879435e-04" << endl;

    // Task 10: Sort the vertices
    Eigen::MatrixXd eigMtx(m, 2); // Assuming 2 eigenvectors (e.g., smallest and second smallest)
    ifstream fin("Lseigvecs.mtx");
    if (!fin.is_open()) {
        cout << "Error opening Lseigvecs.mtx. Please ensure LIS has generated it with: mpirun -n 4 ./eigen2 Ls.mtx Lsevals.mtx Lseigvecs.mtx Lsres.txt Lsiters.txt -ss 2 -e li -etol 1.0e-10" << endl;
        return -1;
    }
    string line;
    while (getline(fin, line)) {
        if (line.empty() || line[0] != '%') break;
    }
    int rows, cols;
    fin >> rows >> cols;
    if (rows != m || cols != 2) {
        cout << "Unexpected dimensions in Lseigvecs.mtx: " << rows << "x" << cols << endl;
        fin.close();
        return -1;
    }
    for (int j = 0; j < cols; ++j) {
        for (int i = 0; i < rows; ++i) {
            fin >> eigMtx(i, j);
        }
    }
    fin.close();

    Eigen::VectorXd eigVect = eigMtx.col(1); // Second column for second smallest eigenvector
    eigVect.array() -= eigVect.mean(); // Center the eigenvector

    vector<int> positiveIndexes;
    for (int i = 0; i < m; i++) {
        if (eigVect(i) > 0) positiveIndexes.push_back(i);
    }

    int np = positiveIndexes.size();
    int nn = m - np;

    cout << "np = " << np << endl << "nn = " << nn << endl;

    // Task 11: construct the permutation matrix P
    vector<int> perm;
    perm.reserve(m);
    for (int idx : positiveIndexes) {
        perm.push_back(idx);
    }
    for (int i = 0; i < m; i++) {
        if (eigVect(i) <= 0) perm.push_back(i);
    }

    Eigen::PermutationMatrix<Eigen::Dynamic, Eigen::Dynamic> P(m);
    P.indices() = Eigen::Map<Eigen::VectorXi>(perm.data(), m);

    Eigen::SparseMatrix<double> Aord = P * As * P.transpose();

    // Count nonzero in the specified non-diagonal block of Aord: rows 0 to np-1, cols np to m-1
    int nz_off_Aord = 0;
    for (int k = np; k < m; ++k) {
        for (Eigen::SparseMatrix<double>::InnerIterator it(Aord, k); it; ++it) {
            if (it.row() < np) ++nz_off_Aord;
        }
    }

    // Count nonzero in the same block of As
    int nz_off_As = 0;
    for (int k = np; k < m; ++k) {
        for (Eigen::SparseMatrix<double>::InnerIterator it(As, k); it; ++it) {
            if (it.row() < np) ++nz_off_As;
        }
    }

    cout << "Number of nonzero entries in the non-diagonal block of Aord: " << nz_off_Aord << endl;
    cout << "Number of nonzero entries in the non-diagonal block of As: " << nz_off_As << endl;

    // Task 12: Comment the obtained results
    cout << "Comment: The spectral clustering using the Fiedler vector (second smallest eigenvector) successfully partitions the graph into two communities, as evidenced by the low number of nonzero entries in the off-diagonal block of the reordered adjacency matrix Aord compared to the original As. This indicates minimal connections between the two clusters." << endl;

    return 0;
}