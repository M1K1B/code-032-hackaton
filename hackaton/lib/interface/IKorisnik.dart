import 'dart:io';

import '../models/Korisnik.dart';

abstract class IKorisnik {
  Future<bool> logoutKorisnik();
  Future<bool> loginKorisnik(String email, String password);
  Future<Korisnik> getKorisnik(String id);
  Future<bool> addKorisnik(String ime, String prezime, String email,
      String lozinka, File? slika, String univerzitet, String brTelefona);
  bool updateKorisnik(String id);
}
