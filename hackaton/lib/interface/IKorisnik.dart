import 'dart:html';

import '../models/Korisnik.dart';
abstract class IKorisnik {
  Korisnik getKorisnik(String id);
  bool addKorisnik(String id, String ime, String prezime, String email, File slika, String univerzitet, String brTelefona);
  bool updateKorisnik(String id);
}
