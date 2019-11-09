/* ATRIBUT ONE-MON */
/* normal(X) artinya X merupakan Pirate tipe normal */
normal(ace).
normal(usop).
normal(tony).
normal(law).
normal(rayleigh).
normal(newgate).
normal(dragon).
normal(katakuri).
normal(vinsmoke).
normal(doflamingo).

/* legend(X) artinya X merupakan Pirate tipe legend */
legend(luffy).
legend(zoro).
legend(sanji).
legend(bigMama).
legend(rakhamon).

/* health(X,Y) artinya Pirate X memiliki health senilai Y */
health(ace,73).
health(usop,70).
health(tony,48).
health(law,43).
health(rayleigh,38).
health(newgate,75).
health(dragon,41).
health(katakuri,33).
health(vinsmoke,46).
health(doflamingo,71).
health(luffy,235).
health(zoro,265).
health(sanji,123).
health(bigMama,247).
health(rakhamon,288).

/* type(X,Y) artinya X memiliki type Y */
/* jenis type: fighter, shooter, swordsman */
type(ace,fighter).
type(usop,shooter).
type(tony,fighter).
type(law,swordsman).
type(rayleigh,swordsman).
type(newgate,swordsman).
type(dragon,fighter).
type(katakuri,fighter).
type(vinsmoke,shooter).
type(doflamingo,fighter).
type(luffy,fighter).
type(zoro,swordsman).
type(sanji,fighter).
type(bigMama,shooter).
type(rakhamon,shooter).

/* damage(X,Y) artinya X menimbulkan damage sebesar Y */
damage(ace,20).
damage(usop,28).
damage(tony,36).
damage(law,44).
damage(rayleigh,36).
damage(newgate,28).
damage(dragon,20).
damage(katakuri,28).
damage(vinsmoke,36).
damage(doflamingo,44).
damage(luffy,50).
damage(zoro,52).
damage(sanji,54).
damage(bigMama,56).
damage(rakhamon,58).

/* skill(X,Y) artinya X memiliki nilai damage skill sebesar Y */ 
skill(X,Y) :- 
	damage(X,Z),
	Y is 3*Z/2.

/* normalAtt(X,Y) artinya X melakukan normal attack kepada Y */ 
normalAtt(X,Y) :- /* fighter -> shooter, damage - 50% */
	type(X,fighter),
	type(Y,shooter),
	health(Y,Z),
	damage(X,W),
	W1 is W/2,
	Z is (Y-W1).
	
normalAtt(X,Y) :- /* shooter -> swordsman, damage - 50% */
	type(X,shooter),
	type(Y,swordsman),
	health(Y,Z),
	damage(X,W),
	W1 is W/2,
	Z is (Y-W1).

normalAtt(X,Y) :- /* swordsman -> fighter, damage - 50% */
	type(X,swordsman),
	type(Y,fighter),
	health(Y,Z),
	damage(X,W),
	W1 is W/2,
	Z is (Y-W1).

normalAtt(X,Y) :- /* shooter -> fighter, damage + 50% */
	type(X,shooter),
	type(Y,fighter),
	health(Y,Z),
	damage(X,W),
	W1 is W+(W/2),
	Z is (Y-W1).

normalAtt(X,Y) :- /* swordsman -> shooter, damage + 50% */
	type(X,swordsman),
	type(Y,shooter),
	health(Y,Z),
	damage(X,W),
	W1 is W+(W/2),
	Z is (Y-W1).

normalAtt(X,Y) :- /* fighter -> swordsman, damage + 50% */
	type(X,fighter),
	type(Y,swordsman),
	health(Y,Z),
	damage(X,W),
	W1 is W+(W/2),
	Z is (Y-W1).