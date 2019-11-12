/*
    Constraint Programming
    Assigment 2

    Alejandro Rodriguez
    229564
    12.11.2019
*/

include "alldifferent_except_0.mzn";

int: n; % number of guests
set of int: GUEST = 1..n;
int: president = 1;
array[GUEST] of int: rank;
array[GUEST] of int: ability;

int: m; % number of horses
set of int: HORSE = 1..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;

array[GUEST,HORSE] of int: enjoy;

array[GUEST] of var 0..m: horses;
array[HORSE] of var 0..n: horses_inv;

constraint forall(i in 1..n where horses[i]>0)(horses_inv[horses[i]] = i);

constraint alldifferent_except_0(horses);
constraint forall(i in 2..n where horses[i]>0)(enjoy[president, horses[president]] > enjoy[i, horses[i]]);
constraint forall(i in 1..n, j in 1..n where i!=j)((rank[i]<=rank[j]) \/ (beauty[horses[i]]>=beauty[horses[j]]) \/ (horses[j]=0));
constraint forall(i in 1..m, j in 1..m where i!=j)((speed[i]<=speed[j]) \/ (ability[horses_inv[i]]>=ability[horses_inv[j]]) \/ (horses_inv[i]=0));
constraint sum(i in 1..n where horses[i]>0)(1) = min(m,n);
constraint sum(i in 1..m where horses_inv[i]>0)(1) = min(m,n);

constraint forall(i in 1..n where horses[i]!=0)(enjoy[i, horses[i]]>=0);

output["horse: \(horses)\n"];

solve satisfy;