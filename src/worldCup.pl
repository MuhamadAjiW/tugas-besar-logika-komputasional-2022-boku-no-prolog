/* File : worldCup.pl */

:- dynamic(worldCupCurrent/2).

/* ======================================== Initwcoutput ======================================== */
    /* outputWc benar jika menampilkan pada layar */
outputWc :-
    write(' __      __       _    _    ___                 '), nl,
    write(' \\ \\    / /__ _ _| |__| |  / __|  _ _ __      '), nl,
    write('  \\ \\/\\/ / _ \\ \'_| / _` | | (_| || | \'_ \\'), nl,
    write('   \\_/\\_/\\___/_| |_\\__,_|  \\___\\_,_| .__/ '), nl,
    write('                                   |_|          '), nl,nl, !.
/* ======================================== Initwcoutput ======================================== */


/* ======================================== Pemain Lawan ======================================== */
    /* pemainLawan(P1,P2) benar jika P2 adalah pemain lawan dari P1 */
pemainLawan(P1, P2) :-
    pemain(P1),
    pemain(P2),
    P1 \== P2.
/* ======================================== Pemain Lawan ======================================== */



/* ======================================== Initwcoutput ======================================== */
    /* worldCup benar jika currentPemain(P) ada di tile wc dan telah memilih 1 tile property untuk di upgrade */
worldCup :-
    outputWc,
    currentPemain(Pemain),
    lokasiPemain(Pemain, wc),
    pemainLawan(Pemain, Lawan),
    (
        repeat,
        write('Masukkan properti yang akan menjadi tuan rumah: '),
        read(InputProp),
        (
            /* valid */
            asetProperti(Pemain, InputProp),
            retractall(worldCupCurrent(_Pemain, _Lokasi)),
            (
                worldCupCurrent(_Pemain, _Lokasi),
                write('efek World Cup '),  write(_Lokasi), write(' dihilangkan'), nl
                ;
                true
            ),
            asserta(worldCupCurrent(Pemain, InputProp)),
            asserta(worldCupCurrent(Pemain, InputProp)),
            asserta(worldCupCurrent(Pemain, InputProp)),
            write(InputProp), write(' menjadi Tuan rumah World cup di Dunia Boku no Prolog!'), nl,
            write('(nilai properti '), write(InputProp), write(' naik 2 kali lipat)'), nl,
            write('(akhirnya cewek-cewek akan terpukau denganku!!)'),nl,
            write('pikirmu..'), nl, !
            ;

            /* jika ingin keluar */
            InputProp == cancel
            ;

            /* non valid */
            /* termasuk lokasi */
            lokasi(InputProp),
            \+ properti(InputProp),
            write('Buat apa naro world cup di tile ini....'), nl,
            write(Lawan), write(' menggelengkan kepala'), nl, fail
            ;

            /* termasuk properti lawan */
            asetProperti(Lawan, InputProp),
            write('Kamu ingin mengadakan World Cup di lokasi musuh!!'), nl,
            write(Lawan), write(' menatap sinis padamu'), nl, fail
            ;

            /* bukan properti siapapun */
            properti(InputProp),
            \+ asetProperti(Pemain, InputProp),
            \+ asetProperti(Lawan, InputProp),
            write(InputProp), write(' belum dimiliki siapapun, termasuk dirimu!'), nl, fail
            ;

            /* tidak termasuk semuanya */
            \+ lokasi(InputProp),
            write(InputProp), write(' bukanlah properti yang valid!'), nl, fail
        )   
    ),!.

worldCup :-
    currentPemain(Pemain),
    \+ lokasiPemain(Pemain, wc),
    write('Hmmmm kamu tidak berada di World Cup...'), nl,
    write('cie pengen banget naikin harga properti'), nl,
    write('(duidmu dikit ya)'), nl, !.
/* ======================================== Initwcoutput ======================================== */