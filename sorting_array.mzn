%given an array input_a, write a program with constraint for sorting.


array [int] of int: input_a = [1,-2,3,10,6,7,3,8,3,8];

int : length_val = length(input_a);

array [1..length_val] of var int: a;

constraint forall(i in 1..length_val-1)(
   a[i] <= a[i+1]
);
constraint forall(i in 1..length_val)(a[i] in input_a);

constraint forall(i in 1..length_val) (input_a[i] in a);

constraint forall(i in 1..length_val)(count(a, a[i]) = count(input_a,a[i]));
%constraint forall(i,j in 1..length_val)(if i != j then a[i] != a[j] endif);

constraint forall(el in a) (el >= min(input_a));
constraint forall(el in a) (el <= max(input_a));

solve satisfy;

output ["sorted array = \(a)"];
