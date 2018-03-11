b = [0;3;16];                   % Ax = b
A = [4 1 -2; 4 4 -3; 8 4 0];    % set up matrix A values
[L,U,P] = lu(sparse(A), 0);     % perform LU decomp and obtain only the
                                % non-zero values (sparse).
L = full(L);                    % transform L matrix to full version
U = full(U);                    % transform U matrix to full version

y = L\b;
x = U\y;     