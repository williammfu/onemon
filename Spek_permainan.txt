  ____  _   _ ______   __  __  ____  _   _ 
 / __ \| \ | |  ____| |  \/  |/ __ \| \ | |
| |  | |  \| | |__    | \  / | |  | |  \| |
| |  | | . ` |  __|   | |\/| | |  | | . ` |
| |__| | |\  | |____  | |  | | |__| | |\  |
 \____/|_| \_|______| |_|  |_|\____/|_| \_|

### Kelompok 11
13518013    Raras Pradnya Pramudita
13518055    William Fu
13518097    Rakha Fadhilah
13518139    Mutiara Arifazzahra

### Deskripsi Permainan

Selamat datang di lautan Kasatu!
Dapatkah anda mengalahkan penguasa lautan Kasatu dan menemukan One Mon?

Anda adalah seorang kapten yang ingin menemukan One Mon, harta karun terbesar
yang dikuasai oleh Rakhamon sang Legendary Pirate. Jelajahilah lautan dan rekrut 
tim Anda untuk mengalahkan para Pirate dan mendapatkan One Mon. 
Berhati-hatilah! Lautan Kasatu penuh mara bahaya!

### Spesifikasi Permainan

Permainan ini diimplementasikan dalam bahasa pemrograman Prolog.
Untuk bisa menjalankan game ini, pengguna diharapkan telah memasang compiler Prolog
seperti GNU Prolog.

## Keadaan Awal
Saat permainan dijalankan, pemain akan diberikan seorang Pirate (secara random) 
dan berada pada posisi (1,1) pada peta. 

Seorang Pirate memiliki sejumlah atribut:
    1. Health 
    2. Type
    3. Normal Attack (Damage)
    4. Special Attack (Skill)

Terdapat 3 tipe Pirate yang ada dalam permainan ini, yaitu:
    1. Fighter
    2. Swordsman
    3. Shooter

Tipe ini berguna dalam mekanisme (ATTACK) dalam permainan dengan aturan sebagai berikut:
    1. Damage Pirate tipe Shooter akan lebih besar 50% dari damage biasanya jika melawan Pirate tipe Fighter. 
       Sedangkan damage dari Pirate tipe Fighter akan lebih kecil 50% dari damage biasanya.
    2. Damage Pirate tipe Fighter akan lebih besar 50% dari damage biasanya jika melawan Pirate tipe Swordsman. 
       Sedangkan damage dari Pirate tipe Swordsman akan lebih kecil 50% dari damage biasanya
    3. Damage Pirate tipe Swordsman akan lebih besar 50% dari damage biasanya jika melawan Pirate tipe Shooter. 
       Sedangkan damage dari Pirate tipe Shooter akan lebih kecil 50% dari damage biasanya

Selain normal Pirate, terdapat pula dua Legendary Pirate pada lautan Kasatu, dengan value atribut
yang lebih besar secara signifikan daripada normal Pirate.

Pada setiap giliran permainan, pemain dapat berpindah satu petak. Pemain dapat menghadapi
seorang Pirate (normal atau Legendary) setiap berpindah petak. Pemain dapat memilih untuk (FIGHT) atau
untuk (FLEE) dari Pirate tersebut. Pemain memiliki 50% kemungkinan (FLEE) berhasil.

Apablia pemain berhasil mengalahkan Pirate tersebut, pemain dapat memilih untuk me'rekrut' Pirate tersebut
ke dalam kapalnya. Apabila kapal pemain sudah penuh, pemain harus mengusir salah satu Pirate dari kapalnya.

Permainan akan selesai apabila :
>> pemain berhasil mengalahkan semua Legendary Pirate yang ada pada peta,
>> pemain telah kehabisan Pirate,

