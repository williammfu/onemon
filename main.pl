/*Import file .pl lain*/
:-include('pirate.pl'). 
:-include('map.pl').

/*Deklarasi Rules*/
start :-
	nl,
    write(' ::::::::  ::::    :::: ::::::::: ::::    :::::  ::::::::  ::::    :::'),nl,
    write(':+:    :+: :+:+:   :+:: +:        +:+:+: :+:+:+ :+:    :+: :+:+:   :+:'),nl,
    write('+:+    +:+ :+:+:+  +:++ :+        +:+ +:+:+ +:+ +:+    +:+ :+:+:+  +:+'),nl,
    write('+#+    +:+ +#+ +:+ +#++ #++:++#   +#+  +:+  +#+ +#+    +:+ +#+ +:+ +#+'),nl,
    write('+#+    +#+ +#+  +#+#+#+ #+        +#+       +#+ +#+    +#+ +#+  +#+#+#'),nl,
    write('#+#    #+# #+#   #+#+## +#        #+#       #+# #+#    #+# #+#   #+#+#'),nl,
    write(' ########  ###    ##### ######### ###       ###  ########  ###    ####'),nl,
	nl,nl,
    write('~~~~~~~~~~~~~~~     Selamat datang di Lautan Kasatu!                  '),nl,
    write('                    Dapatkah Anda menemukan Onemon?                   '),nl,
    write('                 Berhati-hatilah! Lautan ini berbahaya!  ~~~~~~~~~~~~~'),nl,nl,
    write('                       > Tekan tombol ENTER <'),
    get0(_), printhelp,

    % Skema Looping
    % Meminta input dari pemain sampai permainan berakhir
    repeat,
        write('Kami menunggu perintah anda, kapten!'), nl,
        write('> '),read(Command),
        do(Command),
    end_condition(Command).

do(start) :- write('Permainan sudah berjalan, kapten!'),nl,nl,!.
do(help) :- printhelp,!.
do(n) :- move(n),!.
do(s) :- move(s),!.
do(e) :- move(e),!.
do(w) :- move(w),!.
do(map) :- kompas, printmap(0,0),nl,!.
do(status) :- write('Kru Anda    : '), nl.
do(status) :- inventory(_,Inv), print_inventori(Inv).
do(status) :- write('Musuh Anda  : '), nl, 
            !, invEnemy(_,Inv), print_enemy(Inv).
do(heal) :-                                                     % Heal pirate, hanya bisa di Skypiea
    playLoc(X,Y), skyLoc(A,B), X\==A, Y\==B,
    write('Kami tidak berada di Skypiea, kapten!'), nl, nl,!.
do(heal) :- playLoc(X,Y), skyLoc(X,Y), heal,!.
do(quit) :-                                                     % Keluar dari permainan
    write('Apakah kamu yakin, kapten? (y/n)'),nl,
    read(X), quit(X),!.
do(_) :- write('Tidak ada perintah itu, kapten!'), nl, nl, !.   % Command tidak valid

printhelp :- 
    nl,
    write('     Anda membuka jurnal anda. Ini yang anda baca'),
    nl,nl,
    write('  Commands ======================================'),nl,
    write('     start. = menjalankan permainan'),nl,
    write('     help. = membuka jurnal'),nl,
    write('     quit. = keluar dari permainan'),nl,
    write('     n. s. w. e. = berlayar satu petak'),nl,
    write('     map. = membuka peta'),nl,
    write('     heal. = menyembuhkan semua pirate (hanya di Skypiea)'),nl,
    write('     status. = menampilkan status anda'),nl,nl,
    write('  Legenda ======================================='),nl,
    write('     P = Player  '),nl,
    write('     X = Ranjau  '),nl,
    write('     S = Skypiea '),nl,nl.

quit(y) :- halt,!.
quit(n) :- write('Kembali ke lautan, kapten!'),nl,nl.

end_condition(Command) :- 
    Command == hehe,
    write('Selesai'),nl, halt, !.