/*Implementasi peta dalam permainan*/
% Variabel dynamic (nilainya berubah-ubah)
:- dynamic(playLoc/2).
:- dynamic(is_heal/1).

/*Inisialisasi awal*/
playLoc(1,1). %Posisi awal player selalu (1,1)
skyLoc(5,6).
is_heal(0).

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
    Prev is Y-1,
    write('Berlayar ke barat. . .'),nl,
    retract(playLoc(X,Y)),
    asserta(playLoc(X,Prev)),!.    

heal :-

    is_heal(1),
    write('Tidak bisa lagi kapten!'),nl,!.
heal :-

    is_heal(_),
    playLoc(X,Y),skyLoc(A,B),
    X\==A, Y\==B,
    write('Kami tidak berada di Skypiea, kapten!'),nl,!.
 
heal :- % perlu diedit

    is_heal(0),
    write('Anda memutuskan untuk menginap di Skypiea'),nl,
    write('Kru kapal bersemangat kembali kapten!'),nl,
    retract(is_heal(0)),
    asserta(is_heal(1)),!.