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

var set of TYPE: types; %type satisfaction
constraint card(types)<=maxPokeTeam*maxAttackPoke;

constraint forall(i in TYPE) (exists(k in types)( 
    i in typeffective[k]));

var set of ATTACK: attks;
constraint forall(i in types)(exists(j in attks)(attacktype[j] = i));
constraint card(attks) = card(types);

var set of POKEMON: pkm;
constraint card(pkm) <= maxAttackPoke;
constraint forall(i in attks)(exists(p in pkm)(i in pokattacks[p]));

output [show(types)++","++show(attks)++","++show(pkm)];

solve satisfy;