/*
task: queens problem
Having modified the model for 
the queens problem, answer the 
question: what is the maximum 
number of chess bishops 
(bishops attack diagonally) that 
can be placed on a 10x10 square 
board, so that no more than 
three bishops stand on each 
horizontal and each vertical, and 
no two bishops attack each 
other?
*/

int: N = 10;
set of int: ROW = 1..N;
set of int: COL = 1..N;
var int: max_number;
array[ROW, COL] of var 0..1: x;

constraint 
	forall(r in ROW)(
		sum(c in COL)(x[r, c]) <= 3
	);

constraint 
	forall(c in COL)(
		sum(r in ROW)(x[r, c]) <= 3 
	);		

constraint
  forall(c in -(N-3)..(N-1))(
    sum(r in ROW where c + r -1 <= N /\ c + r - 1 >= 1)(x[r, c+r-1]) <= 1
  );

constraint
  forall(c in 2..2*N-1)(
    sum(r in ROW where  c-r+1 >= 1 /\ c-r+1<=N)(x[r,c-r+1]) <= 1
  );
  
constraint max_number = sum(r in ROW,c in COL)(x[r,c]); 
 

solve maximize max_number;

output [show(max_number)];
	