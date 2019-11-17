:- include('map.pl').
% Variable dynamic
:-dynamic(pirate/4).
:-dynamic(pirLoc/3).
:-dynamic(inventory/2).
:-dynamic(invEnemy/2).
:-dynamic(invTotal/1).

% Inisialisasi pirate
% pirate(kode,name,health, kepemilikan)
% normal = kode 130 - 139
pirate(130, luffy, 73, 1).
pirate(131, usop, 70, 0).
pirate(132, chopper, 48, 0).
pirate(133, zoro, 43, 0).
pirate(134, rayleigh,42, 0).
pirate(135, robin, 75, 0).
pirate(136, franky, 41, 0).
pirate(137, sanji, 38, 0).
pirate(138, nami, 46, 0).
pirate(139, doflamingo, 71, 0).

% legendary = kode 140 - 144
pirate(140, bigMama, 247, 0).
pirate(141, rakhamon, 288, 0).

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

% inventory(Jumlah, List)
inventory(2,[130]).
% invEnemy(Jumlah, List)
invEnemy(2,[140,141]).
% invTotal(List)
invTotal([131,132,133,134,135,136,137,138,139,140,141]).

% Taruh pirate di peta secara random
random_put(131) :- put_pirate(131),!.
random_put(Idx) :-

	put_pirate(Idx),
	PrevIdx is Idx - 1,
	random_put(PrevIdx).
	
put_pirate(Idx):-

    repeat,
        random(1,10,X), random(1,10,Y),
        pirLoc(Idx,_,_),
        retract(pirLoc(Idx,_,_)),
        asserta(pirLoc(Idx,X,Y)),
    okayLoc(Idx).

okayLoc(Idx):-

    pirLoc(Idx,X,Y), pirLoc(Other,A,B),
	Idx \== Other, X==A, Y==B,!,fail,
    skyLoc(C,D),
    X==C, Y==D,!,fail.

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

/* legend(X) artinya X merupakan Pirate tipe legend */

legend(bigMama).
legend(rakhamon).

/* health(X,Y) artinya Pirate X memiliki health senilai Y */
health(luffy,73).
health(usop,70).
health(chopper,48).
health(zoro,43).
health(rayleigh,38).
health(robin,75).
health(franky,41).
health(sanji,33).
health(nami,46).
health(doflamingo,71).
health(bigMama,247).
health(rakhamon,288).

/* type(X,Y,Z) artinya X memiliki type Y dengan nama serangan Z*/
/* jenis type: fighter, shooter, swordsman */
type(luffy,fighter, rubber_Rush).
type(usop,shooter, usopp_Boomerang).
type(chopper,fighter, rumble_Ball).
type(zoro,swordsman, santoryu).
type(rayleigh,swordsman, busoshoku_Haki).
type(robin,swordsman, seis_Fleur).
type(franky,fighter, coup_De_Vent).
type(sanji,fighter, black_Leg_Style).
type(nami,shooter, clima_Tact).
type(doflamingo,fighter, ito_ito_no_mi).
type(bigMama,shooter, haoshoku_Haki).
type(rakhamon,shooter, ekusupuroshion).

% weak (tipe , kelemahan tipe tsb)
weak(fighter,shooter).
weak(shooter,swordsman).
weak(swordsman,fighter).

/* damage(X,Y) artinya X menimbulkan damage sebesar Y */
damage(luffy,22).
damage(usop,28).
damage(chopper,36).
damage(zoro,44).
damage(rayleigh,36).
damage(robin,28).
damage(franky,20).
damage(sanji,28).
damage(nami,36).
damage(doflamingo,44).
% legendary : damage lebih besar
damage(bigMama,56).
damage(rakhamon,58).

/* skill(X,Y) artinya X memiliki nilai damage skill sebesar Y */ 
skill(X,Y) :- 
	damage(X,Z),
	Y is 3*Z/2.

