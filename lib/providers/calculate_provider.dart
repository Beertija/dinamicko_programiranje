import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/models/postava_zadatka.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  List<PocetnoStanje> pocetnaPostavaTablice = [];
  List<PodaciRazdoblja> podaciRazdoblja = [];
  Map<int, List<PodaciRazdoblja>> izracuniPoRazdobljima = {};

  Map<int, int> izracuni = {};
  String postavaPocetka = "";
  int brojacPostave = 1;

  PostavaZadatka _postavaZadatka = PostavaZadatka(
      rata: 0,
      max_nabava: 0,
      max_kapacitet: 0,
      trosak_nabave: 0,
      trosak_skladistenja: 0,
      razdoblja: {});

  PostavaZadatka get postavaZadatka => _postavaZadatka;

  void reset() {
    _postavaZadatka = PostavaZadatka(
        rata: 0,
        max_nabava: 0,
        max_kapacitet: 0,
        trosak_nabave: 0,
        trosak_skladistenja: 0,
        razdoblja: {});
    pocetnaPostavaTablice = [];
    podaciRazdoblja = [];
    izracuniPoRazdobljima = {};

    izracuni = {};
    postavaPocetka = "";
    brojacPostave = 1;
  }

  void setup(int rata, int max_nabava, int max_kapacitet, int trosak_nabave,
      int trosak_skladistenja, Map<int, int> razdoblja) {
    _postavaZadatka = PostavaZadatka(
        rata: rata,
        max_nabava: max_nabava,
        max_kapacitet: max_kapacitet,
        trosak_nabave: trosak_nabave,
        trosak_skladistenja: trosak_skladistenja,
        razdoblja: razdoblja);
    kalkuliranjePocetnogTroska();
    for (int br = 2; br <= _postavaZadatka.razdoblja.length; br++) {
      kalkuliranjeTroskaRazdoblja(br);
    }
  }

  void kalkuliranjePocetnogTroska() {
    izracunVelicineTablice();
    izracunPrvogRazdoblja();
    notifyListeners();
  }

  void izracunVelicineTablice() {
    postavaPocetka =
        "0 ≤ nabava(i) ≤ " + _postavaZadatka.max_kapacitet.toString();
    for (int i = 0;
        i <= _postavaZadatka.max_kapacitet;
        i += _postavaZadatka.rata) {
      pocetnaPostavaTablice
          .add(PocetnoStanje(brojac: brojacPostave, nabava: i));
      brojacPostave++;
    }
  }

  void izracunPrvogRazdoblja() {
    postavaPocetka = _postavaZadatka.razdoblja[1]!.toString() +
        " ≤ nabava(i) ≤ " +
        _postavaZadatka.max_kapacitet.toString();
    int q = _postavaZadatka.razdoblja[1]!;
    int narucivanje = 0;
    int skladistenje = 0;
    int zbroj = 0;
    String ispis = "";
    for (int i = 0;
        i <= _postavaZadatka.max_kapacitet;
        i += _postavaZadatka.rata) {
      if (_postavaZadatka.razdoblja[1]! == 0) {
        narucivanje = 0;
      } else {
        narucivanje = _postavaZadatka.trosak_nabave;
      }
      if (i == 0) {
        skladistenje = 0;
      } else {
        skladistenje = i * _postavaZadatka.trosak_skladistenja;
      }
      zbroj = narucivanje + skladistenje; //f
      podaciRazdoblja.add(PodaciRazdoblja(q_i: q, f_i: zbroj));
      ispis = "f(1)[" +
          i.toString() +
          "] = g(1)[" +
          q.toString() +
          ", " +
          i.toString() +
          "] = " +
          narucivanje.toString() +
          " + " +
          skladistenje.toString() +
          " = " +
          zbroj.toString();
      //TODO ispis zapisati u neko polje/mapu za kasniji ispis postupka
      q += _postavaZadatka.rata;
    }
    izracuniPoRazdobljima.putIfAbsent(1, () => podaciRazdoblja);
  }

  void kalkuliranjeTroskaRazdoblja(int br) {
    int q = 0;
    int narucivanje = 0;
    int skladistenje = 0;
    int skladistenjeProslo = 0;
    int zbroj = 0;
    String ispis = "";
    Map<int, String> ispisProblema = {};
    Map<int, String> postavaNabave = {};
    List<PodaciRazdoblja> podaciRazdobljaZaSveDruge = [];
    for (int i = 0, j = 0;
        i <= _postavaZadatka.max_kapacitet;
        i += _postavaZadatka.rata, j++) {
      int min = -1;
      //region Postava ograničenja
      int naSkladistu =
          i + _postavaZadatka.razdoblja[br]! - _postavaZadatka.max_kapacitet;
      int maxNarudzba = i + _postavaZadatka.razdoblja[br]!;
      if (naSkladistu < 0) {
        naSkladistu = 0;
      }
      if (maxNarudzba > _postavaZadatka.max_nabava) {
        maxNarudzba = _postavaZadatka.max_nabava;
      }
      postavaNabave.putIfAbsent(
          j,
          () =>
              naSkladistu.toString() +
              " ≤ nabava(i) ≤ " +
              maxNarudzba.toString());
      //endregion
      var listaPrethodnih = izracuniPoRazdobljima.values.toList();
      List<PodaciRazdoblja> a = listaPrethodnih[br - 2];
      int t = 0;
      for (int z = naSkladistu;
          z <= maxNarudzba;
          z += _postavaZadatka.rata, t++) {
        if (z == 0) {
          narucivanje = 0;
        } else {
          narucivanje = _postavaZadatka.trosak_nabave;
        }
        if (i == 0) {
          skladistenje = 0;
        } else {
          skladistenje = i * _postavaZadatka.trosak_skladistenja;
        }
        //TODO fix uzimanje proslog razdoblja
        int rezzProslogRazdoblja = (i + _postavaZadatka.razdoblja[br]! - z) ~/ _postavaZadatka.rata;
        skladistenjeProslo = a[rezzProslogRazdoblja].f_i;
        zbroj = narucivanje + skladistenje + skladistenjeProslo;
        if (min <= 0) {
          min = zbroj;
          q = z;
        } else {
          if (min > zbroj) {
            min = zbroj;
            q = z;
          }
        }
        ispis = "g[" +
            z.toString() +
            ", " +
            i.toString() +
            "] + f(" +
            (br - 1).toString() +
            ")[" +
            i.toString() +
            " + " +
            _postavaZadatka.razdoblja[br]!.toString() +
            " - " +
            z.toString() +
            "] = " +
            narucivanje.toString() +
            " + " +
            skladistenje.toString() +
            " + " +
            skladistenjeProslo.toString() +
            " = " +
            zbroj.toString();
        ispisProblema.putIfAbsent(t, () => ispis);
      }
      String rjesenje = "f(" +
          br.toString() +
          ")[" +
          i.toString() +
          "] = min -> " +
          min.toString();
      ispisProblema.putIfAbsent(t, () => rjesenje);
      podaciRazdobljaZaSveDruge.add(PodaciRazdoblja(q_i: q, f_i: min));
    }
    izracuniPoRazdobljima.putIfAbsent(br, () => podaciRazdobljaZaSveDruge);
  }

