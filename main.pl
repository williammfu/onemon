% File external yang dipakai
:-include('pirate.pl').

% Dynamic predicate
:-dynamic(is_start/1).
:-dynamic(is_battle/1).
:-dynamic(is_pick/2).
:-dynamic(is_attack/1).
:-dynamic(is_specMe/2).
:-dynamic(is_specEnemy/2).
:-dynamic(can_run/1).
:-dynamic(is_heal/1).

% Inisialisasi dynamic predicate
is_heal(0).
is_attack(0).
is_battle(0).
is_start(0).
is_pick(0,999).
is_specMe(0,999).
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
    write('     specialAttack. = menggunakan special skill'),nl,
    write('     capture. = menangkap pirate'),nl,
    write('     drop(PirateName). = mengusir satu pirate dari kapal'),nl,!.

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
    write('                          > Tekan ENTER <'),
    get0(_), inventory(_,[H|_]), pirate(H,Name,_,_),nl,nl,nl,
    write('Hai! Perkenalkan ini kru pertama anda, '), write(Name),nl,
    write(Name), write(' adalah seorang fighter.'),nl,nl,
    write('> Tekan ENTER <'),get0(_),
    help, random_putt, random_putt, !.

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
n :- is_start(1), playLoc(1,_), write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!. 
n :- is_start(1), is_battle(0), leave_pirate, move(n), check_pos.

w :- is_start(1), playLoc(_,1), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
w :- is_start(1), is_battle(0), leave_pirate, move(w), check_pos.

e :- is_start(1), playLoc(_,10), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
e :- is_start(1), is_battle(0), leave_pirate, move(e), check_pos.

s :- is_start(1), playLoc(10,_), nl, write('Anda mau kemana?!'),nl,write('Fokus, kapten!'), nl,!.
s :- is_start(1), is_battle(0), leave_pirate, move(s), check_pos.

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
% Khusus digunakan saat awal battle
enemy_status(Idx) :-
    nl,
    pirate(Idx,Name,Hp,_),type(Name,Type,_),
    write('Musuh Anda -------'),nl,
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
% Kalau menang
check_fight :-
    playLoc(X,Y), pirLoc(Idx,X,Y), is_battle(1),
    pirate(Idx,Name,CurrHp,_), CurrHp =< 0, % Nyawa musuh habis = menang
    nl, write('Selamat, kapten!'),nl,
    write(Name), write(' berhasil dikalahkan'),nl, 
    retract(is_battle(1)), asserta(is_battle(0)),menang_battle,!.

% Kalau kalah 
check_fight :- 
    is_pick(1,Idx), is_battle(1),
    pirate(Idx,Name,CurrHp,_), CurrHp =< 0, % Nyawa kru habis = kalah
    nl, write('Lautan menangis, kapten. . .'),nl,
    write(Name), write(' kalah dalam pertarungan'),nl,
    retract(is_battle(1)), asserta(is_battle(0)), kalah,!. % Ubah statenya

% Kalau belum ada yang menang/ kalah, musuh serang balik
check_fight :- 
    is_attack(1), is_battle(1),
    is_pick(1,IdxMe), pirate(IdxMe,Me,_,_),
    playLoc(X,Y), pirLoc(Idx,X,Y), pirate(Idx,Opp,_,_), 
    random(1,4,Chance), randomAtt(Opp,Me,Chance),!.

% Setelah musuh
check_fight :-
    is_attack(0), is_battle(1), nl, write('Pertarungan berlanjut. . .'),!.

menang_battle :-
    playLoc(X,Y), pirLoc(Idx,X,Y), pirate(Idx,Name,_,_), legend(Name),
    sub_inv(Idx), invEnemy(0,_), 
    write('*  Akhirnya!  *'),nl, write(' Anda berhasil menemukan ONEMON! !'),nl,
    write('Anda adalah Kapten terbaik di Lautan Kasatu!'), nl,
    write('Ayo cari dan berpetualang di lautan lain, Kapten!'), nl,
    do_quit(y),!.
    
menang_battle :-
    is_pick(_,Idx),
    playLoc(X,Y), pirLoc(IdxLose,X,Y), pirate(IdxLose,Name,Hp,_), Hp =< 0,
    write('Apakah anda mau merekrut '), write(Name), write('?'),nl,
    write('ketik capture. untuk merekrut; jika tidak mau, pindah saja'),
    retract(is_pick(_,Idx)), asserta(is_pick(0,999)),
    after_fight,!.

% Penanganan kasus penuh
capture :-
    inventory(6,_),
	write('Kapal sudah penuh kapten!'),nl,
	write('Usir salah satu kru!'),nl, 
	write('drop(Name) untuk mengusir satu pirate'),!.

capture :-
    playLoc(X,Y), pirLoc(Idx,X,Y), pirate(Idx,Name,Hp,0), Hp =< 0, health(Name,InitHp),
    retract(pirate(Idx,Name,Hp,0)), asserta(pirate(Idx,Name,InitHp,1)),
    retract(pirLoc(Idx,X,Y)), asserta(pirLoc(Idx,0,0)),
    inventory(N,_), N<6, invTotal(OldList), 
    sub(Idx,OldList,NewList), retract(invTotal(OldList)), asserta(invTotal(NewList)), add_inv(Idx),
    write('Selamat bergabung dalam kru, '), write(Name), write('!'),!.

