% this function aims to generate matricies A and b given a value, n, that
% represents the n by n dimensions of matrix A

function [A, b] = generateA_b(n)
    ind = 2;
    A = zeros(n,n);
    for i = 1:n
       if (i == 1)
          A(i, 1) = 9; A(i, 2) = -4; A(i, 3) = 1;
       elseif (i == 2)
          A(i, 1) = -4; A(i, 2) = 6; A(i, 3) = -4; A(i, 4) = 1;
       elseif (i == 3)
          A(i, 1) = 1; A(i, 2) = -4; A(i, 3) = 6; A(i, 4) = -4; A(i, 5) = 1;
       elseif i == n-2
          A(i, n-4) = 1; A(i, n-3) = -4; A(i, n-2) = 6; A(i, n-1) = -4; A(i, n) = 1;
       elseif i == n-1
          A(i, n-3) = 1; A(i, n-2) = -4; A(i, n-1) = 5; A(i, n) = -2;
       elseif i == n
          A(i, n-2) = 1; A(i, n-1) = -2; A(i, n) = 1;
       else
         for j = ind:ind+4
             A(i, j) = 1;
         end
         ind = ind + 1;
       end
    end
    b = (1 / (n^4)) * ones(1, n)'; 
end