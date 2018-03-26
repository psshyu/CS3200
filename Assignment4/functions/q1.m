A = [4 1 -2; 4 4 -3; 8 4 0];    % set up matrix A values
[L,U,P] = lu(sparse(A), 0);     % perform LU decomp and obtain only the
                                % non-zero values (sparse).
L = full(L);                    % transform L matrix to full version
U = full(U);                    % transform U matrix to full version
disp(full(P));
%{ The code below allows display of Matricies for easier visual consumption
%disp(L);
%disp(U);
%save('L.txt','L','-ascii');
%save('U.txt','L','-ascii');
%}