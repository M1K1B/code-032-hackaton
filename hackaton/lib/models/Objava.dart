import 'dart:html';
import './Kategorija.dart';
import './Tip.dart';
import '../interface/IObjava.dart';

class Objava implements IObjava {
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

  @override
  bool addObjava(String id, Tip tip, String naslov, String tekst, File slika, DateTime datum, String kreatorId, Kategorija kategorija, String univerzitet) {
    // TODO: implement addObjava
   

    throw UnimplementedError();
  }

  @override
  bool deleteObjava(String id) {
    // TODO: implement deleteObjava
    throw UnimplementedError();
  }

  @override
  Objava getObjava(String id) {
    // TODO: implement getObjava
    throw UnimplementedError();
  }
  
  @override
  List objave(Tip tip, Kategorija kategorija) {
    // TODO: implement objave
    throw UnimplementedError();
  }
}
