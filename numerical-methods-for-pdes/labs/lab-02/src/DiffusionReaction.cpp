#include "DiffusionReaction.hpp"

#include <deal.II/grid/grid_in.h>

#include <filesystem>

void DiffusionReaction::setup() {
    // We no longer want to generate the mesh,
    // but we want to load it from file
    // we are interested in the gmesh file format (.msh)
    {
        GridIn<dim> grid_in;

        // create a connection between the grid_in object and the mesh variable
        grid_in.attach_triangulation(mesh);

        std::ifstream mesh_file(mesh_file_name);
        grid_in.read_msh(mesh_file);

        std::cout << "Number of elements: " << mesh.n_active_cells()
                  << std::endl;
    }

    // Initialize the finite element space
    {
        fe = std::make_unique<FE_SimplexP<dim>>(r);

        std::cout << "Degree: " << fe->degree << std::endl;
        std::cout << "DoF per cell: " << fe->dofs_per_cell << std::endl;

        quadrature = std::make_unique<QGaussSimplex<dim>>(r + 1);

        std::cout << "Quadrature points per cell = " << quadrature->size();
    }

    // Initialize the DoF handler
    {
        dof_handler.reinit(mesh);
        dof_handler.distribute_dofs(*fe);

        std::cout << "Number of DoFs: " << dof_handler.n_dofs() << std::endl;
    }

    // Initialize linear algebra
    {
        // To initialize a sparsity pattern you first initialize
        // a dynamic sparsity pattern (dsp) and then you copy it into
        // the non-dynamic sparsity patters

        DynamicSparsityPattern dsp(dof_handler.n_dofs());
        DoFTools::make_sparsity_pattern(dof_handler, dsp);
        sparsity_pattern.copy_from(dsp);

        // allocate memory for our system matrix
        system_matrix.reinit(sparsity_pattern);

        system_rhs.reinit(dof_handler.n_dofs());
        solution.reinit(dof_handler.n_dofs());
    }
}

void DiffusionReaction::assemble() {
    // These variables are just saved for convenience
    // Number of local DoFs for each element
    const unsigned int dofs_per_cell = fe->dofs_per_cell; // n_loc

    // Number of quadrature points for each element
    const unsigned int n_q = quadrature->size();

    // This object allows to compute basis functions,
    // their derivatives, the reference-to-current element mapping
    // and its derivatives on all quadrature points of all elements
    FEValues<dim> fe_values(
        *fe, *quadrature,
        // specify what quantities we need FEValues to compute on
        // quadrature points. For out test, we need
        update_values                  /* the value of shape functions */
            | update_gradients         /* the derivative of shape functions */
            | update_quadrature_points /*the position of quadrature points */
            | update_JxW_values        /* the quadrature weights */
    );

    // local matrix and vector
    FullMatrix<double> cell_matrix(dofs_per_cell, dofs_per_cell);
    Vector<double> cell_rhs(dofs_per_cell);

    std::vector<types::global_dof_index> dof_indices(dofs_per_cell);

    // first we assemble the system as if we had no boundary conditions
    for (const auto &cell : dof_handler.active_cell_iterators()) {
        fe_values.reinit(cell);

        cell_matrix = 0.0;
        cell_rhs = 0.0;

        // loop over quadrature points
        for (unsigned int q = 0; q < n_q; q++) {
            const auto mu_loc = mu(fe_values.quadrature_point(q));
            const auto f_loc = f(fe_values.quadrature_point(q));
            const double sigma_log = sigma(fe_values.quadrature_point(q));

            // loop over local matrix
            for (unsigned int i = 0; i < dofs_per_cell; i++) {
                for (unsigned int j = 0; j < dofs_per_cell; j++) {
                    cell_matrix(i, j) +=
                        mu_loc *
                        scalar_product(fe_values.shape_grad(j, q),
                                       fe_values.shape_grad(i, q)) *
                        fe_values.JxW(q);
                    // JxW(q) is cached inside fe_values (optimized), so we
                    // can read it every iteration.

                    cell_matrix(i, j) +=
                        sigma_loc * fe_values.shape_value(j, q) *
                        fe_values.shape_value(i, q) * fe_values.JxW(q);
                }

                cell_rhs(i) +=
                    f_loc * fe_values.shape_value(i, q) * fe_values.JxW(q);
            }
        }
        cell->get_dof_indices(dof_indices);

        system_matrix.add(dof_indices, cell_matrix);
        system_rhs.add(dof_indices, cell_rhs);
    }

    // now account for boundary conditions
    // Dirichlet boundary conditions
    std::map<types::global_dof_index, double> boundary_values;
    Functions::ZeroFunction<dim> bc_function;

    std::map<types::boundary_id, const Function<dim> *> boundary_functions;
    boundary_functions[0] = &bc_function;
    boundary_functions[1] = &bc_function;
    boundary_functions[2] = &bc_function;
    boundary_functions[3] = &bc_function;

    VectorTools::interpolate_boundary_values(dof_handler, boundary_functions,
                                             boundary_values);

    MatrixTools::apply_boundary_values(boundary_values, system_matrix, solution,
                                       system_rhs, true);
}

void DiffusionReaction::solve() {
    // use iterative linear solver
    ReductionControl solver_control(
        /* maxiter = */ 1000,
        /* tolerance = */ 1.0e-16,
        /* reduce = */ 1.0e-6 // relative tolerance
    );
    // try to use relative tolerances as they are units-independent

    SolverCG<Vector<double>> solver(solver_control);

    solver.solve(system_matrix, solution, system_rhs, PreconditionIdentity());

    std::cout << " " << solver_control.last_step() << " CG iterations"
              << std::endl;
}

void DiffusionReaction::output() const {
    DataOut<dim> data_out;

    data_out.add_data_vector(dof_handler, solution, "solution");
    data_out.build_patches();

    const std::filesystem::path mesh_path(mesh_file_name);
    const std::string output_file_name = "output-" + mesh_path.stem().string() +
                                         ".vtk"; // stem() removes extension

    std::ofstream output_file(output_file_name);
    data_out.write_vtk(output_file);
}
/*
double DiffusionReaction::compute_error(const VectorTools::NormType &norm_type,
                                const Function<dim> &exact_solution) const {
    const QGaussSimplex<dim> quadrature_error(r + 2);

    Vector<double> error_per_cell(mesh.n_active_cells());
    VectorTools::integrate_difference(dof_handler, solution, exact_solution,
                                      error_per_cell, quadrature_error,
                                      norm_type);

    const double error =
        VectorTools::compute_global_error(mesh, error_per_cell, norm_type);

    return error;
} */
