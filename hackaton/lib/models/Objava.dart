import './Kategorije.dart';

class Objava {
  final String id;
  final bool tip; // 0 = trazi, 1 = nudi 
  final String naslov;
  final String tekst;
  final String slika;
  final DateTime datum;
  final String kreatorId;
  final Kategorija kategorija;
  final String univerzitet;

  Objava({
    required this.id,
    required this.tip,
    required this.naslov,
    required this.tekst,
    required this.slika,
    required this.datum,
    required this.kreatorId,
    required this.kategorija,
    required this.univerzitet,
  });
}
