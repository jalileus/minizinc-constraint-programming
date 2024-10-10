/*
Bin-packing problem:
Configuration model

Problem statement:
- There is a set of bins with capacity 𝑊.
- Each item has a single parameter: weight.
- Minimize the number of bins used to pack all items.
- The items are grouped by their weight.
- The number of groups is significantly smaller than the number of items.
*/

int: N = 50;
int: W = 100;
array[1..N] of int: weights = [99, 99, 96, 96, 92, 92, 91, 88, 87, 86, 85, 76, 74, 72, 69, 67, 67, 62, 61, 56, 52, 51, 49, 46, 44, 42, 40, 40, 33, 33, 30, 30, 29, 28, 28, 27, 25, 24, 23, 22, 21, 20, 17, 14, 13, 11, 10, 7, 7, 3];

array[1..N] of var 0..1: yi;
array[1..N] of var 0..W: x;

array[1..N, 1..N] of var 0..1: X;

constraint forall(j in 1..N)(
    sum(i in 1..N)(X[i,j] * weights[i]) <= W * yi[j]
);

constraint forall(i in 1..N)(
    sum(j in 1..N)(X[i,j]) == 1
);

constraint forall(i in 1..N)(
    x[i] == sum(j in 1..N)(X[i,j] * weights[i])
);

var int: numBins = sum(i in 1..N)(yi[i] > 0);

solve minimize numBins;

output ["number of items =",show(numBins)];
