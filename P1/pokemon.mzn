/*
    Constraint Programming
    Assigment 1

    Alejandro Rodriguez
    05.11.2019
*/
int: nPokemon; %Number of pokemons
enum POKEMON;

int: nAttack; %Number of attacks
enum ATTACK;

int: nType; %Number of types
enum TYPE;

int: maxPokeTeam; %The maximum number of Pokemon in a team
set of int: NPOKEMON = 1..maxPokeTeam;

int: maxAttackPoke; %The maximum number of attacks a Pokemon can have
set of int: NATTACK = 1..maxAttackPoke;

%Attacks that each Pokemon can learn
array[POKEMON] of set of ATTACK: pokattacks;
%Type of each Pokemon
array[POKEMON] of TYPE: poketype;
%Type of each Attack
array[ATTACK] of TYPE: attacktype;
%An attack of a concrete type (index) is super effective against these types (values)
array[TYPE] of set of TYPE: typeffective;

% start
%var set of POKEMON: team;
%array[NPOKEMON, NATTACK] of var 1..nAttack: attks = [i | i in ];

%constraint card(team) = maxPokeTeam;
%constraint card(attks) = card(team) * maxAttackPoke;

%constraint exists(i in 1..nAttack)(attks[i]=)

%array[1..maxPokeTeam*maxAttackPoke] of var 1..nPokemon: types; %pokemon
var set of TYPE: types; %pokemon
constraint card(types)<=maxPokeTeam*maxAttackPoke;

constraint forall(i in TYPE) (exists(k in types)( 
    i in typeffective[k]));

%constraint Rock in types;

%output [show(TYPE[i])++show(typeffective[i][j]) | i in TYPE, j in 1..card(typeffective[i])];
%output [show(TYPE[i]) | i in types];
output [show(types)];%| i in types];
%output [show(typeffective[i][j]) | i in TYPE, j in 1..card(typeffective[i])];
%output [show(typeffective[i][j]) | i in types, j in 1..card(typeffective[i])];

solve satisfy;