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
    write('                 Berhati-hatilah! Lautan ini berbahaya!  ~~~~~~~~~~~~~'),nl,
    nl,

    % Skema Looping
    % Meminta input dari pemain sampai permainan berakhir
    repeat,
        write('Kami menunggu perintah anda, kapten!'), nl,
        write('Perintah Anda: '),read(Command),
        do(Command),
    end_condition(Command).

do(help) :- printhelp,!.
do(n) :- move(n),!.
do(s) :- move(s),!.
do(e) :- move(e),!.
do(w) :- move(w),!.
do(map) :- kompas, printmap(0,0),nl,!.
do(quit) :- 
    write('Apakah kamu yakin, kapten? (y/n)'),nl,
    read(X), quit(X),!.
% Command tidak valid
do(_) :- write('Tidak ada perintah itu, kapten!'), nl, nl, !.

printhelp :- 
    nl,
    write('     Anda membuka jurnal anda. Ini yang anda baca'),
    nl,nl,
    write('     ==== Commands ======================================'),nl,
    write('     start/0. = menjalankan permainan'),nl,
    write('     help/0. = membuka jurnal'),nl,
    write('     quit/0. = keluar dari permainan'),nl,
    write('     n/0, s/0, w/0, e/0. = berlayar satu petak'),nl,
    write('     map/0 = membuka peta'),nl,
    write('     heal/0 = menyembuhkan semua pirate (hanya di Skypiea)'),nl,
    write('     status/0 = menampilkan status anda'),nl,nl,
    write('     ==== Legenda ======================================='),nl,
    write('     P = Player  '),nl,
    write('     X = Border  '),nl,
    write('     S = Skypiea '),nl.

quit(y) :- halt,!.
quit(n) :- write('Kembali ke lautan, kapten!'),nl.

end_condition(Command) :- 
    Command == hehe,
    write('Selesai'),nl, quit(y), !.