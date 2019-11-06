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
array[POKEMON] of var set of ATTACK: attks; % attacks per pokemon
var set of POKEMON: pkm; % pokemon used

constraint card(pkm) <= maxPokeTeam;
constraint forall(p in POKEMON diff pkm)(card(attks[p])=0);
constraint card(types)<=maxPokeTeam*maxAttackPoke;
constraint forall(i in TYPE) (exists(k in types)(i in typeffective[k])); % all weaknesses coovered
constraint forall(p in pkm)(card(attks[p])<=maxAttackPoke);
constraint forall(i in types)(exists(j in attks, k in j)(attacktype[k] = i));
constraint forall(j in attks, k in j)(attacktype[k] in types);
constraint forall(p in pkm, i in attks[p])(i in pokattacks[p]);

%output [show("Pokemon: \(pkm)")++"\n"++show("Attacks: ")++{if card(i)>0 then "\(i)" else "" endif where i in attks}];
output ["\(types)\n"];
output ["Pokemon: \(pkm)\nAttacks: "];
output [if card(i) > 0 then "\(i)," else "" endif | i in fix(attks)];

solve satisfy;