****************************
** README.txt             **
** Assignment 2           **
** Skylar Shyu | u1039726 **
****************************

Please extract ALL files from the ZIP! You can run everything from main.m by following the prompts that appear. For example, entering 1 will run the functions and implementations involved in Question 1; entering 2 will do the same for Question 2, etc. 

***********************
 Compiling and Running
***********************

*Question 1*
Which file corresponds to which Newton-Cotes function:

    a) Constant Interpolant (Composite Midpoint Rule) --> QuadSchemeMidpoint.m
    b) Linear Interpolant (Composite Trapezoid Rule) --> QuadSchemeTrapezoid.m
    c) Quadratic Interpolant (Composite Simpson's Formula) --> QuadSchemeSimpson.m

Each one of these functions take in 3 arguments (a, b, and N) and returns two vectors containing values of xi and wi, which may be used as {wi, xi} pairings. Arguments a and b may be any real number, representing the interval over which a function is to be integrated, starting with a and ending at b. Argument N is the number of partitions (or sub-intervals) that will compose the integration. 

Note that none of these functions actually calculates the summation of wi * f(xi) from i = 1...N. The calculations are implemented and performed in Question 3. 

*Question 2*
The Composite Gauss-Legendre function may be found in file GaussianQuad.m, and unlike the three Newton-Cotes functions implemented in Question 1, the GaussianQuad function here DOES do the integral calculation. GaussianQuad will take in 4 arguments (a, b, N, f) and return the integral summation. 

Arguments a and b may be any real number, representing the interval over which a function is to be integrated, starting with a and ending at b. Argument N is the number of partitions (or sub-intervals) that will compose the integration. 

Lastly, f represents the function that needs to be integrated; f MUST be in the format of a function handler, properly formatted such that the variable is x and syntactically comprehensible to MatLab. See the examples below:

   1) f = 'x^2+2' -- this is not okay, because MatLab won't know what is element-wise and what isn't. In addition, it's not in a function handler
   2) f = @(x)(x^2+2) -- this is better than the above, but MatLab still doesn't know what is element-wise and what isn't
   3) f = @(x)(x.^2+2) -- THIS IS PERFECT. This will make the function happy. :)

*Question 3*
Q3NewtonCotes involves all the questions in 3 involving the Newton-Cotes rules/formulas in Question 1 above. Specifically, it addresses the point involving convergence plots and error estimation for Trapezoidal Rule, Simpson's Rule, and Richardson Extrapolation. 
Q3GaussianQuads.m involves the last question posed in 3 (Report the results for N = 2,3,4,5 for the Gaussian quadratures...) 

