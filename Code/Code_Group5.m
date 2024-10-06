clear;
clc;

l = 1.0;   % length of plate in x-direction 
w = 1.0;   % length of plate in y-direction
nx = 200;
ny = nx;

x = linspace(0, l, nx); % Dividing Length in equal steps using user input
y = linspace(0, w, ny); % Dividing width in equal steps using user input

dx = l / nx;   % step size in x direction
dy = w / ny;   % step size in y direction

T_B = 400;
T_T = 200;
T_L = 300;
T_R = 300;

error_req = 1e-4;


% 4 point Initialization
T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);  % Creating nx*ny
T(1, :) = T_B;           % Bottom side temperature
T(ny, :) = T_T;          % Top side temperature
T(2:end-1, 1) = T_L;     % Left side temperature
T(2:end-1, nx) = T_R;    % Right side temperature
T(1, 1) = (T_B + T_L) / 2;
T(nx, ny) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;

errors = [];
error = 1e9;
k = 0;

tic


while error > error_req
    T0 = T;
    for i = 2:ny-1
        for j = 2:nx-1
            T(i, j) = 0.25 * (T0(i + 1, j) + T0(i - 1, j) + T0(i, j + 1) + T0(i, j - 1));            
        end
    end
    error = max(max(abs(T0 - T)));
    errors = [errors, error];  % Store the error at each iteration
    k = k + 1;
end
F = toc;
Toutput = T;
fprintf("Jacobi Iterative Method\n");
fprintf('Computation time: %f\n',F);
fprintf("Number of iterations are: %d \n\n\n", k);


% Plot Jacobi
figure(1);
[M, N] = contourf(x, y, Toutput);
clabel(M, N);
colormap(jet);
colorbar;
title('Temperature Variation on Plate (Steady State) By Jacobi Iterative Method');
xlabel('X-axis');
ylabel('Y-axis');


% Gauss-Seidel Iterative Method
T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);  % Creating nx*ny
T(1, :) = T_B;           % Bottom side temperature
T(ny, :) = T_T;          % Top side temperature
T(2:end-1, 1) = T_L;     % Left side temperature
T(2:end-1, nx) = T_R;    % Right side temperature
T(1, 1) = (T_B + T_L) / 2;
T(nx, ny) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;

errors1 = [];
error = 1e9;
k = 0;

tic
       while error>error_req
           T0=T;
           for i=2:ny-1
               for j=2:nx-1
                   T(i,j)= 0.25 * (T0(i+1,j) + T(i-1,j) + T0(i,j+1) + T(i,j-1));
               end
           end
           error = max(max(abs(T0-T)));
           errors1 = [errors1, error];  % Store the error at each iteration
           k=k+1;
       end
F = toc;
Toutput2 = T;
fprintf("Gauss-Seidel Iterative Method\n");
fprintf('Computation time: %f\n',F);
fprintf("Number of iterations are: %d \n\n\n",k);

% Plot 2D Gauss-Seidel
figure(2);
[M, N] = contourf(x, y, Toutput2);
clabel(M, N);
colormap(jet);
colorbar;
title('Temperature Variation on Plate (Steady State) By Gauss-Seidel');
xlabel('X-axis');
ylabel('Y-axis');

% Gauss-Seidel Iterative Method with SOR using 5 point
T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);
T(1, :) = T_B;           % Bottom side temperature
T(ny, :) = T_T;          % Top side temperature
T(2:end-1, 1) = T_L;     % Left side temperature
T(2:end-1, nx) = T_R;    % Right side temperature
T(1, 1) = (T_B + T_L) / 2;
T(nx, ny) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;

a = 1.97;  % Relaxation factor
errors2 = [];
k = 0;
error = 1e9;

tic
while error > error_req
    T0 = T;
    for i = 2:ny-1
        for j = 2:nx-1
            T(i, j) = (1 - a) * T0(i, j) + a * 0.25 * (T(i, j - 1) + T0(i, j + 1) + T(i - 1, j) + T0(i + 1, j));
        end
    end
    error = max(max(abs(T0 - T))); 
    errors2 = [errors2, error];
    k = k + 1;
end
F = toc;
Toutput3 = T;
fprintf("Gauss-Seidel Iterative Method with SOR\n");
fprintf('Computation time: %f\n',F);
fprintf("Number of iterations are: %d \n\n\n",k);

% Plot 2D Gauss-Seidel with SOR
figure(3);
[M, N] = contourf(x, y, Toutput3);
clabel(M, N);
colormap(jet);
colorbar;
title('Temperature Variation on Plate (Steady State) By Gauss-Seidel with SOR');
xlabel('X-axis');
ylabel('Y-axis');


% 9 point Gauss-Seidel with SOR
T = ((T_B + T_T + T_L + T_R) * 0.25) * ones(nx, ny);
T(1, :) = T_B;           % Bottom side temperature
T(ny, :) = T_T;          % Top side temperature
T(2:end-1, 1) = T_L;     % Left side temperature
T(2:end-1, nx) = T_R;    % Right side temperature
T(1, 1) = (T_B + T_L) / 2;
T(nx, ny) = (T_R + T_T) / 2;
T(ny, 1) = (T_T + T_L) / 2;
T(1, nx) = (T_R + T_B) / 2;

omega = 1.97;  % Relaxation factor
errors3 = [];
k = 0;
error = 1e9;

tic;


    while (error > error_req)
        Told = T;
        for i = 2:nx-1
            for j = 2:ny-1
                T(i, j) = (omega / 5) * (T(i-1, j) + Told(i+1, j) + T(i, j-1) + Told(i, j+1)) + ...
                          (omega / 20) * (T(i-1, j-1) + Told(i+1, j-1) + T(i-1, j+1) + Told(i+1, j+1)) + ...
                          (1 - omega) * Told(i, j);
            end
        end
        error = max(max(abs(Told - T)));
        errors3 = [errors3; error];
        k = k + 1;
    end
  
    F = toc;
    Toutput1 = T;
    fprintf("Gauss-Seidel Iterative Method with SOR 9 point\n");
    fprintf('Computation time: %f\n',F);
    fprintf("Number of iterations are: %d \n\n\n",k);

% Plot 2D Gauss-Seidel with SOR
figure(4);
[M, N] = contourf(x, y, Toutput1);
clabel(M, N);
colormap(jet);
colorbar;
title('Temperature Variation on Plate (Steady State) By Gauss-Seidel with SOR (9 point)');
xlabel('X-axis');
ylabel('Y-axis');

% Plot error
figure(5);
if length(errors) > 400
    plot(1:400, errors(1:400), '-b');
    hold on;
    plot(1:400, errors1(1:400), '-r');
    hold on;
    plot(1:400, errors2(1:400), '-black');
    hold on;
    plot(1:400, errors3(1:400), '-g');
else
    plot(1:length(errors), errors, '-b');
    hold on;
    plot(1:length(errors1), errors1, '-r');
    hold on;
    plot(1:length(errors2), errors2, '-black');
    hold on;
    plot(1:length(errors3), errors3, '-g');
end
title('Error vs Iterations (First 400 Values)');
xlabel('Iterations');
ylabel('Error');
legend('Jacobi','Gauss-Seidel','Gauss-Seidel with SOR','Gauss-Seidel with SOR 9 point');