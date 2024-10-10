/*
Consider the following variant of the 
magic square problem: arrange the 
numbers from 1 to 𝑁^2/2 in the 
square 𝑁 × 𝑁, so that each number 
occurs exactly twice, and the sum of 
the numbers in each horizontal, 
vertical, and each of the two large 
diagonals is the same. What is the 
minimum possible sum of the four 
corner elements in such a magic 
square when 𝑁 = 6?
*/

include "globals.mzn";
int: N = 6;

set of int: ROW = 1..N;
set of int: COL = 1..N;

set of int: VALUES = 1..(N*N) div 2;

var int: row_val;

array[ROW, COL] of var VALUES: magic;

% get sum : 
constraint forall(r in ROW)(
  sum(c in COL)(magic[r,c]) = row_val 
);


constraint forall(r in ROW)(
    sum(c in COL)(magic[r,c]) = row_val
);

constraint forall(c in COL)(
    sum(r in ROW)(magic[r,c]) = row_val
);

constraint 
 forall(value in VALUES)(
    count(magic, value) = 2
);

constraint sum(i in ROW)(magic[i, i]) = row_val;
constraint sum(i in ROW)(magic[i, N + 1 - i]) = row_val;

% remove symmetry :

constraint magic[1,1] < magic[1,N];
constraint magic[1,1] < magic[N,1];
constraint magic[1,1] < magic[N,N];
constraint magic[1,N] < magic[N,1];

% get sum of corners :

var int: min_corner_sum = sum([magic[1,1], magic[1,N], magic[N,1], magic[N,N]]);



solve 
::int_search(
    magic,
    first_fail, 
    indomain_random
)
minimize min_corner_sum;


output ["Minimum possible sum of the four corner elements: ", show(min_corner_sum),"\n"];
output ["Magic Square:\n"];
output [show(magic[i,j]) ++ if j = N then "\n" else " " endif | i in ROW, j in COL];

/*
answer:

Minimum possible sum of the four corner elements: 14
Magic Square:
2 14 11 16 10 4
12 12 4 5 8 16
11 3 14 15 6 8
9 6 10 13 2 17
18 15 1 1 13 9
5 7 17 7 18 3
----------
*/