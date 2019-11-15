:-include('pirate.pl').

:- dynamic(is_pick/1).
is_pick(0).

battle:-
    write('Saatnya berperang, kapten!'), nl,
    write('Pilih kru Anda!'), nl, 
    print_inventori,
    
    repeat,
        write('> '), read(Name),
        pick(Name),
    end_pick,

    repeat,
        pirate(A,Name,Hp1,1),
        pirate(137,Y,Hp2,0),
        write('Kami menunggu perintah anda, kapten!'), nl,
        write('Perintah Anda: '),read(Command),
        do_battle(Command),       
    battle_ends.

% do_battle(pick(X)) :- pick(X),!.
do_battle(attack) :- 
    pirate(Kode1,X,Hp1,1),
    pirate(Kode2,Y,Hp2,0),
    normalAtt(X,Y),!.
do_battle(special) :-
    pirate(Kode1,X,Hp1,1),
    pirate(Kode2,Y,Hp2,0),
    specialAtt(X,Y),!. 
do_battle(_) :- 
    write('Instruksi tidak jelas, kapten!'),nl,
    write('Ulangi!'),nl,nl,!.

pick(NAME) :-
    pirate(_,NAME,_,0),
    write('Siapa itu, Kapten?! Pilih kru lain.'),nl,nl,!.
pick(NAME) :-
    pirate(_,NAME,_,1),
    write('gas'), nl,nl, 
    retract(is_pick(0)),
    asserta(is_pick(1)),!.
pick(_) :-
    write('Anda mabuk, kapten?'),nl,nl,!.


end_pick :-
    is_pick(1).

battle_ends :-
    pirate(_,X,Hp1,1),
    Hp1 =< 0,
    write('Sayang sekali kapten. . .'),nl,
    write(X), write(' gugur dalam perang.'),nl,!.
battle_ends :-
    pirate(_,Y,Hp2,0),
    Hp2 =< 0,
    write('Selamat, kapten !'), nl,
    write(Y), write(' berhasil dikalahkan!'),nl,!.
