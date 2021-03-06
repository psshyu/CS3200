% path to save graph outputs
folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment4\output';

n = 10^5;   % set some number of iterations
e = 10^-15; % acceptable error threshold

% initial values for iteration
x_values = zeros(2,n);          % array to hold x1 and x2 values
x_values(:,1) = [1 0.1];        % init (x1, x2) 


% pair of equations to solve
% from here on out, x = x1 and y = x2 in the assignment
syms x y;                   % create the symbols for functions
f1 = @(x,y) (x.^3.+y-1);    % f1
f2 = @(x,y) (y.^3.-x-1);    % f2

% Calculate the entries for the Jacobian matrix
a = matlabFunction(diff(f1(x,y),x)); % df1_dx
b = matlabFunction(diff(f2(x,y),x)); % df2_dx = -1
c = matlabFunction(diff(f1(x,y),y)); % df1_dy = 1
d = matlabFunction(diff(f2(x,y),y)); % df2_dy

for i = 1:n-1
    x = x_values(:,i);                  % x values for this iteration
    J_x = [a(x(1)) b(); c() d(x(2))];   % calculate the Jacobian matrix
    x_next = x - J_x\[f1(x(1),x(2)); f2(x(1),x(2))]; % calculate next x values
    x_values(:,i+1) = x_next;           % insert newly calculated x values into array
    % check to see if ||f(x)|| < e
    if f1(x_next(1,1),x_next(2,1)) < e && f2(x_next(1,1),x_next(2,1)) < e
        n = i;  % set n to the number of iterations it took to reach convergence
        break;
    end
end

n_space = linspace(1,n,n);  % create a 1D array from 1 to n, spaced n

figure('Name', sprintf('Convergence of Functions f1 and f2 with Respect to Number of Iterations; x init = (%1f %1f)', x_values(1,1), x_values(2,1) ))         % figure title              
plot(n_space, f1(x_values(1,1:n), x_values(2,1:n)), 'o-', n_space, f2(x_values(1,1:n), x_values(2,1:n)), '.-.'); % plotting f1 and f2 against each other
legend show;                                        % show legends!
legend('f1(x1, x2)','f2(x1, x2)');                  % set legends
grid on;                                            % turn grids on
title(sprintf('Convergence of Functions f1 and f2 with Respect to Number of Iterations; x init = (%1f %1f)', x_values(1,1), x_values(2,1) )); % plot title
xlabel('Iteration Number')      % x-axis label
ylabel('Function Values')       % y-axis label

saveas(gcf, fullfile(folder, sprintf('Q1_%2.0e%2.0e',x_values(1,1), x_values(2,1))), 'jpg'); % saves figure to output