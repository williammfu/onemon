:-dynamic(pirate/4).

% Inisialisasi pirate
% pirate(kode,name,health, kepemilikan)
% normal = kode 130 - 139
pirate(130, ace, 73, 1).
pirate(131, usop,70, 0).
pirate(132, tony,48, 1).
pirate(133, law,43, 0).
pirate(134, rayleigh,38, 0).
pirate(135, newgate,75, 0).
pirate(136, dragon,41, 0).
pirate(137, katakuri,33, 0).
pirate(138, vinsmoke,46, 0).
pirate(139, doflamingo,71, 0).
% legendary = kode 140-144
pirate(140, luffy,235, 0).
pirate(141, zoro,265, 0).
pirate(142, sanji,123, 0).
pirate(143, bigMama,247, 0).
pirate(144, rakhamon,288, 0).

generate_random :-
    random(130,139,X),
    write('Hasil random : '),
    write(X),nl.
    