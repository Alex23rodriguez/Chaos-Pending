/*
    Constraint Programming
    Assigment 1

    Alejandro Rodriguez
    06.11.2019
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
array[POKEMON] of TYPE: poketype; %NOT USED
%Type of each Attack
array[ATTACK] of TYPE: attacktype;
%An attack of a concrete type (index) is super effective against these types (values)
array[TYPE] of set of TYPE: typeffective;

% start
array[POKEMON] of var set of ATTACK: attks; % attacks per pokemon
var set of POKEMON: pkm; % pokemon used

constraint card(pkm) <= maxPokeTeam;
constraint forall(p in POKEMON diff pkm)(card(attks[p])=0);
constraint forall(p in pkm)(card(attks[p])<=maxAttackPoke);
constraint forall(i in TYPE)(exists(j in attks, k in j)(i in typeffective[attacktype[k]]));
constraint forall(p in pkm, i in attks[p])(i in pokattacks[p]);

output ["Pokemon: \(pkm)\nAttacks: {"];
output [if card(i) > 0 then "\(i)," else "" endif | i in fix(attks)];
output ["}"];

solve satisfy;