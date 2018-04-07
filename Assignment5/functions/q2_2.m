n = 100;  % set some number of iterations, may need adjusting
error = 10^-15;

% initial values for iteration
x_values = zeros(2,n);
x_values(1,1) = 2;
x_inits = [1.1, 1.1; 2.0, 0.5; 3.0, 5.0]; % initial values
% pair of equations to solve
% from here on out, x = x1 and y = x2 in the assignment
syms x y;               % create the symbols for functions
f1 = @(x,y) (x.^2.+y^2-2);  % f1
f2 = @(x,y) (exp(x-1)-y.^2.-2);  % f2

% Calculate the entries for the Jacobian matrix
a = matlabFunction(diff(f1(x,y),x)); % df1_dx
b = matlabFunction(diff(f2(x,y),x)); % df2_dx 
c = matlabFunction(diff(f1(x,y),y)); % df1_dy
d = matlabFunction(diff(f2(x,y),y)); % df2_dy

% Mathematically, it was impossible to come up with a solution for this
% system of equations
%{
for i = 1:n-1
    x = x_inits(i,:);                  % x values for this iteration
    J_x = [a(x(1)) b(x(1)); c(x(2)) d(x(2))];   % calculate the Jacobian matrix
    divisor = [f1(x(1),x(2)); f2(x(1),x(2))];
    x_next = x - J_x\divisor; 
    x_values(:,i+1) = x_next;
    if f1(x_next(1,1),x_next(2,1)) < error && f2(x_next(1,1),x_next(2,1)) < error
        n = i;
        break;
    end
end
%}

% Using fsolve to obtain a solution
fun = @fsolver;
exact1 = fsolve(fun,[x_inits(1,1) x_inits(1,2)]); % (1.1, 1.1)
exact2 = fsolve(fun,[x_inits(2,1) x_inits(2,2)]); % (2.0, 0.5)
exact3 = fsolve(fun,[x_inits(3,1) x_inits(3,2)]); % (3.0, 5.0)