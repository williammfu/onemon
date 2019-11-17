% File external yang dipakai
:-include('pirate.pl').

% Dynamic predicate
:-dynamic(is_start/1).
:-dynamic(is_battle/1).
:-dynamic(is_pick/2).
:-dynamic(is_attack/1).
:-dynamic(is_specEnemy/2).
:-dynamic(turn/1).
:-dynamic(can_run/1).

% Inisialisasi dynamic predicate
turn(0).
is_attack(0).
is_battle(0).
is_start(0).
is_pick(0,999).
is_specEnemy(0,999).
can_run(1).

% Menampilkan bantuan
help :-
    is_battle(1),nl,
    write('     Anda sedang berada dalam battle!'),nl,
    write('     Ini perintah yang dapat anda gunakan'),
    nl,nl,
    write('  Commands ======================================'),nl,
    write('     fight.         = menghadapi musuh seperti pemberani'),nl,
    write('     run.           = kabur seperti pengecut'),nl,
    write('     pick(PirateName) = memilih kru kapal '),nl,
    write('     attack.        = menyerang musuh (biasa)'),nl,
    write('     specialAttack. = menggunakan special skill'),nl,!.

help :-
    is_start(1), nl,
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

% Memulai permainan
change_start :- is_start(_), retract(is_start(_)), asserta(is_start(1)).

start :-
    is_start(1),
    write('Permainan sedang berjalan!'),!.

start :- 
    is_start(0), change_start, nl,
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
    get0(_), help, 
    retract(pirLoc(133,0,0)),
    asserta(pirLoc(133,1,2)),!.

% Tampil peta
map :- is_start(1), kompas, printmap(0,0).

% Mengecek setiap berpindah tempat
show_fight_msg :- write('Apa yang anda akan lakukan? (fight./run.)'),nl.
check_pos :- % Kalau ketemu legend, pesannya beda
    playLoc(X,Y), pirLoc(Idx,X,Y),
    pirate(Idx,Name,_,_), legend(Name),
    write('Apa itu. . .? Oh, tidak!'),nl,
    write('Hati-hati, kapten!!! '), write(Name), write(' menantang anda '),
    show_fight_msg, 
    retract(is_battle(_)), asserta(is_battle(1)),!.

check_pos :-
    playLoc(X,Y), pirLoc(Idx,X,Y),
    pirate(Idx,Name,_,_),
    write('Sebuah kapal asing mendekati anda. . .'),nl,
    write(Name), write(' menantang anda !!!'),nl,
    show_fight_msg,
    retract(is_battle(_)), asserta(is_battle(1)),!.

check_pos :-
    write('Bagian ini aman, kapten!'),!.

% Bergerak
n :- is_battle(0), move(n), check_pos.
w :- is_battle(0), move(w), check_pos.
e :- is_battle(0), move(e), check_pos.
s :- is_battle(0), move(s), check_pos.

% Status
status :- 
    is_start(1), 
    inventory(_,Me),
    invEnemy(_,Enemy),
    write('Kru Anda ==============='),nl, 
    print_inventory(Me),
    write('Musuh    ==============='),nl, 
    print_enemy(Enemy).

% Enemy Status
% Khusus digunakan saat 
enemy_status(Idx) :-
    nl,
    pirate(Idx,Name,Hp,_),type(Name,Type,_),
    write('====== Musuh Anda ======'),nl,nl,
    write(Name),nl,
    write('Health  : '),write(Hp),nl,
    write('Type    : '),write(Type),nl,!.

% Fight
show_msg_pick :- 
    nl,write('Cepat! Pilih pasukan anda!'),
    nl,write('Kru kapal tersedia  '), nl,
    inventory(_,List), print_inventory(List).

fight :-
    is_battle(1), can_run(_), is_specEnemy(_,_),
    playLoc(X,Y), pirLoc(Idx,X,Y),
    retract(can_run(_)), asserta(can_run(0)),
    retract(is_specEnemy(_,_)), asserta(is_specEnemy(0,Idx)),
    enemy_status(Idx),show_msg_pick,!.

