% Given an a-value and n-value, this function will generate an approprate
% matrix that adheres to the 'patterning' given out in Question 4. 
function A = generateA(a,n)
    % generate the diagonal vector
    negative2 = [ones(1,(n-1)/2)*-2, -(1+a), ones(1,(n-1)/2)*(-2*a)];
    
    % begin building the other 2 diagonal vectors w/ 1 offset
    positive1 = ones(1,(n-1)/2);            % part w/ 1s
    positivea = ones(1,(n-1)/2)*a;          % part w/ a
    otherDiag = [positive1, positivea];     % concat them
    
    % generate matricies to be added
    neg1Diag = diag(otherDiag, -1);         % -1 diag         
    pos1Diag = diag(otherDiag, 1);          % 1 diag
    A = diag(negative2);                    % center diag
    
    A = A + neg1Diag+pos1Diag;              % add them up
end
