:-include('pirate.pl').
:-include('map.pl').

:- dynamic(is_pick/1)
is_pick(0).

battle(X,Y):-
    write('Saatnya berperang, kapten!'), nl,
    write('Pilih kru Anda!'), nl, 
    print_inventori,
    pick()
    repeat,
        read(NAME),
        pick(NAME), 
    end_condition1.
    repeat,
        write('Kami menunggu perintah anda, kapten!'), nl,
        write('Perintah Anda: '),read(Command),
        do(Command),
    end_condition(Command).

pick(NAME) :-
    pirate(_,NAME,_,0),
    write('Siapa itu, Kapten?! Pilih kru lain.'), nl,!.
pick(NAME) :-
    pirate(_,NAME,_,1),
    write('gas'), nl, 
    retract(is_pick(0)),
    asserta(is_pick(1)),
    !.

end_condition1 :-
    is_pick(1).

