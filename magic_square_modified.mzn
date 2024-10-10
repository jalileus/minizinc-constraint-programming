/*
Statement:
- The table 𝑁𝑁 × 𝑁𝑁 is given.
- Place the numbers 1, 2, ..., 𝑁𝑁^2 in the matrix with the following constraints:
  - The sum of the numbers horizontally and vertically must be the same.
  - The sum of the values in the main diagonals is also the same as the sum of the values in each particular row.

Tasks:
- Program the model in MiniZinc.
- Estimate the complexity of the model.
- Try to improve the model.
*/

include "globals.mzn";
int: N = 6;

set of int: ROW = 1..N;
set of int: COL = 1..N;

set of int: VALUES = 1..(N*N) div 2;

var int: row_val;

array[ROW, COL] of var VALUES: magic;

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

% remove symmetry
constraint magic[1,1] < magic[1,N];
constraint magic[1,1] < magic[N,1];
constraint magic[1,1] < magic[N,N];
constraint magic[1,N] < magic[N,1];

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
