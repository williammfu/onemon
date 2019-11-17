:- include('map.pl').
% Variable dynamic
:-dynamic(pirate/4).
:-dynamic(pirLoc/3).
:-dynamic(inventory/2).
:-dynamic(invEnemy/2).
:-dynamic(invTotal/1).
:-dynamic(is_ok/1).

% Inisialisasi pirate
% pirate(kode,name,health, kepemilikan)
% normal = kode 130 - 139
pirate(130, luffy, 78, 1).
pirate(131, usop, 70, 0).
pirate(132, chopper, 60, 0).
pirate(133, zoro, 63, 0).
pirate(134, rayleigh,62, 0).
pirate(135, robin, 75, 0).
pirate(136, franky, 59, 0).
pirate(137, sanji, 58, 0).
pirate(138, nami, 66, 0).
pirate(139, doflamingo, 71, 0).
pirate(140, jinbei, 60, 0).

% legendary = kode 140 - 144
pirate(141, bigMama, 247, 0).
pirate(142, rakhamon, 288, 0).

/* health(X,Y) artinya Pirate X memiliki initial health senilai Y */
health(luffy,73).
health(usop,70).
health(chopper,50).
health(zoro,53).
health(rayleigh,52).
health(robin,75).
health(franky,49).
health(sanji,48).
health(nami,46).
health(doflamingo,71).
health(jinbei,50).
health(bigMama,247).
health(rakhamon,288).

% pirLoc(Kode, Posisi X, Posisi Y)
% initial state : lokasi 0,0 (undefined)
pirLoc(131, 0, 0).
pirLoc(132, 0, 0).
pirLoc(133, 0, 0).
pirLoc(134, 0, 0).
pirLoc(135, 0, 0).
pirLoc(136, 0, 0).
pirLoc(137, 0, 0).
pirLoc(138, 0, 0).
pirLoc(139, 0, 0).
pirLoc(140, 0, 0).
pirLoc(141, 0, 0).
pirLoc(142, 0, 0).

% inventory(Jumlah, List)
inventory(1,[130]).
% invEnemy(Jumlah, List)
invEnemy(2,[141,142]).
% invTotal(List)
invTotal([131,132,133,134,135,136,137,138,139,140,141,142]).
printLocc :- invTotal(List), printLoc(List).
printLoc([]) :- !.
printLoc([Idx|Tail]) :-
	pirate(Idx,Name,_,_), pirLoc(Idx,X,Y),
	write(Name),write('('), write(X),write(','),write(Y),write(')'),nl, 
	printLoc(Tail).

% Taruh pirate di peta secara random
is_ok(0).
check_put(Idx) :- pirLoc(Idx,X,Y), skyLoc(A,B), X==A, Y==B,!.
check_put(Idx) :- pirLoc(Idx,X,Y), playLoc(A,B), X==A, Y==B,!.
check_put(Idx) :- pirLoc(Idx,X,Y), pirLoc(Other,A,B), Idx\==Other, X==A, Y==B,!.
check_put(_) :- is_ok(0), retract(is_ok(0)), asserta(is_ok(1)).

random_putt :- invTotal(List), random_put(List),!.
random_put([]) :- !.
random_put([Idx|Tail]) :- 
	
	retract(is_ok(_)), asserta(is_ok(0)),
	repeat,
		put_pirate(Idx),
		check_put(Idx), 
	done, % check final state : oke = engga bertubrukan
	random_put(Tail). % rekursif

done :- is_ok(1).

put_pirate(Idx):-

    random(1,10,X), random(1,10,Y),
    pirLoc(Idx,_,_),
    retract(pirLoc(Idx,_,_)),
    asserta(pirLoc(Idx,X,Y)).

/* normal(X) artinya X merupakan Pirate tipe normal */
% normal(luffy).
% normal(usop).
% normal(chopper).
% normal(zoro).
% normal(rayleigh).
% normal(robin).
% normal(franky).
% normal(sanji).
% normal(nami).
% normal(doflamingo).
% normal(jinbei).

