/*Implementasi peta dalam permainan*/
% Variabel dynamic (nilainya berubah-ubah)
:- dynamic(playLoc/2).

/*Inisialisasi awal*/
playLoc(1,1). %Posisi awal player selalu (1,1)

/*Deklarasi Rules*/
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

% printmap(X,Y) :- 
%     gymLoc(X,Y),
%     write('G '),
%     Next is Y+1,
%     printmap(X,Next),!.

printmap(X,Y) :-
    write('_ '),
    Next is Y+1,
    printmap(X, Next),!.

move(n) :- playLoc(1,_), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.      
move(n) :-
    playLoc(X,Y),
    Prev is X-1,
    retract(playLoc(X,Y)),
    asserta(playLoc(Prev,Y)),!.

move(s) :- playLoc(10,_), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(s) :-
    playLoc(X,Y),
    Next is X+1,
    retract(playLoc(X,Y)),
    asserta(playLoc(Next,Y)),!.

move(e) :- playLoc(_,10), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(e) :-
    playLoc(X,Y),
    Next is Y+1,
    write('Berlayar ke timur'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Next)),!.

move(w) :- playLoc(_,1), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
move(w) :-
    playLoc(X,Y),
    Prev is Y+1,
    write('Berlayar ke barat'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Prev)),!.    