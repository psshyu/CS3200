n = 10^5;  % set some number of iterations , may need adjusting
e = 10^-15;
% initial values for iteration
x_values = zeros(2,n);
x_values(1,1) = 175;
x_values(2,1) = 120;

%fun = @root2d;
%x0 = [x_values(1,1),x_values(2,1)];
%exact = fsolve(fun,x0);

% pair of equations to solve
% from here on out, x = x1 and y = x2 in the assignment
syms x y;               % create the symbols for functions
f1 = @(x,y) (x^3+y-1);  % f1
f2 = @(x,y) (y^3-x-1);  % f2

% Calculate the entries for the Jacobian matrix
a = matlabFunction(diff(f1(x,y),x)); % df1_dx
b = matlabFunction(diff(f2(x,y),x)); % df2_dx = -1
c = matlabFunction(diff(f1(x,y),y)); % df1_dy = 1
d = matlabFunction(diff(f2(x,y),y)); % df2_dy

%det = matlabFunction(a(x)*d(y)-b()*c());
%dx = matlabFunction(-(d(y)*f1(x,y)-c()*f2(x,y))/det(x,y));
%dy = matlabFunction(-(-1*b()*f1(x,y)+a(x)*f2(x,y))/det(x,y));

for i = 1:n-1
    x = x_values(:,i);                  % x values for this iteration
    J_x = [a(x(1)) b(); c() d(x(2))];   % calculate the Jacobian matrix
    x_next = x - J_x\[f1(x(1),x(2)); f2(x(1),x(2))]; 
    x_values(:,i+1) = x_next;
    if f1(x_next(1,1),x_next(2,1)) < e && f2(x_next(1,1),x_next(2,1)) < e
        n = i;
        break;
    end
end

n_space = linspace(1,n,n);

figure('Name', 'x-values for each Iteration')         % figure title              
plot(n_space, a(x_values(1,1:n)), 'o-', n_space, d(x_values(2,1:n)), '.-.');                     % plotting Composite Midpoint error against error = 0
legend show;                                        % show legends!
%legend('Composite Midpoint Rule Error');            % set legends
grid on;                                            % turn grids on
%title(sprintf('Composite Composite Midpoint Rule Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('Iteration Number')                                         % x-axis label
ylabel('values of x')       % y-axis label