/* legend(X) artinya X merupakan Pirate tipe legend */
legend(bigMama).
legend(rakhamon).

/* type(X,Y,Z) artinya X memiliki type Y dengan nama serangan Z*/
/* jenis type: fighter, shooter, swordsman */
type(luffy, fighter, rubber_Rush).
type(sanji, fighter, black_Leg_Style).
type(bigMama, shooter, haoshoku_Haki).
type(nami, shooter, clima_Tact).
type(usop, shooter, usopp_Boomerang).
type(chopper,soldier, rumble_Ball).
type(rayleigh,soldier, busoshoku_Haki).
type(zoro,swordsman, santoryu).
type(robin,swordsman, seis_Fleur).
type(franky,bandit, coup_De_Vent).
type(doflamingo,bandit, ito_ito_no_mi).
type(jinbei, cyborg, kenbunshoku).
type(rakhamon,cyborg, ekUsuPUroshion).

% weak (tipe , kelemahan tipe tsb)
weak(fighter,shooter).
weak(shooter,swordsman).
weak(swordsman,fighter).
weak(cyborg, bandit).
weak(bandit, soldier).
weak(soldier, cyborg).

/* damage(X,Y) artinya X menimbulkan damage sebesar Y */
damage(luffy,27).
damage(usop,28).
damage(chopper,36).
damage(zoro,38).
damage(rayleigh,36).
damage(robin,28).
damage(franky,20).
damage(sanji,28).
damage(nami,34).
damage(doflamingo,35).
damage(jinbei,32).

% legendary : damage lebih besar
damage(bigMama,52).
damage(rakhamon,60).

/* skill(X,Y) artinya X memiliki nilai damage skill sebesar Y */ 
skill(X,Y) :- 
	damage(X,Z),
	Y is 3*Z/2.

%%%%%%%%%%%%%%%%%%% Normal Attack %%%%%%%%%%%%%%%%%%%
show_stats(Opp,Att) :-
	
	nl,pirate(_,Opp,HpOpp,_),type(Opp,TypeOpp,_),
	pirate(_,Att,HpAtt,_),type(Att,TypeAtt,_),
	HpOpp >= 0, HpAtt >= 0,
	write(Opp),nl,
	write('Health: '),write(HpOpp),nl,
	write('Type: '),write(TypeOpp),nl,nl,
	write(Att),nl,
	write('Health: '),write(HpAtt),nl,
	write('Type: '),write(TypeAtt),nl,nl,!.

show_stats(Opp,Att) :-

	nl,pirate(_,Opp,HpOpp,_),type(Opp,TypeOpp,_),
	pirate(_,Att,HpAtt,_),type(Att,TypeAtt,_),
	HpOpp =< 0, HpAtt >= 0,
	write(Opp),nl,
	write('Health: '),write('0'),nl,
	write('Type: '),write(TypeOpp),nl,nl,
	write(Att),nl,
	write('Health: '),write(HpAtt),nl,
	write('Type: '),write(TypeAtt),nl,nl,!.

normalAtt(Att,Def) :- % Att lemah dari Def, damage diterima Def - 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,_), 
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeAtt,TypeDef), 
	damage(Att,W), W1 is W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menyerang '), write(Def), nl,
	write('Serangan yang lemah. . .'),nl,
	write('Damage : '),write(W1),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),
	show_stats(Def,Att),!.

normalAtt(Att,Def):- % Def lemah dari Att, damage diterima Def + 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,_),
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeDef,TypeAtt), 
	damage(Att,W), W1 is 3*W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menyerang '), write(Def), nl,
	write('Serangan yang bagus!'),nl,
	write('Damage : '),write(W1),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),show_stats(Def,Att),!.

