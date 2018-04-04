n = 100;  % set some number of iterations , may need adjusting
error = 10^-15;

% initial values for iteration
x_values = zeros(2,n);
x_values(1,1) = 2;

% pair of equations to solve
% from here on out, x = x1 and y = x2 in the assignment
syms x y;               % create the symbols for functions
f = @(x) (exp(x-1)+x^2-4);  % f

% Calculate the entries for the Jacobian matrix
a = matlabFunction(diff(f(x),x)); % df1_dx
%b = matlabFunction(diff(f2(x,y),x)); % df2_dx = -1
%c = matlabFunction(diff(f1(x,y),y)); % df1_dy = 1
%d = matlabFunction(diff(f2(x,y),y)); % df2_dy


for i = 1:n-1
    x = x_values(1,i); % x values for this iteration
    ay = a(x);
    delta_x = -inv(a(x))*f(x); 
    x_next = x + delta_x;
    x_values(1,i+1) = x_next;
    if f(x_next(1,1)) < error
        n = i;
        break;
    end
end

n_space = linspace(1,n,n);
figure('Name', 'x-values for each Iteration')         % figure title              
plot(n_space, a(x_values(1,1:n)), 'o-');                   % plotting Composite Midpoint error against error = 0
legend show;                                        % show legends!
%legend('Composite Midpoint Rule Error');            % set legends
grid on;                                            % turn grids on
%title(sprintf('Composite Composite Midpoint Rule Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('Iteration Number')                                         % x-axis label
ylabel('x-values')       % y-axis label
