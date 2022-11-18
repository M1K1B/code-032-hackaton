import './Kategorija.dart';
import './Tip.dart';

class Objava {
  final String id;
  final Tip tip;  
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
