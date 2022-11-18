import 'dart:html';

import '../models/Objava.dart';
import '../models/Kategorija.dart';
import '../models/Tip.dart';

abstract class IObjava {
  Objava getObjava(String id);
  bool addObjava(String id, Tip tip, String naslov, String tekst, File slika,
  DateTime datum, String kreatorId, Kategorija kategorija, String univerzitet,);
  bool deleteObjava(String id);
}
