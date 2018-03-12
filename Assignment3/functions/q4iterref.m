delta_x = 1;                    % delta x value
n = [21 41 81 161];             % n-values
a = [1, 1e-1, 1e-3, 1e-5, 1e-7, 1e-9, 1e-11, 1e-13, 1e-15]; % a-values

condNums = zeros(numel(n), numel(a)); % pre allocate vector to store condition numbers

% path to save graph outputs
% folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment3\output';

for n_idx = 1:numel(n)          % for loop to go thru all n-values
    N = n(n_idx);               % goes thru each N
    for a_idx = 1:numel(a)      % for loop to go thru all a-values
        A = generateA(a(a_idx), N);    % generate A matrix
        condNums(n_idx, a_idx) = cond(A,inf); % record condition number
    end
end