/*
    Constraint Programming
    Assigment 6

    Alejandro Rodriguez
    229564
    11.12.2019
*/

% Maximum number of boat travels
int: T;
% Organisms to move to the other side of the river
enum ORG;
% Maximum number of passengers that can travel in the boat at the same time
int: passengers;
% Compatibilities between organisms (false means they cannot stay together without supervision)
array[ORG,ORG] of bool: compatibility; 


%implementation
array[1..T] of var set of ORG: left;
array[1..T] of var set of ORG: right;
%array[1..T] of var set of ORG: right = [ORG diff left[i] | i in 1..T];

var 1..T: steps;

constraint forall(i in 1..steps)(right[i] = ORG diff left[i]);
%start
constraint left[1]=ORG;
%finish
constraint right[steps]=ORG;

%limit passengers
constraint forall(i in 1..steps-1 where (i mod 2) = 1)(card(left[i] intersect right[i+1]) <= passengers);
constraint forall(i in 1..steps-1 where (i mod 2) = 0)(card(right[i] intersect left[i+1]) <= passengers);

%mantain sides
%trip left to right:
constraint forall(i in 3..steps-1 where (i mod 2)=1)(card(right[i] intersect left[i+1]) = 0);
%trip right to left:
constraint forall(i in 2..steps-1 where (i mod 2)=0)(card(left[i] intersect right[i+1]) = 0);

%peaceful trips to the right
constraint forall(i in 2..steps, j in left[i], k in left[i] where (i mod 2)=0)(compatibility[j,k]);
%peaceful trips to the left
constraint forall(i in 1..steps, j in right[i], k in right[i] where (i mod 2)=1)(compatibility[j,k]);


output [let {set of ORG: trips = (fix(left)[i] diff fix(left)[i+1]) union (fix(right)[i] diff fix(right)[i+1])} in if(i mod 2)=1 then "From Left to Right with \(trips)\n" else "From Right to Left with \(trips)\n" endif| i in 1..fix(steps)-1];
output["Steps: \(steps-1)"];


solve satisfy;
%solve minimize steps;