normalAtt(Att,Def):- % Att dan Def bertipe sama
	
	pirate(_,Att,_,_),
	pirate(Kode,Def,OldHp,Opp),
	
	damage(Att,W), NewHp is OldHp - W,
	
	write(Att), write(' menyerang '), write(Def), nl,
	write('Damage : '),write(W),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),show_stats(Def,Att),!.


%%%%%%%%%%%%%%%%%%% Special Attack %%%%%%%%%%%%%%%%%%%
specialAtt(Att,Def) :- % Att lemah dari Def, damage diterima Def - 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,Aksi), 
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeAtt,TypeDef), 
	skill(Att,W), W1 is W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	write('Ah. . . Serangannya kurang bagus, kapten!'), nl,
	write('Damage : '),write(W1),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),show_stats(Def,Att),!.

specialAtt(Att,Def):- % Def lemah dari Att, damage diterima Def + 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,Aksi),
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeDef,TypeAtt), 
	skill(Att,W), W1 is 3*W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	write('Astaga! Serangan yang sangat hebat!!'), nl,
	write('Damage : '),write(W1),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),show_stats(Def,Att),!.

specialAtt(Att,Def):- % Att dan Def bertipe sama
	
	pirate(_,Att,_,_), type(Att,_,Aksi),
	pirate(Kode,Def,OldHp,Opp), type(Def,_,_),
	
	skill(Att,W), NewHp is OldHp - W,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	write('Damage : '),write(W),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),show_stats(Def,Att),!.

%%%%%%%%%%%%%%%%%%% Pengolahan Inventory %%%%%%%%%%%%%%%%%%%
% add item pada list

add(X,[],[X]).
add(X,[Y|T],[Y|T2]):-
    add(X,T,T2).

% sub( indeks yang mau, list input, list hasil)
sub(_, [], []).
sub(X, [X|T], T2) :-
	sub(X, T, T2).
sub(X, [H|T], [H|T2]) :-
	H \== X,
	sub(X, T, T2), !.

%add_inv( indeks pirate yang mau di tambah)
add_inv(X) :-
	pirate(X,_,_,1),
	inventory(A, CurrInv),
	B is A +1,
	add(X,CurrInv,NewInv),
	retract(inventory(A, CurrInv)),
	asserta(inventory(B, NewInv)),!.

% add_inv(X) :-
% 	pirate(X,NAME,_,0),
% 	legend(NAME),
% 	invEnemy(A, CurrInv),
% 	B is A+1,
% 	add(X,CurrInv,NewInv),
% 	health(NAME, H),
% 	retract(invEnemy(A, CurrInv)),
% 	asserta(invEnemy(B, NewInv)),
% 	retract(pirate(X,NAME,_,0)),
% 	asserta(pirate(X,NAME,H,1)),!.

	
%sub_inv (indeks pirate yang mati)
sub_inv(X) :-
	pirate(X,_,_,1),
	inventory(A, CurrInv),
	B is A-1,
	sub(X,CurrInv,NewInv),
	retract(inventory(A, CurrInv)),
	asserta(inventory(B, NewInv)),!.

sub_inv(X) :-
	pirate(X,NAME,_,0),	%Menghapus legend
	legend(NAME),
	invEnemy(A, CurrInv),
	B is A-1,
	sub(X,CurrInv,NewInv),
	retract(invEnemy(A, CurrInv)),
	asserta(invEnemy(B, NewInv)).

print_inventory([]).
print_inventory([H|Sisa]) :-
    pirate(H,NAME,HEALTH,1), type(NAME,TYPE,_),
    write(NAME), nl,
    write('Health           : '), write(HEALTH), nl,
    write('Tipe             : '), write(TYPE), nl, nl, 
	print_inventory(Sisa).

print_enemy([]):-!.	
print_enemy([H|Sisa]) :-
    pirate(H,NAME, HEALTH, 0), legend(NAME), type(NAME,TYPE,_),
    write(NAME), nl,
    write('Health           : '), write(HEALTH), nl,
    write('Tipe             : '), write(TYPE), nl, nl,
	print_enemy(Sisa). %rekursif
