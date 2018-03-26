
B = [4 1 -2; 4 4 -3; 8 4 2];    % set up matrix B values
C = [4 1 -2; 4 4 -3; 8 4 4];    % set up matrix C values

[Lb,Ub,Pb] = lu(sparse(B), 0);  % perform LU decomp and obtain only the
                                % non-zero values (sparse).
[Lc,Uc,Pc] = lu(sparse(C), 0);  % perform LU decomp and obtain only the
                                % non-zero values (sparse).
                                
Lb = full(Lb);                  % transform L matrix to full version
Ub = full(Ub);                  % transform U matrix to full version

Lc = full(Lc);                  % transform L matrix to full version
Uc = full(Uc);                  % transform U matrix to full version

disp(Lb);
disp(Ub);
disp(Lc);
disp(Uc);

% yes, their LU decompositions are similar. 