/*
    Constraint Programming
    Assigment 5

    Alejandro Rodriguez
    229564
    03.12.2019
*/

include "alldifferent.mzn";
%include "lex_lesseq.mzn";

int: W = 0; % white (empty) cells
int: B = -1; % black (forbidden) cells

% Definition of the problem
int: rows;
%set of 1..rows: ROW;
int: cols;
%set of 1..cols: COL;
array[1..rows, 1..cols] of int: problem;

% Length of the loop
int: max_steps;

% implementation
array[1..max_steps] of var 1..cols: x;
array[1..max_steps] of var 1..rows: y;

%array[1..max_steps] of var int: xy;
%constraint forall(i in 1..max_steps)(xy[i] = x[i]*64 + y[i]);
%constraint alldifferent(xy);

constraint forall(i in 1..max_steps-1)(abs(x[i]-x[i+1]) + abs(y[i]-y[i+1])=1);
constraint abs(x[1]-x[max_steps]) + abs(y[1]-y[max_steps])=1;

constraint let {array[1..max_steps] of var int: xy = [x[i]*64+y[i] | i in 1..max_steps]} in alldifferent(xy);
constraint forall(i in 1..max_steps)(problem[y[i], x[i]]!=-1);

%symmetry breaking
constraint forall(i in 2..max_steps)(x[1]*64+y[1] < x[i]*64+y[i]); %starting point symmetry
constraint x[1] == x[2]; % direction symmetry

output ["\nx: \(x), \ny: \(y)\npoints: ["];
output ["\(problem[y[i], x[i]]), " | i in 1..max_steps];
output ["]\nsum_points: \(sum(i in 1..max_steps)(problem[y[i], x[i]]))"];

solve maximize sum(i in 1..max_steps)(problem[y[i], x[i]]);