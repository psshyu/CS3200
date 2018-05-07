
from_n = 7; % starting n value
to_n = 8000;  % ending n value
nCount = 1; % a counter to increment n; tabling purposes
timings = zeros(to_n-from_n+1, 3); % matrix to store timing information

for n = from_n:to_n  % increment through the designated n-range
    timings(nCount, 1) = n;     % put n-value into table 
    
    results = zeros(n, 2);      % place to put x for this n
    [A, b] = generateA_b(n);    % generate A and b matricies according
                                % to the given n-size
                                
    t = tic;                    % begin timing the time to execute pentsolve
    results(:, 1) = pentsolve(A, b);    % run pensolve and store x
    fullSolverTime = toc(t);            % get elapsed time to run penrsolve
    timings(nCount, 2) = fullSolverTime;% store the elapsed time into matrix
    
    t = tic;                    % begin timing the time to execute Matlab's solve
    results(:, 2) = A\b;        % run matlab's A\b solver and store x
    matlabTime = toc(t);        % get elapsed time to run A\b solver
    timings(nCount, 3) = matlabTime;    % store elapsed time into matrix
    
    nCount = nCount + 1;        % increment n
end