% Check Fight : mengecek keadaan setelah serangan
check_fight :-
    playLoc(X,Y), pirLoc(Idx,X,Y), 
    pirate(Idx,Name,CurrHp,_), CurrHp =< 0, % Nyawa musuh habis = menang
    nl, write('Selamat, kapten!'),nl,
    write(Name), write(' berhasil dikalahkan'),!.

check_fight :- 
    is_pick(1,Idx), 
    pirate(Idx,Name,CurrHp,_), CurrHp =< 0, % Nyawa kru habis = kalah
    nl, write('Lautan menangis, kapten. . .'),nl,
    write(Name), write(' kalah dalam pertarungan'),!.

check_fight :- 
    is_attack(1),
    is_pick(1,IdxMe), pirate(IdxMe,Me,_,_),
    playLoc(X,Y), pirLoc(Idx,X,Y), pirate(Idx,Opp,_,_), 
    random(1,4,Chance), randomAtt(Opp,Me,Chance),!.

check_fight :-
    is_attack(0), nl, write('Pertarungan berlanjut. . .'),!.

% Attack
attack :- is_pick(0,_),write('Anda belum memilih kru , kapten!'),!.   
attack :-
    is_attack(0), is_pick(1,IdxMe), pirate(IdxMe,Me,_,_),
    playLoc(X,Y), pirLoc(IdxOpp,X,Y), pirate(IdxOpp,Opp,_,_),
    normalAtt(Me,Opp), retract(is_attack(0)), asserta(is_attack(1)),
    check_fight,!.

specialAttack :- is_pick(0,_),write('Anda belum memilih kru , kapten!'),!.
specialAttack :-
    is_attack(0), is_pick(1,IdxMe), pirate(IdxMe,Me,_,_),
    playLoc(X,Y), pirLoc(IdxOpp,X,Y), pirate(IdxOpp,Opp,_,_),
    specialAtt(Me,Opp), retract(is_attack(0)), asserta(is_attack(1)), 
    check_fight,!.
    % random(1,4,Chance), randomAtt(Opp,Me,Chance),!. 

randomAtt(Opp,Me,1) :-
    is_attack(1),
    nl, pirate(Idx,Opp,_,_), is_specEnemy(0,Idx), 
    specialAtt(Opp,Me),
    retract(is_specEnemy(0,Idx)), asserta(is_specEnemy(1,Idx)),!,
    retract(is_attack(1)), asserta(is_attack(0)),
    check_fight.
randomAtt(Opp,Me,_) :- 
    nl, is_attack(1),normalAtt(Opp,Me),!, retract(is_attack(1)), asserta(is_attack(0)),check_fight.

% Run
run :- is_battle(1), can_run(1), random(1,3,Chance), flee(Chance).

% Kasus chance = 1, gagal run
flee(1) :-
    playLoc(X,Y),pirLoc(Idx,X,Y), pirate(Idx,Name,_,_),
    write('Kapal kami macet ,kapten!'),nl,
    write('Cepat! Hadapi '),write(Name),write(' !!!'),!,fight.

% Kasus chance = 2 atau 3, berhasil run
flee(_) :-
    retract(is_battle(_)),asserta(is_battle(0)),
    write('Keputusan baik. . .').

% Memilih pirate
pick(_) :- % Perintah dipakai saat tidak battle
    is_start(1), is_battle(0),
    write('Bukan saatnya, kapten!'),!.

pick(_) :-
    is_pick(1,Idx), pirate(Idx,Name,_,_),
    write('Anda sudah memilih '), write(Name),!.

pick(Name) :- % Sesuai syarat
    is_battle(1), is_pick(0,_),
    pirate(Idx,Name,_,1),
    write('Anda memilih '),write(Name),
    retract(is_pick(0,_)),asserta(is_pick(1,Idx)),!.

pick(_) :- % Milih gabener
    write('Bukan kru!'),nl,
    write('Pilih yang lain, kapten!').

% Quit
quit :- 
    write('Apakah anda yakin? (y/n)'),nl,
    read(Opt),do_quit(Opt).
do_quit(y) :- write('Sampai jumpa!'),halt,!.
do_quit(n) :- write('Kembali ke lautan Kasatu!!!'),nl,!.