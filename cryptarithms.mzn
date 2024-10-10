/**
Task: Cryptarithms

Statement:
- In MiniZinc, build the model that will maximize the right part of the equation and find that maximum value.
- In MiniZinc, build the model and identify the number of possible values in case of a feasibility problem 
(in the configuration editor, uncheck "Stop after this many solutions").

Variant: ONE + TWO = FOUR

**/

var 1..9: o;
var 1..9: t;
var 1..9: f;
var 0..9: e;
var 0..9: n;
var 0..9: w;
var 0..9: u;
var 0..9: r;

var int: first_word;
var int: second_word;
var int: third_word;

include "globals.mzn";

constraint all_different([o, t, f, e, n, w, u, r]);

constraint first_word = o * 100 + n * 10 + e;
constraint second_word = t * 100 + w * 10 + o;
constraint third_word = f * 1000 + o * 100 + u * 10 + r;
constraint third_word = first_word + second_word;

solve maximize third_word;

output[show(first_word),"+",show(second_word),"=", show(third_word)];

