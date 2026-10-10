# ROLL: CS26BTKMU11003 Number Theory Assignments
## Assignment 1: 
Check output file and compile with gcc
```
gcc -o q q.c -lgmp && ./q
```
## Assignment 2:
Written in sage: 
In a sage environment run:
```
sage factor_quadratic.sage
```
Output:
```
(base) sagar@stoopid:~/Documents/NumberTheory/ProgAss2$ conda activate sage
(sage) sagar@stoopid:~/Documents/NumberTheory/ProgAss2$ sage factor_quadratic.sage 
All subroutine tests passed.
Enter the prime p: 41
Enter the quadratic polynomial: 5*x^2+6*x+11
The factorization is: 5 * (x + 10) * (x + 24).
(sage) sagar@stoopid:~/Documents/NumberTheory/ProgAss2$ sage factor_quadratic.sage 
All subroutine tests passed.
Enter the prime p: 11
Enter the quadratic polynomial: x^2+30
The factorization is: (x + 5) * (x + 6).
```
