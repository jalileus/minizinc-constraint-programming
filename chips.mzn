/*
Let 105 black and white chips are 
arranged in a row. What is the 
maximum number of white chips 
if there are at least 2 black chips 
among any 5 consecutive chips?
*/

int : num_consecutive = 5;
int : max_black = 2;
int : num_chips = 105;

array [1..num_chips] of var 0..1 : row_chips;

int : window = 5;

constraint forall(i in 1..num_chips - window + 1) (
    sum(j in i..i+window-1) (row_chips[j] == 0) >= max_black
    );

var int : max_white = sum(i in 1..num_chips)(row_chips[i] == 1);

solve maximize max_white;

output[show(max_white)];


%answer: 63
