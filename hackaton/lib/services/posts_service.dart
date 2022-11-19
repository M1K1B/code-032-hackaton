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
      String univerzitet) async {
    try {
      print("1");
      final post = firestore.collection("objave").doc();
      final ref = storage
          .ref()
          .child('slike_objava')
          .child(post.id + '.jpg');
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
          'univerzitet': univerzitet
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
  bool deleteObjava(String id) {
    // TODO: implement deleteObjava
    throw UnimplementedError();
  }

  @override
  Objava getObjava(String id) {
    // TODO: implement getObjava
    throw UnimplementedError();
  }
}
