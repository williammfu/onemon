/*Implementasi peta dalam permainan*/
% Variabel dynamic (nilainya berubah-ubah)
:- dynamic(playLoc/2).

/*Inisialisasi awal*/
playLoc(1,1). %Posisi awal player selalu (1,1)
skyLoc(5,6).

/*Deklarasi Rules*/
kompas :- 
    playLoc(X,Y),skyLoc(X,Y),nl,
    write('Anda berada pada Skypiea!'),nl,
    write('= = = K A S A T U = = ='),nl,!.

kompas :- 
    nl,
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
    write('~ '),
    Next is Y+1,
    printmap(X, Next),!.
     
move(n) :-
    playLoc(X,Y),
    Prev is X-1,
    write('Berlayar ke utara. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(Prev,Y)),!.

move(s) :-
    playLoc(X,Y),
    Next is X+1,
    write('Berlayar ke selatan. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(Next,Y)),!.

move(e) :-
    playLoc(X,Y),
    Next is Y+1,
    write('Berlayar ke timur. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Next)),!.
    
move(w) :-
    playLoc(X,Y),
    Prev is Y-1,
    write('Berlayar ke barat. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Prev)),!.    