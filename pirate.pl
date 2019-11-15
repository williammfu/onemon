/* ATRIBUT ONE-MON */
:-dynamic(pirate/4).
:-dynamic(pirLoc/3).
:-dynamic(inventory/2).
:-dynamic(invEnemy/2).

% Inisialisasi pirate
% pirate(kode,name,health, kepemilikan)
% normal = kode 130 - 139
pirate(130, ace, 73, 1).
pirate(131, usop,70, 0).
pirate(132, tony,48, 1).
pirate(133, law,43, 0).
pirate(134, rayleigh,38, 0).
pirate(135, newgate,75, 0).
pirate(136, dragon,41, 0).
pirate(137, katakuri,33, 0).
pirate(138, vinsmoke,46, 0).
pirate(139, doflamingo,71, 0).

% legendary = kode 140-144
% pirate(140, luffy, 235, 0).
% pirate(141, zoro, 265, 0).
% pirate(142, sanji, 123, 0).
pirate(143, bigMama, 247, 0).
pirate(144, rakhamon, 288, 0).

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
pirLoc(143, 0, 0).
pirLoc(144, 0, 0).

% inventory(Jumlah, List)
inventory(2,[130,132]).
% invEnemy(Jumlah, List)
invEnemy(2,[143,144]).

% Taruh pirate di peta secara random --belum jadi
put_pirate(0).
put_pirate(1) :-

	random(130,139,X),
	pirate(X,Name,_,0),
	pirLoc(X,_,_),

	random(1,10,PosX), random(1,10,PosY),
	retract(pirLoc(X,_,_)),
	asserta(pirLoc(X,PosX,PosY)),

	write(Name),write(' berada di '),
	write('('), write(PosX),write(','), write(PosY),write(')'),nl,!.

put_pirate(N) :-

	random(130,139,X),
	pirate(X,Name,_,0),
	pirLoc(X,_,_),

	random(1,10,PosX), random(1,10,PosY),
	retract(pirLoc(X,_,_)),
	asserta(pirLoc(X,PosX,PosY)),

	write(Name),write(' berada di '),
	write('('), write(PosX),write(','), write(PosY),write(')'),nl,
	
	N1 is N-1,
	put_pirate(N1),!. 


/* normal(X) artinya X merupakan Pirate tipe normal */
% normal(ace).
% normal(usop).
% normal(tony).
% normal(law).
% normal(rayleigh).
% normal(newgate).
% normal(dragon).
% normal(katakuri).
% normal(vinsmoke).
% normal(doflamingo).

/* legend(X) artinya X merupakan Pirate tipe legend */
legend(luffy).
legend(zoro).
legend(sanji).
legend(bigMama).
legend(rakhamon).

/* health(X,Y) artinya Pirate X memiliki health senilai Y */
health(ace,73).
health(usop,70).
health(tony,48).
health(law,43).
health(rayleigh,38).
health(newgate,75).
health(dragon,41).
health(katakuri,33).
health(vinsmoke,46).
health(doflamingo,71).
health(luffy,235).
health(zoro,265).
health(sanji,123).
health(bigMama,247).
health(rakhamon,288).

/* type(X,Y) artinya X memiliki type Y */
/* jenis type: fighter, shooter, swordsman */
type(ace,fighter).
type(usop,shooter).
type(tony,fighter).
type(law,swordsman).
type(rayleigh,swordsman).
type(newgate,swordsman).
type(dragon,fighter).
type(katakuri,fighter).
type(vinsmoke,shooter).
type(doflamingo,fighter).
type(luffy,fighter).
type(zoro,swordsman).
type(sanji,fighter).
type(bigMama,shooter).
type(rakhamon,shooter).

/* damage(X,Y) artinya X menimbulkan damage sebesar Y */
damage(ace,20).
damage(usop,28).
damage(tony,36).
damage(law,44).
damage(rayleigh,36).
damage(newgate,28).
damage(dragon,20).
damage(katakuri,28).
damage(vinsmoke,36).
damage(doflamingo,44).
damage(luffy,50).
damage(zoro,52).
damage(sanji,54).
damage(bigMama,56).
damage(rakhamon,58).

/* skill(X,Y) artinya X memiliki nilai damage skill sebesar Y */ 
skill(X,Y) :- 
	damage(X,Z),
	Y is 3*Z/2.

/* normalAtt(X,Y) artinya X melakukan normal attack kepada Y */ 
normalAtt(X,Y) :- /* fighter -> shooter, damage - 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,fighter), type(Y,shooter),
	damage(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.
	
normalAtt(X,Y) :- /* shooter -> swordsman, damage - 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,shooter), type(Y,swordsman),
	damage(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

normalAtt(X,Y) :- /* swordsman -> fighter, damage - 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,swordsman), type(Y,fighter),
	damage(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

normalAtt(X,Y) :- /* shooter -> fighter, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,shooter), type(Y,fighter),
	damage(X,W),
	W1 is 3*W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

normalAtt(X,Y) :- /* swordsman -> shooter, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,swordsman), type(Y,shooter),
	damage(X,W),
	W1 is 3*W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

normalAtt(X,Y) :- /* fighter -> swordsman, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,fighter), type(Y,swordsman),
	damage(X,W),
	W1 is 3*W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.
	
normalAtt(X,Y) :-
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,_), type(Y,_),
	damage(X,W), NewHp is Hp2-W,
	write(X), write(' menyerang '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :-
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,fighter), type(Y,shooter),
	skill(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :- /* shooter -> swordsman, damage - 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,shooter), type(Y,swordsman),
	skill(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :- /* swordsman -> fighter, damage - 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,swordsman), type(Y,fighter),
	skill(X,W),
	W1 is W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :- /* shooter -> fighter, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,shooter), type(Y,fighter),
	skill(X,W),
	W1 is 3*W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :- /* swordsman -> shooter, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,swordsman), type(Y,shooter),
	skill(X,W),
	W1 is 3*W/2, NewHp is Hp2 - W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

specialAtt(X,Y) :- /* fighter -> swordsman, damage + 50% */
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),	
	type(X,fighter), type(Y,swordsman),
	skill(X,W),
	W1 is 3*W/2, NewHp is Hp2-W1,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.
	
specialAtt(X,Y) :-
	pirate(_,X,_,_), pirate(B,Y,Hp2,Opp),
	type(X,_), type(Y,_),
	skill(X,W), NewHp is Hp2-W,
	write(X), write(' menyerang istimewa '), write(Y), nl,nl,
	retract(pirate(B,Y,Hp2,Opp)),
	asserta(pirate(B,Y,NewHp,Opp)),!.

add(X,[],[X]).
add(X, [H|T], T2) :-
	add(X, T, T2).

% sub( indeks yang mau, list input, list hasil)
sub(_, [], []).
sub(X, [X|T], T2) :-
	sub(X, T, T2).
sub(X, [H|T], [H|T2]) :-
	H \== X,
	sub(X, T, T2), !.

%add_inv( indeks pirate yang mau di tambah)
add_inv(X) :-
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
	B is A +1,
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

print_inventori([]),!.
print_inventori([H|Sisa]) :-
    pirate(H,NAME,HEALTH,1),
    type(NAME,TYPE), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl, 
	print_inventori(Sisa).

print_enemy([]) ,!.	
print_enemy([H|Sisa]) :-
    pirate(H,NAME, HEALTH, 0),
    legend(NAME), 
    type(NAME,TYPE), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl,
	print_enemy(Sisa).
