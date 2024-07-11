% Data generation
n = 20; % Number of data points
m = 11;  % Degree of polynomial
x = rand(n, 1) * 10; % Generating data points in the range [0, 10]
y = rand(n, 1) * 10;

% Polynomial regression using CVX
cvx_begin
    variable p(m+1) % Coefficients of the polynomial (m+1 because it's m-degree)
    expression y_fit(n) % Expression to hold the fitted y values
    
    % Construct the polynomial fit using a for loop
    y_fit = 0;
    for k = 0:m
        y_fit = y_fit + p(k+1) * x.^k;
    end
    
    % Minimize the least squares error
    minimize(norm(y - y_fit, 2))
cvx_end

% Display the coefficients
disp('Polynomial coefficients:');
disp(p);

% Plot the results
x_fit = linspace(min(x), max(x), 100);
y_fit = polyval(flip(p'), x_fit);

figure;
plot(x, y, 'ro', 'MarkerSize', 8, 'DisplayName', 'Data Points');
hold on;
plot(x_fit, y_fit, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Polynomial');
xlabel('x');
ylabel('y');
title('Polynomial Regression using CVX');
legend show;
grid on;
