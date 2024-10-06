% Parameters
L = 1;
nx = 200;
ny = nx;
x = linspace(0, L, nx);
y = linspace(0, L, ny);
dx = x(2) - x(1);
dy = y(2) - y(1);
tol = 1e-4;

% Boundary conditions
T_B = 300;
T_T = 900;
T_L = 600;
T_R = 400;

% Initial temperature distribution
%T = 675 * ones(nx, ny);
T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);

% Apply boundary conditions
T(2:ny-1, 1) = T_L;
T(2:ny-1, nx) = T_R;
T(1, 2:nx-1) = T_B;
T(ny, 2:nx-1) = T_T;

% Calculate average temperature at the corners
T(1, 1) = (T_B + T_L) / 2;
T(ny, nx) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;

% Grid
[X, Y] = meshgrid(x, y);

% Initialize Tolder
Tolder = T;

% SOR method using G-S equation
a_values = 1:0.01:2;
iterations = zeros(size(a_values));
errors = zeros(size(a_values));

for a_index = 1:100
    a = a_values(a_index);
    Told = Tolder;
    T = Tolder;
    error = 1e9;
    SOR_iter = 0;

    while error > tol
        for i = 2:nx-1
            for j = 2:ny-1
                T(i, j) = (1 - a) * Told(i, j) + a * 0.25 * (T(i, j-1) + Told(i, j+1) + T(i-1, j) + Told(i+1, j));
            end
        end
        error = max(max(abs(Told - T)));
        Told = T;
        SOR_iter = SOR_iter + 1;
    end
    iterations(a_index) = SOR_iter-1;
    errors(a_index) = error;
    fprintf('a = %.2f, iterations = %d\n', a_values(a_index), iterations(a_index));
end

% Plot results
figure;
plot(a_values, iterations);
xlabel('Omega');
ylabel('Number of Iterations');
title('Optimal Omega for SOR Gauss Method');
grid on;