//
// int racunanjePostaveZadatka() {
//   int zaliha = 0;
//   postavaPocetka = zaliha.toString() +
//       " ≤ nabava(i) ≤ " +
//       _postavaZadatka.max_kapacitet.toString();
//   for (int i = 0;
//       i <= _postavaZadatka.max_kapacitet;
//       i += _postavaZadatka.rata) {
//     pocetnaPostava.add(PocetnoStanje(brojac: brojacPostave, nabava: i));
//     brojacPostave++;
//     brojacFormula++;
//   }
//   return zaliha;
// }
//
// void kalkuliranjePocetnogTroska() {
//   int zaliha = racunanjePostaveZadatka();
//   for (int nabava = _postavaZadatka.razdoblja[1]!;
//       nabava <=
//           (_postavaZadatka.razdoblja[1]! + _postavaZadatka.max_kapacitet);
//       nabava += _postavaZadatka.rata) {
//     String izracun = "f(1)[" +
//         zaliha.toString() +
//         "] = [" +
//         nabava.toString() +
//         ", " +
//         zaliha.toString() +
//         "] = " +
//         _postavaZadatka.trosak_nabave.toString() +
//         " + " +
//         (zaliha * _postavaZadatka.trosak_skladistenja).toString() +
//         " = " +
//         (_postavaZadatka.trosak_nabave +
//                 (zaliha * _postavaZadatka.trosak_skladistenja))
//             .toString();
//     privremeniIzracuni.putIfAbsent(brojac, () => izracun);
//     izracuni.putIfAbsent(
//         brojac,
//         () =>
//             _postavaZadatka.trosak_nabave +
//             (zaliha * _postavaZadatka.trosak_skladistenja));
//     podaciRazdoblja.add(PodaciRazdoblja(
//         q_i: zaliha,
//         f_i: (_postavaZadatka.trosak_nabave +
//             (zaliha * _postavaZadatka.trosak_skladistenja))));
//     brojac++;
//     zaliha += _postavaZadatka.rata;
//   }
//   notifyListeners();
// }
//
// void izracunRetka(int razdoblje) {
//   //region postavljanje nabave
//   int zaliha = 0;
//   int nabava = zaliha +
//       _postavaZadatka.razdoblja[razdoblje]! -
//       _postavaZadatka.max_kapacitet;
//   int max = zaliha + _postavaZadatka.razdoblja[razdoblje]!;
//   if (nabava < 0) {
//     nabava = 0;
//   }
//   while (max > _postavaZadatka.max_nabava) {
//     max -= _postavaZadatka.rata;
//   }
//   //ispis dio
//
//   //endregion
// }
//
// kalkuliranjeTroskaRazdoblja(int razdoblje) {
//   //region Razdoblje
//   for (int i = 1; i < brojac; i++) {
//     izracunRetka(razdoblje);
//   }
//
//   //endregion
//
//   //TODO Popraviti ispis metode te način iteriranja kroz razdoblja - big task
//   int zaliha = 0;
//   int nabava = zaliha +
//       _postavaZadatka.razdoblja[razdoblje]! -
//       _postavaZadatka.max_kapacitet;
//   int max =
//       _postavaZadatka.razdoblja[razdoblje]! + _postavaZadatka.max_kapacitet;
//   if (nabava < 0) {
//     nabava = 0;
//   }
//   if (max > _postavaZadatka.max_nabava) {
//     max = _postavaZadatka.max_nabava;
//   }
//   for (; nabava <= max; nabava += _postavaZadatka.rata) {
//     String zapis = "g[" +
//         nabava.toString() +
//         ", " +
//         zaliha.toString() +
//         "] + f(" +
//         (razdoblje - 1).toString() +
//         ")[" +
//         zaliha.toString() +
//         " + " +
//         _postavaZadatka.razdoblja[razdoblje]!.toString() +
//         " - " +
//         nabava.toString() +
//         "] = ";
//     if (nabava == 0) {
//       zapis += "0";
//     } else {
//       zapis += _postavaZadatka.trosak_nabave.toString();
//     }
//     zapis += " + ";
//     if (zaliha == 0) {
//       zapis += "0";
//     } else {
//       zapis += (zaliha * _postavaZadatka.trosak_skladistenja).toString();
//     }
//     zapis += " + ";
//     brojac++;
//     zapis += izracuni[brojac - (brojacFormula * (razdoblje - 1))].toString();
//     zapis += " = " +
//         (_postavaZadatka.trosak_nabave +
//                 (zaliha * _postavaZadatka.trosak_skladistenja) +
//                 izracuni[brojac - (brojacFormula * (razdoblje - 1))]!)
//             .toString();
//     String zapis_final =
//         "f(" + razdoblje.toString() + ")[" + nabava.toString() + "] = min";
//     privremeniIzracuni.putIfAbsent(--brojac, () => zapis);
//     zaliha += _postavaZadatka.rata;
//   }
// }
}
