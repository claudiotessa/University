#ifndef DIFFUSION_REACTION_HPP
#define DIFFUSION_REACTION_HPP

#include <deal.II/base/conditional_ostream.h> // parallel cout to make sure only one process at a time is writing

#include <deal.II/base/quadrature_lib.h>

#include <deal.II/dofs/dof_handler.h>
#include <deal.II/dofs/dof_tools.h>

#include <deal.II/distributed/fully_distributed_tria.h> // parallel mesh

#include <deal.II/fe/fe_simplex_p.h>
#include <deal.II/fe/fe_values.h>
#include <deal.II/fe/mapping_fe.h>

#include <deal.II/grid/grid_generator.h>
#include <deal.II/grid/grid_in.h>
#include <deal.II/grid/grid_out.h>
#include <deal.II/grid/tria.h>

#include <deal.II/lac/dynamic_sparsity_pattern.h>
#include <deal.II/lac/precondition.h>
#include <deal.II/lac/solver_cg.h>
#include <deal.II/lac/solver_gmres.h>
#include <deal.II/lac/trilinos_precondition.h>  // parallel
#include <deal.II/lac/trilinos_sparse_matrix.h> // parallel linear algebra
#include <deal.II/lac/vector.h>

#include <deal.II/numerics/data_out.h>
#include <deal.II/numerics/matrix_tools.h>
#include <deal.II/numerics/vector_tools.h>

#include <filesystem>
#include <fstream>
#include <iostream>

using namespace dealii;

/**
 * Class managing the differential problem.
 */
class DiffusionReaction {
  public:
    // Physical dimension (1D, 2D, 3D)
    static constexpr unsigned int dim = 3;

    // Constructor.
    DiffusionReaction(const std::string &mesh_file_name_,
                      const unsigned int &r_,
                      const std::function<double(const Point<dim> &)> &mu_,
                      const std::function<double(const Point<dim> &)> &sigma_,
                      const std::function<double(const Point<dim> &)> &f_)
        : mesh_file_name(mesh_file_name_), r(r_), mu(mu_), sigma(sigma_), f(f_),
          mpi_size(Utilities::MPI::n_mpi_processes(MPI_COMM_WORLD)),
          mpi_rank(Utilities::MPI::this_mpi_process(MPI_COMM_WORLD)),
          mesh(MPI_COMM_WORLD),
          pcout(std::cout, mpi_rank == 0) // only rank=0 can write
    {}
    // MPI runs multiple instances of the program at the same time
    // MPI_COMM_WORLD = group of all the processses that are running

    // Initialization.
    void setup();

    // System assembly.
    void assemble();

    // System solution.
    void solve();

    // Output.
    void output() const;

    // Compute the error against a given exact solution.
    double compute_error(const VectorTools::NormType &norm_type,
                         const Function<dim> &exact_solution) const;

  protected:
    // Name of the mesh.
    const std::string mesh_file_name;

    // Polynomial degree.
    const unsigned int r;

    // Diffusion coefficient.
    std::function<double(const Point<dim> &)> mu;

    // Reaction coefficient.
    std::function<double(const Point<dim> &)> sigma;

    // Forcing term.
    std::function<double(const Point<dim> &)> f;

    const unsigned int mpi_size;
    const unsigned int mpi_rank;

    // Triangulation.
    parallel::fully_distributed::Triangulation<dim> mesh;

    // Finite element space.
    std::unique_ptr<FiniteElement<dim>> fe;

    // Quadrature formula.
    std::unique_ptr<Quadrature<dim>> quadrature;

    // Quadrature formula for boundary integrals.
    std::unique_ptr<Quadrature<dim - 1>> quadrature_boundary;

    // DoF handler.
    DoFHandler<dim> dof_handler;

    // Sparsity pattern.
    SparsityPattern sparsity_pattern;

    // System matrix.
    TrilinosWrappers::SparseMatrix system_matrix; // parallel matrix

    // System right-hand side.
    TrilinosWrappers::MPI::Vector system_rhs; // parallel vector

    // System solution.
    TrilinosWrappers::MPI::Vector solution;

    ConditionalOStream pcout;

    IndexSet locally_owned_dofs;
};

#endif