%%%%%%%%%%%%%%%%%%% Normal Attack %%%%%%%%%%%%%%%%%%%
normalAtt(Att,Def) :- % Att lemah dari Def, damage diterima Def - 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,_), 
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeAtt,TypeDef), 
	damage(Att,W), W1 is W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menyerang '), write(Def), nl,
	write('Serangan yang lemah. . .'),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.

normalAtt(Att,Def):- % Def lemah dari Att, damage diterima Def + 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,_),
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeDef,TypeAtt), 
	damage(Att,W), W1 is 3*W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menyerang '), write(Def), nl,
	write('Serangan yang bagus!'),nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.

normalAtt(Att,Def):- % Att dan Def bertipe sama
	
	pirate(_,Att,_,_),
	pirate(Kode,Def,OldHp,Opp),
	
	damage(Att,W), NewHp is OldHp - W,
	
	write(Att), write(' menyerang '), write(Def), nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.


%%%%%%%%%%%%%%%%%%% Special Attack %%%%%%%%%%%%%%%%%%%
specialAtt(Att,Def) :- % Att lemah dari Def, damage diterima Def - 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,Aksi), 
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeAtt,TypeDef), 
	skill(Att,W), W1 is W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	write('Ah. . . Serangannya kurang bagus, kapten!'), nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.

specialAtt(Att,Def):- % Def lemah dari Att, damage diterima Def + 50%
	
	pirate(_,Att,_,_), type(Att,TypeAtt,Aksi),
	pirate(_,Def,OldHp,_), type(Def,TypeDef,_), 
	
	weak(TypeDef,TypeAtt), 
	skill(Att,W), W1 is 3*W/2, NewHp is OldHp - W1,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	write('Astaga! Serangan yang sangat hebat!!'), nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.

specialAtt(Att,Def):- % Att dan Def bertipe sama
	
	pirate(_,Att,_,_), type(Att,_,Aksi),
	pirate(Kode,Def,OldHp,Opp), type(Def,_,_),
	
	skill(Att,W), NewHp is OldHp - W,
	
	write(Att), write(' menggunakan '), write(Aksi), write(' !!'), nl,
	retract(pirate(Kode,Def,OldHp,Opp)),
	asserta(pirate(Kode,Def,NewHp,Opp)),!.

%%%%%%%%%%%%%%%%%%% Pengolahan Inventory %%%%%%%%%%%%%%%%%%%
% add item pada list
add(X,[],[X]).
add(X, [_|T], T2) :-
	add(X, T, T2).

% sub( indeks yang mau, list input, list hasil)
sub(_, [], []).
sub(X, [X|T], T2) :-
	sub(X, T, T2).
sub(X, [H|T], [H|T2]) :-
	H \== X,
	sub(X, T, T2), !.

%add_inv( indeks pirate yang mau di tambah)
add_inv(_) :-
	inventory(6,_),
	write('Kapal sudah penuh kapten!'),nl,
	write('Usir salah satu kru!'),!.

add_inv(X) :-
	pirate(X,_,_,1),
	inventory(A, CurrInv),
	B is A +1,
	add(X,CurrInv,NewInv),
	retract(inventory(A, CurrInv)),
	asserta(inventory(B, NewInv)),!.

add_inv(X) :-
	pirate(X,NAME,_,0),
	legend(NAME),
	invEnemy(A, CurrInv),
	B is A+1,
	add(X,CurrInv,NewInv),
	health(NAME, H),
	retract(invEnemy(A, CurrInv)),
	asserta(invEnemy(B, NewInv)),
	retract(pirate(X,NAME,_,0)),
	asserta(pirate(X,NAME,H,1)),!.

	
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
	asserta(invEnemy(B, NewInv)),!.

print_inventory([]).
print_inventory([H|Sisa]) :-
    pirate(H,NAME,HEALTH,1),
    type(NAME,TYPE,_), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl, 
	print_inventory(Sisa).

print_enemy([]):-!.	
print_enemy([H|Sisa]) :-
    pirate(H,NAME, HEALTH, 0),
    legend(NAME), 
    type(NAME,TYPE,_), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl,
	print_enemy(Sisa).
