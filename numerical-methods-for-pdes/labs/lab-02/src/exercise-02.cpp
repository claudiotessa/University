#include <iostream>

#include "DiffusionReaction.hpp"

// Main function.
int main(int /*argc*/, char * /*argv*/[]) {
    constexpr unsigned int dim = DiffusionReaction::dim;
    const std::string mesh_file_name = "../mesh/mesh-square-20.msh";

    const unsigned int r = 1;

    const auto mu = [](const Point<dim> & /* p */) { return 1.0; };
    const auto f = [](const Point<dim> &p) {
        return (20.0 * M_PI * M_PI + 1) * std::sin(2 * M_PI * p[0]) *
               std::sin(4 * M_PI * p[1]);
    };
    const auto sigma = [](const Point<dim> & /* p */) { return 1.0; };

    DiffusionReaction problem(mesh_file_name, r, mu, f, sigma);

    problem.setup();
    problem.assemble();
    problem.solve();
    problem.output();

    return 0;
}
