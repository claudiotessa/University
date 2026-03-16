#include <cmath>
#include <deal.II/base/convergence_table.h>

#include <fstream>
#include <iostream>

#include "Poisson1D.hpp"

static constexpr unsigned int dim = Poisson1D::dim;

class ExactSolution : public Function<dim> {
  public:
    ExactSolution() = default;

    virtual double
    value(const Point<dim> &p,
          const unsigned int /* component */ = 0) const override {
        return std::sin(2.0 * M_PI * p[0]);
    }

    // first parameter = rank of tensor (physical-vector)
    // rank 1 tensor = vector
    // rank 2 tensor = matrix
    virtual Tensor<1, dim>
    gradient(const Point<dim> &p,
             const unsigned int /* component */ = 0) const {
        Tensor<1, dim> result;

        result[0] = 2.0 * M_PI * std::cos(2.0 * M_PI * p[0]);

        return result;
    }
};

// Main function.
int main(int /*argc*/, char * /*argv*/[]) {
    const unsigned int r = 1;

    const auto mu = [](const Point<dim> & /* p */) { return 1.0; };

    const auto f = [](const Point<dim> &p) {
        return 4.0 * M_PI * M_PI * std::sin(2 * M_PI * p[0]);
    };

    ExactSolution exact_solution;
    const std::vector<unsigned int> N_el_values = {10, 20, 40, 80, 160, 320};

    // save errors to a csv file
    std::ofstream convergence_file("convergence.csv");
    convergence_file << "h,eL2,eH1" << std::endl;

    ConvergenceTable table;

    for (const unsigned int &N_el : N_el_values) {
        Poisson1D problem(N_el, r, mu, f);

        problem.setup();
        problem.assemble();
        problem.solve();
        problem.output();

        const double error_L2 =
            problem.compute_error(VectorTools::L2_norm, exact_solution);

        const double error_H1 =
            problem.compute_error(VectorTools::H1_norm, exact_solution);

        const double h = 1.0 / N_el;

        convergence_file << h << "," << error_L2 << "," << error_H1
                         << std::endl;

        table.add_value("h", h);
        table.add_value("L2", error_L2);
        table.add_value("H1", error_H1);
    }

    // converge table assumes h halves every time
    // (double the number of elements every time)
    // to estimate the convergence rate
    table.evaluate_all_convergence_rates(ConvergenceTable::reduction_rate_log2);

    table.set_scientific("L2", true);
    table.set_scientific("H1", true);

    table.write_text(std::cout);

    return 0;
}
