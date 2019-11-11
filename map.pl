:-include('pirate.pl').
/*Implementasi peta dalam permainan*/
% Variabel dynamic (nilainya berubah-ubah)
:- dynamic(playLoc/2).
:- dynamic(inventori/1).


/*Inisialisasi awal*/
playLoc(1,1). %Posisi awal player selalu (1,1)
skyLoc(6,5).

/*Deklarasi Rules*/
kompas :- 
    playLoc(X,Y),skyLoc(X,Y),
    write('Anda berada pada Skypiea!'),nl,
    write('= = = K A S A T U = = ='),nl,!.

kompas :- 
    write('Anda membuka peta anda'), nl, 
    write('Ini lokasi anda'),nl,nl,
    write('= = = K A S A T U = = ='),nl,!.


printmap(11,11) :- write('X'),nl,!.
printmap(X,11) :-
    write('X'),nl,
    Next is X+1,
    printmap(Next,0),!.

printmap(0,X) :-
    write('X '),
    Next is X+1,
    printmap(0,Next),!.

printmap(X,0) :- 
    write('X '),  
    printmap(X,1),!.

printmap(11,X) :-
    write('X '),
    Next is X+1,
    printmap(11,Next),!.

printmap(X,Y) :-
    playLoc(X,Y),
    write('P '),
    Next is Y+1,
    printmap(X,Next),!.

printmap(X,Y) :- 
    skyLoc(X,Y),
    write('S '),
    Next is Y+1,
    printmap(X,Next),!.

printmap(X,Y) :-
    write('_ '),
    Next is Y+1,
    printmap(X, Next),!.

move(n) :- playLoc(1,_), write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.      
move(n) :-
    playLoc(X,Y),
    Prev is X-1,
    write('Berlayar ke utara. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(Prev,Y)),!.

move(s) :- playLoc(10,_), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(s) :-
    playLoc(X,Y),
    Next is X+1,
    write('Berlayar ke selatan. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(Next,Y)),!.

move(e) :- playLoc(_,10), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(e) :-
    playLoc(X,Y),
    Next is Y+1,
    write('Berlayar ke timur. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Next)),!.

move(w) :- playLoc(_,1), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(w) :-
    playLoc(X,Y),
    Prev is Y+1,
    write('Berlayar ke barat. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Prev)),!.    

inventori(X) :-
    pirate(_,_,_,1),
    X1 is X+1,
    X is X1.

print_inventori :-
    pirate(_,NAME,HEALTH,1),
    type(NAME,TYPE), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl.

print_enemy :-
    pirate(_,NAME, HEALTH, 0),
    legend(NAME), 
    type(NAME,TYPE), 
    write('Nama             : '),
    write(NAME), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Tipe             : '),
    write(TYPE), nl, nl.

