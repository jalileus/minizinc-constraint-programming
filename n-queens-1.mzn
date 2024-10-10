/*
• Let bishops, rooks, and queens 
be placed on an 8x8 board so 
that no two pieces attack each 
other. For each bishop, rook, 
and queen placed, 3, 4, and 5 
points are given, respectively. 
What is the maximum number 
of points that can be earned?
*/

int: N = 8;


set of int: ROW = 1..N;
set of int: COL = 1..N;


array[ROW, COL] of var 0..1: bishops;
array[ROW, COL] of var 0..1: rooks;
array[ROW, COL] of var 0..1: queens;

% for rows and cols : if q = 1 -> r = 0 /\ b = 0, if b >= 1 -> q = 0 /\ r = 0,if r = 1 -> b = 0 /\ q = 0 :
constraint 
	forall(r in ROW)(
		(sum(c in COL)(queens[r, c]) = 1 /\
		sum(c in COL)(rooks[r, c]) = 0 /\
		sum(c in COL) (bishops[r, c]) = 0)
		\/ (sum(c in COL)(queens[r, c]) = 0 /\
		sum(c in COL)(rooks[r, c]) = 1 /\
		sum(c in COL) (bishops[r, c]) = 0)
		\/ (sum(c in COL)(bishops[r, c]) >= 1 /\
		sum(c in COL)(rooks[r, c]) = 0 /\
		sum(c in COL) (queens[r, c]) = 0)
	);

constraint 
	forall(c in COL)(
		(sum(r in ROW)(queens[r, c]) = 1 /\
		sum(r in ROW)(rooks[r, c]) = 0 /\
		sum(r in ROW) (bishops[r, c]) = 0)
		\/ (sum(r in ROW)(queens[r, c]) = 0 /\
		sum(r in ROW)(rooks[r, c]) = 1 /\
		sum(r in ROW) (bishops[r, c]) = 0)
		\/ (sum(r in ROW)(bishops[r, c]) >= 1 /\
		sum(r in ROW)(rooks[r, c]) = 0 /\
		sum(r in ROW) (queens[r, c]) = 0)
	);
    
	
% for diagonals : there is no two queens or bishops on the same diagonal :
	
constraint
  forall(c in -(N-3)..(N-1))(
    sum(r in ROW where c + r -1 <= N /\ c + r - 1 >= 1)(queens[r, c+r-1]) <= 1 /\
    sum(r in ROW where c + r -1 <= N /\ c + r - 1 >= 1)(bishops[r, c+r-1]) <= 1
  );
  
  
constraint forall(c in 2..2*N-1)(
    sum(r in ROW where  c-r+1 >= 1 /\ c-r+1<=N)(queens[r,c-r+1]) <= 1 /\
    sum(r in ROW where  c-r+1 >= 1 /\ c-r+1<=N)(bishops[r,c-r+1]) <= 1
  );
  
  
  
% on the same diagonal there are no queen and bishop at the same time :

constraint
    forall(c in -(N-3)..(N-1))(
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(queens[r, c + r - 1]) +
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(bishops[r, c + r - 1]) <= 1
    );


constraint 
    forall(c in 2..2*N-1)(
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(queens[r, c - r + 1]) +
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(bishops[r, c - r + 1]) <= 1
    );

% on the same diagonal there are no rook and bishop at the same time :

constraint
    forall(c in -(N-3)..(N-1))(
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(rooks[r, c + r - 1]) +
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(bishops[r, c + r - 1]) <= 1
    );


constraint 
    forall(c in 2..2*N-1)(
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(rooks[r, c - r + 1]) +
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(bishops[r, c - r + 1]) <= 1
    );

% on the same diagonal there are no queen and rook at the same time :

constraint
    forall(c in -(N-3)..(N-1))(
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(queens[r, c + r - 1]) +
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(rooks[r, c + r - 1]) <= 1
    );

constraint 
    forall(c in 2..2*N-1)(
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(queens[r, c - r + 1]) +
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(rooks[r, c - r + 1]) <= 1
    );


% calculate total points from the board : 

var int: total_points;
constraint total_points = 3 * sum(r in ROW, c in COL)(bishops[r, c]) +
                           4 * sum(r in ROW, c in COL)(rooks[r, c]) +
                           5 * sum(r in ROW, c in COL)(queens[r, c]);


solve maximize total_points;

% output result : 
output ["total_points = ",show(total_points),"\n"];

% output draw : 
output [join("\n", [join(" ", [if fix(queens[r,c])==1 then "Q" elseif fix(rooks[r,c]) == 1 then "R" elseif fix(bishops[r,c]) == 1 then "B" else "-" endif | c in COL]) | r in ROW])]


/*
answer :

total_points = 44
- - Q - - - - -
B - - - B - - B
- - - - - - - B
B - - B - - - B
B - - - - - - -
- - - - - - Q -
- Q - - - - - -
- - - - - Q - -

*/