/*
Recall the linear model for the 
traveling salesman problem with 
0,1-variables x and u. 
What condition(s) must be added 
to the model to satisfy the 
condition "no more than two 
other points must be visited 
between visits to points 4 and 9"
*/

int: N = 10;
set of int: POINT = 1..N;
set of int: TIME = 1..N;
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
array[POINT, POINT] of var 0..1: x;
array[POINT] of var TIME: u;

var int: obj = sum(p_from, p_to in POINT)(distance_matrix[p_from, p_to] * x[p_from, p_to]);


constraint forall(p in POINT)(
	sum(p_prev in POINT)(x[p_prev, p]) = 1
);

constraint forall(p in POINT)(
	sum(p_next in POINT)(x[p, p_next]) = 1
);

constraint forall(p, p_next in POINT where p != 1 /\ p_next != 1)(
	u[p] - u[p_next] + N * x[p, p_next] <= N - 1
);

%constraint forall(i in POINT)(if u[i] = 4 then (if i <= 7 then u[i + 3] = 9 else u[i - 3] = 9 endif)endif);



solve minimize obj;
output["res = ",show(obj),"\n"];
output [
  "x matrix:",
  "\n",  
  concat([concat([show(x[i, j]) ++ " " | j in POINT]) ++ "\n" | i in POINT])
];

/*
answer:

res = 2195
x matrix:
0 0 1 0 0 0 0 0 0 0 
1 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 1 0 
0 0 0 0 1 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 1 
0 0 0 1 0 0 0 0 0 0 
0 0 0 0 0 1 0 0 0 0 
0 0 0 0 0 0 1 0 0 0 
0 0 0 0 0 0 0 1 0 0 
0 1 0 0 0 0 0 0 0 0 
----------
*/