% Inputs
L = 1;
nx = 200;
ny = nx;
x = linspace(0, L, nx);
y = linspace(0, L, ny);
dx = x(2) - x(1);
dy = y(2) - y(1);
error = 1e9; % Initial error value
tol = 1e-4;

% Defining boundary conditions
% Temperature at boundaries
T_B = 300;
T_T = 900;
T_L = 600;
T_R = 400;

T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);  % Creating nx*ny

% Applying boundary conditions
T(2:ny-1, 1) = T_L;
T(2:ny-1, nx) = T_R;
T(1, 2:nx-1) = T_B;
T(ny, 2:nx-1) = T_T;

% Calculating average temperature at the corners
T(1, 1) = (T_B + T_L) / 2;
T(ny, nx) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;


[X, Y] = meshgrid(x, y);


Tolder = T;


iterative_solver = 3;
%omega = 1.72;  
%errors = []; 
%errors = [errors; error]; 
omega_values = 1:0.01:2;
iterations = zeros(size(omega_values));
errors = zeros(size(omega_values));
for omega_index = 1:100
    omega= omega_values(omega_index);
    Told = Tolder;
    T = Tolder;
    error = 9e9;
    SOR_iter = 0;


%if iterative_solver == 3
    
    tic;
    SOR_iter = 1;
    while (error > tol)
        for i = 2:nx-1
            for j = 2:ny-1
                T(i, j) = (omega / 5) * (T(i-1, j) + Told(i+1, j) + T(i, j-1) + Told(i, j+1)) + ...
                          (omega / 20) * (T(i-1, j-1) + Told(i+1, j-1) + T(i-1, j+1) + Told(i+1, j+1)) + ...
                          (1 - omega) * Told(i, j);
            end
        end
        error = max(max(abs(Told - T)));
      %  errors = [errors; error]; 
        Told = T;
        SOR_iter = SOR_iter + 1;
    end
    iterations(omega_index) = SOR_iter-1;
    errors(omega_index) = error;
    fprintf('omega = %.2f, iterations = %d\n', omega_values(omega_index), iterations(omega_index));
end
   % F = toc;
  figure;
plot(omega_values, iterations);
xlabel('Omega');
ylabel('Number of Iterations');
title('Optimal Omega for SOR using Gauss Nine-Point Laplacian Method');
grid on;