import 'dart:io';

import 'package:hackaton/interface/IKorisnik.dart';
import 'package:hackaton/models/Korisnik.dart';

import './global_service.dart';

class UserService extends NetworkService implements IKorisnik {
  @override
  Future<bool> addKorisnik(
      String ime,
      String prezime,
      String email,
      String lozinka,
      File? slika,
      String univerzitet,
      String brTelefona) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: lozinka);

    if (slika != null) {
      try {
        final ref = storage
            .ref()
            .child('korisnicke_slike')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(slika).whenComplete(() => null);
        final url = await ref.getDownloadURL();
        await firestore.collection("korisnici").doc(authResult.user!.uid).set(
          {
            'ime': ime,
            'prezime': prezime,
            'email': email,
            'slika': url,
            'univerzitet': univerzitet,
            'brTelefona': brTelefona
          },
        );
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      try {
        await firestore.collection("korisnici").doc(authResult.user!.uid).set(
          {
            'ime': ime,
            'prezime': prezime,
            'email': email,
            'slika': null,
            'univerzitet': univerzitet,
            'brTelefona': brTelefona
          },
        );
      } catch (e) {
        print(e);
        return false;
      }
    }
    return true;
  }

  @override
  Future<Korisnik> getKorisnik(String id) async {
    Korisnik fetchedUser;

    final data = await firestore
        .collection('korisnici')
        .doc(id)
        .get()
        .then((value) => value.data());

    fetchedUser = Korisnik(
        id: id,
        email: data!['email'],
        ime: data['ime'],
        prezime: data['prezime'],
        brTelefona: data['brTelefona'],
        slika: data['slika'] ?? "",
        univerzitet: data['univerzitet']);

    return fetchedUser;
  }

  @override
  bool updateKorisnik(String id) {
    // TODO: implement updateKorisnik
    throw UnimplementedError();
  }

  @override
  Future<bool> loginKorisnik(String email, String password) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> logoutKorisnik() async {
    try {
      await auth.signOut();
    } catch (e) {
      return false;
    }
    return true;
  }
}
