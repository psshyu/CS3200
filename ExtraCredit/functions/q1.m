
for n = 7:10
    x = zeros(n, 2);
    [A, b] = generateA_b(n);
    t = tic;
    x(:, 1) = pentsolve(A, b);
    fullSolverTime = toc(t);
    
    t = tic;
    x(:, 2) = A\b;
    matlabTime = toc(t);
end
