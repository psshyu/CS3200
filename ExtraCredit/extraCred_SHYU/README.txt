****************************
** 
** README.txt             
**
** Extra Credit Assignment          
**
** Skylar Shyu | u1039726 
**
****************************


Please extract ALL files from the ZIP! As requested, figures and plots may 
be found in the output folder, while the script and any dependent functions 
may be found in the functions folder. 



***********************
 Compiling and Running
***********************

Open up main.m in the functions directory and hit 'run'; this will run all 
of the matlab files associated with all questions of the assignment. If you
wish to change the values of n, please go into the file q1 and change the
values from_n and to_n. i.e. if you want to generate solutions for sizes 7
to 10 inclusively, let from_n and to_n be 7 and 10, respectively.

Depending on your machine, going up to n=8000 might not be feasible. When
n <= 1000, the code will finish running at a reasonable time. 

Question 1 asks us to form the backbone by generating A and b given a value
n. The generation of A and b is done through the script generateA_b.m, and
its implementation may be viewed there. 

Question 2 is answered in the result matrix in the workspace. The two
columns represent the solutions produced by the pentsolver (left) and the
MatLab base algorithm (right).

Question 3's plot may be found in the output folder. 

Question 4 was not answered completely as I didn't have the time to go and
change the implementation of pentsolve.m.

Question 5 and 6 are not in the code, but rather explained in the write-up. 