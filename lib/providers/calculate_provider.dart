import 'package:dinamicko_programiranje/models/finalno_stanje.dart';
import 'package:dinamicko_programiranje/models/pocetno_stanje.dart';
import 'package:dinamicko_programiranje/models/podaci_razdoblja.dart';
import 'package:dinamicko_programiranje/models/postava_zadatka.dart';
import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  List<PocetnoStanje> pocetnaPostavaTablice = [];
  List<PodaciRazdoblja> podaciRazdoblja = [];
  List<FinalnoStanje> podaciFinalnogRacuna = [];
  Map<int, List<PodaciRazdoblja>> izracuniPoRazdobljima = {};
  Map<int, List<String>> ispisProblemaPoRazdobljima = {};
  String postavaPocetka = "";
  int brojacPostave = 1;
  int ukupno = 0;

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
    podaciFinalnogRacuna = [];
    izracuniPoRazdobljima = {};
    ispisProblemaPoRazdobljima = {};
    postavaPocetka = "";
    brojacPostave = 1;
    ukupno = 0;
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
    kalkuliranjeFinalnogRjesenja();
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
    List<String> listaFormula = [];
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
      listaFormula.add(ispis);
      q += _postavaZadatka.rata;
    }
    ispisProblemaPoRazdobljima.putIfAbsent(1, () => listaFormula);
    izracuniPoRazdobljima.putIfAbsent(1, () => podaciRazdoblja);
  }

  void kalkuliranjeTroskaRazdoblja(int br) {
    int q = 0;
    int narucivanje = 0;
    int skladistenje = 0;
    int skladistenjeProslo = 0;
    int zbroj = 0;
    String ispis = "";
    List<String> ispisProblema = [];
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
        int rezzProslogRazdoblja =
            (i + _postavaZadatka.razdoblja[br]! - z) ~/ _postavaZadatka.rata;
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
        ispisProblema.add(ispis);
      }
      String rjesenje = "f(" +
          br.toString() +
          ")[" +
          i.toString() +
          "] = min -> " +
          min.toString();
      ispisProblema.add(rjesenje);
      ispisProblema.add("");
      podaciRazdobljaZaSveDruge.add(PodaciRazdoblja(q_i: q, f_i: min));
    }
    ispisProblemaPoRazdobljima.putIfAbsent(br, () => ispisProblema);
    izracuniPoRazdobljima.putIfAbsent(br, () => podaciRazdobljaZaSveDruge);
  }

  void kalkuliranjeFinalnogRjesenja() {
    //prvi korak
    int iSada = 0;
    int d = _postavaZadatka.razdoblja[_postavaZadatka.razdoblja.length]!;
    var listaPrethodnih = izracuniPoRazdobljima.values.toList();
    List<PodaciRazdoblja> razdoblje = listaPrethodnih[_postavaZadatka.razdoblja.length - 1];
    int rezzProslogRazdoblja = iSada ~/ _postavaZadatka.rata;
    int q = razdoblje[rezzProslogRazdoblja].q_i;
    int iProslo = d + iSada - q;
    int cP = 0;
    int cH = 0;
    if (q != 0) {
      cP = _postavaZadatka.trosak_nabave;
    }
    if (iSada != 0) {
      cH = iSada * _postavaZadatka.trosak_skladistenja;
    }
    FinalnoStanje finalnoStanje = FinalnoStanje(
        razdoblje: _postavaZadatka.razdoblja.length,
        iProslo: iProslo,
        q: q,
        d: d,
        iSada: iSada,
        cP: cP,
        cH: cH);
    podaciFinalnogRacuna.add(finalnoStanje);
    ukupno += cH + cP;
    for (int i = _postavaZadatka.razdoblja.length - 1; i > 0; i--) {
      int brRazdoblja = i;
      iSada = podaciFinalnogRacuna[podaciFinalnogRacuna.length - 1].iProslo;
      d = _postavaZadatka.razdoblja[i]!;
      razdoblje = listaPrethodnih[i - 1];
      rezzProslogRazdoblja = iSada ~/ _postavaZadatka.rata;
      q = razdoblje[rezzProslogRazdoblja].q_i;
      iProslo = d + iSada - q;
      cP = 0;
      cH = 0;
      if (q != 0) {
        cP = _postavaZadatka.trosak_nabave;
      }
      if (iSada != 0) {
        cH = iSada * _postavaZadatka.trosak_skladistenja;
      }
      finalnoStanje = FinalnoStanje(
          razdoblje: brRazdoblja,
          iProslo: iProslo,
          q: q,
          d: d,
          iSada: iSada,
          cP: cP,
          cH: cH);
      podaciFinalnogRacuna.add(finalnoStanje);
      ukupno += cH + cP;
    }
    podaciFinalnogRacuna = podaciFinalnogRacuna.reversed.toList();
    notifyListeners();
  }
}
