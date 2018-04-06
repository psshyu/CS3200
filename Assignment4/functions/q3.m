n = 25;  % set some number of iterations , may need adjusting
n_space = linspace(1,n,n);
% initial values for iteration
x_inits = linspace(400,600,201);
e = 10^-15;
x_values = zeros(2, n, 201);

% fun = @root2d;
% x0 = [x_values(1,1),x_values(2,1)];
% exact = fsolve(fun,x0);

% pair of equations to solve
% from here on out, x = x1 and y = x2 in the assignment
syms x y;                               % create the symbols for functions
f1 = @(x,y) ((x^2/186^2)-(y^2/(300^2-186^2)));  % f1
f2 = @(x,y) ((y^3-500)^2/279^2 -((x-300)^2/(500^2-279^2))-1);  % f2

% Calculate the entries for the Jacobian matrix
a = matlabFunction(diff(f1(x,y),x)); % df1_dx
b = matlabFunction(diff(f2(x,y),x)); % df2_dx = -1
c = matlabFunction(diff(f1(x,y),y)); % df1_dy = 1
d = matlabFunction(diff(f2(x,y),y)); % df2_dy


converge = [x_inits; zeros(1,201)];
for i = 400:600                      % initial values, starting from 400
    index = i - 399;                 % adjust the value of i to its index
    x_values(1, 1, index) = i;       % set initial x0 values
    x_values(2, 1, index) = i;
    for j = 1:n-1
        x = x_values(:,j,index); % x values for this iteration
        J_x = [a(x(1)) b(x(1)); c(x(2)) d(x(2))]; %calculate the Jacobian matrix
        x_next = x - J_x\[f1(x(1),x(2)); f2(x(1),x(2))];
        x_values(:,j+1,index) = x_next;
        if j+1 == 25
            if f1(x_next(1,1),x_next(2,1)) < e && f2(x_next(1,1),x_next(2,1)) < e
                converge(2, index) = f1(x_next(1,1),x_next(2,1));
            else
                converge(2, index) = f2(x_next(1,1),x_next(2,1));
            end
        end
    end
end

%{
plot(n_space, a(x_values(1,:)), 'o-', n_space, d(x_values(2,:)), '.-.');                     % plotting Composite Midpoint error against error = 0
legend show;                                        % show legends!
%legend('Composite Midpoint Rule Error');            % set legends
grid on;                                            % turn grids on
%title(sprintf('Composite Composite Midpoint Rule Error Covergence to 0 with Respect to N-partitions')); % plot title
xlabel('Iteration Number')                                         % x-axis label
ylabel('x-values')       % y-axis label
%}
