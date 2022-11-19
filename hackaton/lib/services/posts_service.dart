import 'dart:io';

import 'package:hackaton/interface/IObjava.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Objava.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/services/global_service.dart';

class PostService extends NetworkService implements IObjava {
  @override
  Future<bool> addObjava(
      Tip tip,
      String naslov,
      String tekst,
      File slika,
      DateTime datum,
      String kreatorId,
      Kategorija kategorija,
      String univerzitet,
      bool reklama) 
  async {
    try {
      print("1");
      final post = firestore.collection("objave").doc();
      final ref = storage.ref().child('slike_objava').child(post.id + '.jpg');
      print("2");
      await ref.putFile(slika).whenComplete(() => null);
      final url = await ref.getDownloadURL();
      await firestore.collection("objave").doc(post.id).set(
        {
          'id': post.id,
          'tip': tip.index,
          'naslov': naslov,
          'tekst': tekst,
          'slika': url,
          'datum': datum,
          'kreatorId': kreatorId,
          'kategorija': kategorija.index,
          'univerzitet': univerzitet,
          'reklama': reklama,
        },
      );
      print("3");
    } catch (e) {
      print(e);
      print("4");
      return false;
    }
    return true;
  }

  @override
  bool deleteObjava(String id)  {
    final data = firestore.collection("objave").doc(id);
    try {
      data.delete();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  @override
  Future<Objava> getObjava(String id) async {
    Objava objava;

    final data = await firestore
        .collection("objave")
        .doc(id)
        .get()
        .then((value) => value.data());

    objava = Objava(
        id: id,
        tip: Tip.values[data!['tip']],
        naslov: data['naslov'],
        tekst: data['tekst'],
        slika: data['slika'],
        datum: data['datum'].toDate(),
        kreatorId: data['kreatorId'],
        kategorija: Kategorija.values[data['kategorija']],
        univerzitet: data['univerzitet'],
        reklama: data['reklama']);

    return objava;
  }

  Future<List<Objava>> getObjaveByUniversity(String uni) async {
    List<Objava> objave = [];

    final data = await firestore
        .collection("objave")
        .where("univerzitet", isEqualTo: uni)
        .get()
        .then((value) => value.docs);

    data.forEach((element) {
      objave.add(Objava(
          id: element.data()['id'],
          tip: Tip.values[element.data()['tip']],
          naslov: element.data()['naslov'],
          tekst: element.data()['tekst'],
          slika: element.data()['slika'],
          datum: element.data()['datum'].toDate(),
          kreatorId: element.data()['kreatorId'],
          kategorija: Kategorija.values[element.data()['kategorija']],
          univerzitet: element.data()['univerzitet'],
          reklama: element.data()['reklama']));
    });

    return objave;
  }

  // get all posts that are reklama
  Future<List<Objava>> getReklame() async {
    List<Objava> objave = [];

    final data = await firestore
        .collection("objave")
        .where("reklama", isEqualTo: true)
        .get()
        .then((value) => value.docs);

    data.forEach((element) {
      objave.add(Objava(
          id: element.data()['id'],
          tip: Tip.values[element.data()['tip']],
          naslov: element.data()['naslov'],
          tekst: element.data()['tekst'],
          slika: element.data()['slika'],
          datum: element.data()['datum'].toDate(),
          kreatorId: element.data()['kreatorId'],
          kategorija: Kategorija.values[element.data()['kategorija']],
          univerzitet: element.data()['univerzitet'],
          reklama: element.data()['reklama']));
    });

    return objave;
  }
}
