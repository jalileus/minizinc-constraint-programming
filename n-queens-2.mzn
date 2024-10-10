/*
• Let bishops, knights and rooks 
be placed on an 8x8 board so 
that no two pieces attack each 
other. For each knight, bishop, 
and rook placed, 1, 2, and 3 
points are given, respectively. 
What is the maximum number 
of points that can be earned?
*/

int: N = 8;

set of int: ROW = 1..N;
set of int: COL = 1..N;

array[ROW,COL] of var 0..1 : bishops;
array[ROW,COL] of var 0..1 : knights;
array[ROW,COL] of var 0..1 : rooks;

% in one row or col we have either rook and no other rooks or bishops or knights or bishops and no rooks : 


constraint forall(r in ROW)(
  if sum(c in COL)(rooks[r,c]) = 1 then sum(c in COL)(bishops[r,c]) = 0 /\
  sum(c in COL) (knights[r,c]) = 0 endif
);


constraint forall(r in ROW)(
  sum(c in COL)(rooks[r,c]) <= 1
);



constraint forall(c in COL)(
  if sum(r in ROW)(rooks[r,c]) = 1 then sum(r in ROW)(bishops[r,c]) = 0 /\
  sum(r in ROW) (knights[r,c]) = 0 endif
);

constraint forall(c in COL)(
  sum(r in ROW)(rooks[r,c]) <= 1
);
% there are no two bishops on the same diagonal :

constraint
  forall(c in -(N-3)..(N-1))(
    sum(r in ROW where c + r -1 <= N /\ c + r - 1 >= 1)(bishops[r, c+r-1]) <= 1
  );
  
  
constraint forall(c in 2..2*N-1)(
    sum(r in ROW where  c-r+1 >= 1 /\ c-r+1<=N)(bishops[r,c-r+1]) <= 1
  );
  
% on the same diagonal there are no bishop and rook at the same time :

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
    
 % on the same diagonal there are no bishop and knight at the same time :   
    
constraint
    forall(c in -(N-3)..(N-1))(
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(knights[r, c + r - 1]) +
        sum(r in ROW where c + r - 1 <= N /\ c + r - 1 >= 1)(bishops[r, c + r - 1]) <= 1
    );
    


constraint 
    forall(c in 2..2*N-1)(
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(knights[r, c - r + 1]) +
        sum(r in ROW where c - r + 1 >= 1 /\ c - r + 1 <= N)(bishops[r, c - r + 1]) <= 1
    );
    
 
% follow knight moves :

constraint
    forall(r in ROW, c in COL where r + 2 <= N /\ c + 1 <= N)(if knights[r, c] == 1 then knights[r + 2, c + 1] = 0 /\ rooks[r + 2, c + 1] = 0 /\ bishops[r + 2,c + 1] = 0 endif);
    
constraint
    forall(r in ROW, c in COL where r + 1 <= N /\ c + 2 <= N)(if knights[r, c] == 1 then knights[r + 1, c + 2] =0 /\ rooks[r + 1, c + 2] = 0 /\  bishops[r + 1,c + 2] = 0 endif);
    
constraint
    forall(r in ROW, c in COL where r - 2 >= 1 /\ c - 1 >= 1)(if knights[r, c] == 1 then knights[r - 2, c - 1] = 0 /\ rooks[r - 2, c - 1] = 0 /\ bishops[r - 2, c - 1] = 0 endif);
    
constraint
    forall(r in ROW, c in COL where r - 1 >= 1 /\ c - 2 >= 1)(if knights[r, c] == 1 then knights[r - 1, c - 2] = 0 /\ rooks[r - 1, c - 2] = 0 /\ bishops[r - 1, c - 2] = 0 endif);
    
constraint
    forall(r in ROW, c in COL where r + 2 <= N /\ c - 1 >= 1)(if knights[r, c] == 1 then knights[r + 2, c - 1] = 0 /\ rooks[r + 2, c - 1] = 0 /\ bishops[r + 2, c - 1]  = 0 endif);
    
    
constraint
    forall(r in ROW, c in COL where r + 1 <= N /\ c - 2 >= 1)(if knights[r, c] == 1 then  knights[r + 1, c - 2] = 0 /\ rooks[r + 1, c - 2] = 0 /\ bishops[r + 1, c - 2] = 0 endif);
    
constraint
    forall(r in ROW, c in COL where r - 2 >= 1 /\ c + 1 <= N)(if knights[r, c] == 1 then  knights[r - 2, c + 1] = 0 /\ rooks[r - 2, c + 1] = 0 /\ bishops[r - 2, c + 1] = 0 endif);
    
    
constraint
    forall(r in ROW, c in COL where r - 1 >= 1 /\ c + 2 <= N)(if knights[r, c] == 1 then  knights[r - 1, c + 2] = 0 /\ rooks[r - 1, c + 2] = 0 /\ bishops[r - 1, c + 2] = 0 endif);
    

 
% calculate total points :

var int: total_points = 1 * sum(r in ROW, c in COL)(knights[r, c]) +
                           2 * sum(r in ROW, c in COL)(bishops[r, c]) +
                           3 * sum(r in ROW, c in COL)(rooks[r, c]);
                           
solve maximize total_points;

% output result : 
output ["total_points = ",show(total_points),"\n"];

% output draw : 
output [join("\n", [join(" ", [if fix(knights[r,c])==1 then "K" elseif fix(rooks[r,c]) == 1 then "R" elseif fix(bishops[r,c]) == 1 then "B" else "-" endif | c in COL]) | r in ROW])]

/*
answer:

total_points = 30
- B K B B - - -
- - - - - - R -
R - - - - - - -
- - - B - - - -
- B - K - - - -
- - - - - - - R
- - - - - R - -
- B B B - - - -
----------
*/
