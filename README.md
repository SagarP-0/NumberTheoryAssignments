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
```
```text
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

## Assignment 3: Factoring a square-free polynomial
To run specific tests, call the program in a sage enviroment:
```
(base) sagar@stoopid:~/Documents/NumberTheory/ProgAss3$ conda activate sage
(sage) sagar@stoopid:~/Documents/NumberTheory/ProgAss3$ sage cz.sage 
Enter the prime p: 987013 
Enter the degree d: 10
Enter the polynomial f: x^10 + 987010*x^8 + 987009*x^7 + 7*x^5 + 9*x^4 + 8*x^3 + 987009*x^2 + 986999*x + 987007
Stage 1: square-free verification
  gcd(f, f') = 1
  square-free: True
  passed to stage 2: x^10 + 987010*x^8 + 987009*x^7 + 7*x^5 + 9*x^4 + 8*x^3 + 987009*x^2 + 986999*x + 987007
Stage 2: distinct-degree factorization
  degree 1: x + 1
  degree 2: x^2 + 987012*x + 987012
  degree 3: x^3 + 987012*x + 987010
  degree 4: x^4 + 987011
Stage 3: equal-degree factorization
  degree 1:
     x + 1
  degree 2:
     x^2 + 987012*x + 987012
  degree 3:
     x^3 + 987012*x + 987010
  degree 4:
     x^4 + 987011
Final factorization:
  (x + 1) * (x^2 + 987012*x + 987012) * (x^3 + 987012*x + 987010) * (x^4 + 987011)
```
For the test cases of assignment: 
```
(sage) sagar@stoopid:~/Documents/NumberTheory/ProgAss3$ sage tests.sage 
=== Sample 1 ===
Stage 1: square-free verification
  gcd(f, f') = 1
  square-free: True
  passed to stage 2: x^10 + 987010*x^8 + 987009*x^7 + 7*x^5 + 9*x^4 + 8*x^3 + 987009*x^2 + 986999*x + 987007
Stage 2: distinct-degree factorization
  degree 1: x + 1
  degree 2: x^2 + 987012*x + 987012
  degree 3: x^3 + 987012*x + 987010
  degree 4: x^4 + 987011
Stage 3: equal-degree factorization
  degree 1:
     x + 1
  degree 2:
     x^2 + 987012*x + 987012
  degree 3:
     x^3 + 987012*x + 987010
  degree 4:
     x^4 + 987011
Final factorization:
  (x + 1) * (x^2 + 987012*x + 987012) * (x^3 + 987012*x + 987010) * (x^4 + 987011)
  checks passed: products, degrees, monic, Rabin irreducibility
=== Sample 2 ===
Stage 1: square-free verification
  gcd(f, f') = 1
  square-free: True
  passed to stage 2: x^24 + 90470*x^23 + 584910*x^22 + 424214*x^21 + 617809*x^20 + 564069*x^19 + 498745*x^18 + 585592*x^17 + 948174*x^16 + 401092*x^15 + 969584*x^14 + 205925*x^13 + 227787*x^12 + 799739*x^11 + 79152*x^10 + 206275*x^9 + 615771*x^8 + 297793*x^7 + 804341*x^6 + 601340*x^5 + 352012*x^4 + 44059*x^3 + 265844*x^2 + 982273*x + 805981
Stage 2: distinct-degree factorization
  degree 6: x^24 + 90470*x^23 + 584910*x^22 + 424214*x^21 + 617809*x^20 + 564069*x^19 + 498745*x^18 + 585592*x^17 + 948174*x^16 + 401092*x^15 + 969584*x^14 + 205925*x^13 + 227787*x^12 + 799739*x^11 + 79152*x^10 + 206275*x^9 + 615771*x^8 + 297793*x^7 + 804341*x^6 + 601340*x^5 + 352012*x^4 + 44059*x^3 + 265844*x^2 + 982273*x + 805981
Stage 3: equal-degree factorization
  degree 6:
     x^6 + 473938*x^5 + 630954*x^4 + 824457*x^3 + 356777*x^2 + 81717*x + 627235
     x^6 + 63434*x^5 + 53353*x^4 + 13530*x^3 + 22643*x + 57541
     x^6 + 119366*x^5 + 749238*x^4 + 681331*x^3 + 613428*x^2 + 420559*x + 716564
     x^6 + 420745*x^5 + 820563*x^4 + 601116*x^3 + 225233*x^2 + 163860*x + 847631
Final factorization:
  (x^6 + 473938*x^5 + 630954*x^4 + 824457*x^3 + 356777*x^2 + 81717*x + 627235) * (x^6 + 63434*x^5 + 53353*x^4 + 13530*x^3 + 22643*x + 57541) * (x^6 + 119366*x^5 + 749238*x^4 + 681331*x^3 + 613428*x^2 + 420559*x + 716564) * (x^6 + 420745*x^5 + 820563*x^4 + 601116*x^3 + 225233*x^2 + 163860*x + 847631)
  checks passed: products, degrees, monic, Rabin irreducibility
=== Sample 3 ===
Stage 1: square-free verification
  gcd(f, f') = 1
  square-free: True
  passed to stage 2: x^18 + 63433*x^17 + 976930*x^16 + 820322*x^15 + 964786*x^14 + 792610*x^13 + 63903*x^12 + 121839*x^11 + 310997*x^10 + 431335*x^9 + 63915*x^8 + 258752*x^7 + 129005*x^6 + 375003*x^5 + 203701*x^4 + 235473*x^3 + 669490*x^2 + 849285*x + 565324
Stage 2: distinct-degree factorization
  degree 1: x^2 + 987012
  degree 2: x^2 + 987012*x + 987012
  degree 4: x^8 + 987012*x^5 + 98007*x^4 + 889002*x + 594969
  degree 6: x^6 + 63434*x^5 + 53353*x^4 + 13530*x^3 + 22643*x + 57541
Stage 3: equal-degree factorization
  degree 1:
     x + 987012
     x + 1
  degree 2:
     x^2 + 987012*x + 987012
  degree 4:
     x^4 + 987012*x + 987009
     x^4 + 98011
  degree 6:
     x^6 + 63434*x^5 + 53353*x^4 + 13530*x^3 + 22643*x + 57541
Final factorization:
  (x + 987012) * (x + 1) * (x^2 + 987012*x + 987012) * (x^4 + 987012*x + 987009) * (x^4 + 98011) * (x^6 + 63434*x^5 + 53353*x^4 + 13530*x^3 + 22643*x + 57541)
  checks passed: products, degrees, monic, Rabin irreducibility
```