drop(Name) :-
    inventory(6,_),
    pirate(Idx,Name,Hp,1), Hp =< 0, health(Name, InitHp), retract(pirate(Idx,Name,Hp,1)),
    asserta(pirate(Idx,Name,InitHp,1)), sub_inv(Idx),
    write(Name),write(' telah melompat dari papan :('), nl, capture,!.

after_fight :-
    is_specMe(_,_), is_specEnemy(_,_), can_run(_), is_attack(_),
    retract(is_attack(_)), asserta(is_attack(0)),
    retract(is_specMe(_,_)), asserta(is_specMe(0,999)),
    retract(is_specEnemy(_,_)), asserta(is_specEnemy(0,999)),
    retract(can_run(_)), asserta(can_run(1)).

kalah :-
    is_pick(_,Idx), pirate(Idx,Name,HpAkhir,1), HpAkhir =< 0,
    health(Name,HP), sub_inv(Idx),
    retract(pirate(Idx,Name,HpAkhir,1)),
    asserta(pirate(Idx,Name,HP,0)), 
    retract(is_pick(_,Idx)), asserta(is_pick(0,999)),
    after_fight, random_putt, check_inv.

check_inv :-
    inventory(Nb,_), Nb>=1, write('Jangan sedih, Kapten!'), nl, write('Masih banyak kru lain di Lautan Kasatu!'), !.

check_inv :-
    inventory(0,_),
    write('Anda kehabisan kru, kapten!'),nl,
    write('Saatnya kembali ke daratan. . .'),nl,
    do_quit(y).

% Attack
attack :- is_pick(0,_),write('Anda belum memilih kru , kapten!'),!.   
attack :-
    is_battle(1), is_attack(0), is_pick(1,IdxMe), pirate(IdxMe,Me,_,_),
    playLoc(X,Y), pirLoc(IdxOpp,X,Y), pirate(IdxOpp,Opp,_,_),
    normalAtt(Me,Opp), retract(is_attack(0)), asserta(is_attack(1)),!,
    check_fight,!.
attack :-
    is_battle(0),
    write('Anda sudah kalah dalam pertarungan, Kapten!'), nl.    

specialAttack :- is_pick(0,_),write('Anda belum memilih kru , kapten!'),!.
specialAttack :-
    is_battle(1), is_attack(0), is_pick(1,IdxMe), is_specMe(0,_),
    pirate(IdxMe,Me,_,_), playLoc(X,Y), pirLoc(IdxOpp,X,Y), pirate(IdxOpp,Opp,_,_),
    specialAtt(Me,Opp), retract(is_attack(0)), asserta(is_attack(1)), 
    retract(is_specMe(0,_)),asserta(is_specMe(1,IdxMe)),!,
    check_fight.
specialAttack :- write('Tidak bisa lagi, kapten!').

% Random attack untuk musuh
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
    is_battle(0),
    write('Bukan saatnya, kapten!'),!.

pick(_) :-
    is_pick(1,Idx), pirate(Idx,Name,_,_),
    write('Anda sudah memilih '), write(Name),!.

pick(Name) :- % Sesuai syarat
    is_battle(1), is_pick(0,_), is_specMe(_,_),
    pirate(Idx,Name,_,1),
    write('Anda memilih '),write(Name),
    retract(is_pick(0,_)),asserta(is_pick(1,Idx)),
    retract(is_specMe(_,_)), asserta(is_specMe(0,Idx)),!.

pick(_) :- % Milih gabener
    write('Bukan kru!'),nl,
    write('Pilih yang lain, kapten!').

% Leave Pirate
leave_pirate :-
    playLoc(X,Y), pirLoc(Idx,X,Y), pirate(Idx,Name,Hp,_), Hp=< 0,health(Name,InitHp),
    retract(pirate(Idx,Name,Hp,_)), asserta(pirate(Idx,Name,InitHp,_)),
    random_putt,!.
leave_pirate :-
    write(' ').

% Heal
heal :- is_start(0),!,fail.
heal :- is_heal(1),write('Tidak bisa lagi kapten!'),!.
heal :-
    is_heal(0),
    playLoc(X,Y),skyLoc(A,B), X==A, Y==B,
    write('Heal sukses!'),nl,
    inventory(_,List),
    do_heal(List).

do_heal([]):-
    retract(is_heal(0)), asserta(is_heal(1)).

do_heal([Kode|Tail]):-
    pirate(Kode, Nama, OldHealth, 1),
    health(Nama, NewHealth),
    retract(pirate(Kode, Nama, OldHealth, 1)),
    asserta(pirate(Kode, Nama, NewHealth, 1)),
    do_heal(Tail).

% Quit
quit :-
    is_start(1),
    write('Apakah anda yakin? (y/n)'),nl,
    read(Opt),do_quit(Opt).
    
do_quit(y) :- write('Sampai jumpa!'), halt,!.
do_quit(n) :- write('Kembali ke lautan Kasatu!!!'),nl,!.