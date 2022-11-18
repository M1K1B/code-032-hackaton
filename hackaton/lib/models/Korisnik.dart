import 'dart:html';

import '../interface/IKorisnik.dart';
class Korisnik implements IKorisnik {
  final String id;
  final String ime, prezime;
  final String email;
  final String slika;
  final String univerzitet;
  final String brTelefona;

  Korisnik({
    required this.id,
    required this.email,
    required this.ime,
    required this.prezime,
    required this.brTelefona,
    required this.slika,
    required this.univerzitet,
  });

  @override
  bool addKorisnik(String id, String ime, String prezime, String email, File slika, String univerzitet, String brTelefona) {
    // TODO: implement addKorisnik
    throw UnimplementedError();
  }

  @override
  Korisnik getKorisnik(String id) {
    // TODO: implement getKorisnik
    throw UnimplementedError();
  }

  @override
  bool updateKorisnik(String id) {
    // TODO: implement updateKorisnik
    throw UnimplementedError();
  }
}
