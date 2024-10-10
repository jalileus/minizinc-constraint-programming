/*
Suppose there are two couriers, 
each working at a different 
warehouse, starting/finishing 
their rounds at warehouses A and 
B, respectively. 
What is the minimum total route 
that both couriers will take
Matrix of dist :
[| 0, 160, 150, 590, 340, 650, 725, 560, 350, 200 
|160, 0, 260, 680, 280, 650, 820, 715, 500, 150 
|150, 260, 0, 440, 260, 520, 620, 490, 280, 150 
|590, 680, 440, 0, 490, 240, 390, 435, 400, 550 
|340, 280, 260, 490, 0, 660, 800, 700, 510, 140
|650, 650, 520, 240, 660, 0, 160, 250, 340, 670 
|725, 820, 620, 390, 800, 160, 0, 210, 380, 780 
|560, 715, 490, 435, 700, 250, 210, 0, 215, 650 
|350, 500, 280, 400, 510, 340, 380, 215, 0, 450 
|200, 150, 150, 550, 140, 670, 780, 650, 450, 0|];
*/

int : N = 10;
set of int: POINT = 1..N;
set of int: TIME = 1..N div 2;
set of int : A_POINTS = 1..N div 2;
set of int : B_POINTS = N div 2 + 1..N;
array[POINT, POINT] of int : distance_matrix = 
[| 0, 160, 150, 590, 340, 650, 725, 560, 350, 200 
|160, 0, 260, 680, 280, 650, 820, 715, 500, 150 
|150, 260, 0, 440, 260, 520, 620, 490, 280, 150 
|590, 680, 440, 0, 490, 240, 390, 435, 400, 550 
|340, 280, 260, 490, 0, 660, 800, 700, 510, 140
|650, 650, 520, 240, 660, 0, 160, 250, 340, 670 
|725, 820, 620, 390, 800, 160, 0, 210, 380, 780 
|560, 715, 490, 435, 700, 250, 210, 0, 215, 650 
|350, 500, 280, 400, 510, 340, 380, 215, 0, 450 
|200, 150, 150, 550, 140, 670, 780, 650, 450, 0|];

array [POINT, POINT] of var 0..1 : x;
array [POINT, POINT] of var 0..1 : y;
array [TIME] of var A_POINTS : u1;
array [TIME] of var B_POINTS : u2;

var int : obj = sum(p_from, p_to in POINT)(distance_matrix[p_from,p_to] * x[p_from,p_to] + distance_matrix[p_from,p_to] * y[p_from,p_to]);


constraint forall(i in 1..5)(forall(j in 1..10)(y[i,j] = 0));

constraint forall(i in 6..10)(forall(j in 1..5)(y[i,j] = 0));

constraint forall(i in 6..10)(forall(j in 1..10)(x[i,j] = 0));

constraint forall(i in 1..5)(forall(j in 6..10)(x[i,j] = 0));



constraint forall(p in A_POINTS)(
  sum(p_prev in A_POINTS where p_prev != p)(x[p_prev,p]) = 1
  /\ sum(p_next in A_POINTS  where p_next != p)(x[p,p_next]) = 1
);

constraint forall(p in B_POINTS)( 
  sum(p_prev in B_POINTS where p_prev != p)(y[p_prev,p]) = 1
  /\ sum(p_next in B_POINTS where p_next != p)(y[p,p_next]) = 1
);

constraint forall(p in A_POINTS, p_next in A_POINTS where p != 1 /\ p_next != 1)(
  u1[p] - u1[p_next] + N * x[p,p_next] <= N - 1
);

constraint forall(p in B_POINTS, p_next in B_POINTS where p != 6 /\ p_next != 6)(
u2[p - 5] - u2[p_next - 5] + N * y[p,p_next] <= N - 1
);

solve minimize obj;

output["the min total route = ",show(obj),"\n"];
output [
  "A matrix:",
  "\n",  
  concat([concat([show(x[i, j]) ++ " " | j in POINT]) ++ "\n" | i in POINT])
];
output [
  "B matrix:",
  "\n",  
  concat([concat([show(y[i, j]) ++ " " | j in POINT]) ++ "\n" | i in POINT])
];


