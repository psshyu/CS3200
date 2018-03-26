delta_x = 1;          % delta x value
n = 161;              % n-values
a = [1, 1e-5, 1e-15]; % a-values
m = 200;              % times to go thru iterative refinement

% path to save graph outputs
% folder = 'C:\Users\Skylar\Documents\GitHub\CS3200\Assignment3\output';

for a_idx = 1:numel(a)          % for loop to go thru all n-values
    aValue = a(a_idx);          % goes thru each N
    h = zeros(161,m+1);         % matrix to hold iterative refinement values
    
    % Ax = b values
    b = [-8, zeros(1,159), -aValue*4];  % b
    A = generateA(aValue, n); % generate A matrix
    h(:,1) = A\b';            % x
    
    % go thru the iterative refinement process m times
    for i = 1:m
        res = b' - A*h(:,i);        % calc residual
        d = A\res;                  % solve system involving residual
        h(:,i+1) = h(:,i) + d;      % add correction 
    end
    final = h(:,end);               % final solution the the ill matrix
    
    figure('Name', sprintf('Solution for Ill-Condition Matrix (a = %2.0e)', a(a_idx)));
    plot(1:n, final', '-');  % plotting condition numbers w/ respect to their n-value 
    grid on;                                            % show grid
    title(sprintf('Solution for Ill-Condition Matrix (a = %2.0e)', a(a_idx))); % plot title
    xlabel('Values of n')                               % x-axis label
    ylabel('h-values')                                  % y-axis label
    % saveas(gcf, fullfile(folder, sprintf('solveForh_%2.0e',a(a_idx))), 'jpg'); % saves figure to output
end