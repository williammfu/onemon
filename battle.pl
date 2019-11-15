:- include('pirate.pl').

:- dynamic(is_pick/1).
is_pick(0).

opening_battle :-
    write('Saatnya berperang, kapten!'), nl,
    write('Pilih kru Anda!'), nl, 
    print_inventori.

battle:-
    
    opening_battle,
    
    repeat,
        write('> '), read(Command),
        do_battle(Command),
    end_pick,

    repeat,
        pirate(A,Name,Hp1,1),
        pirate(B,Y,Hp2,0),
        write('Kami menunggu perintah anda, kapten!'), nl,
        write('Perintah Anda: '),read(Command),
        do_battle(Command),       
    battle_ends.

%run 
run(X) :-
    X =:= 1, 
    write('Mau kabur kemana, Kapten?'), nl,
    battle.

    
run(X) :-
    X =:= 2, 
    write('Anda berhasil kabur, Kapten!'), nl,.

% do_battle(pick(X)) :- pick(X),!.
do_battle(pick(_)) :- pick(_),!.
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
    pirate(Num,X,Hp1,1),
    Hp1 =< 0,
    write('Sayang sekali kapten. . .'),nl,
    write(X), write(' jatuh ke tangan lawan!'),nl,
    sub_inv(Num),!.

battle_ends :-
    pirate(ID,Y,Hp2,0),
    Hp2 =< 0,
    write('Selamat, kapten !'), nl,
    write(Y), write(' berhasil dikalahkan!'),nl,
    write('Apakah Anda mau merekrut '), write(Y), write('? [y/n]'),
    read(input),
    rekrut(input, ID),
    !.

rekrut(y, ID) :-
    add_inv(ID), 
    pirate(ID, NAME, _,1),
    write(NAME), write (' berhasil bergabung dalam kru Anda!'), nl.

rekrut(n, ID) :-
    write ('Keputusan yang bijak, Kapten!'), nl.
    

