/*
Solve with MiniZinc a system of equations in integers in the range [-1000, 1000]:
2𝑥 + 𝑦^3 = z^2 − 𝑦 − 17
𝑥^2 − 𝑦 + 3𝑧 = 11
𝑥 * y = 2𝑦 + 5 * z
*/

var -1000..1000 : x;
var -1000..1000 : y;
var -1000..1000 : z;

constraint 2*x + y^3 = z^2 - y - 17;
constraint x^2 - y + 3*z = 11;
constraint x*y = 2*y + 5*z;


solve satisfy;

output["x = \(x)  ", "y = \(y)  ", " z = \(z)  "];
