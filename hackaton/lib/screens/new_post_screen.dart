import 'package:flutter/material.dart';
import 'package:hackaton/data/categories.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Tip.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class NewPostScreen extends StatefulWidget {
  static const String routeName = '/newPost';
  const NewPostScreen({super.key});
  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Izaberite izvor slike'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('Galerija'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('Kamera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Tip tip = Tip.TRAZI;

  Kategorija kategorija = Kategorija.ALL;
  final kategorije = CATEGORIES;

  // controllers
  final _naslovController = TextEditingController();
  final _tekstController = TextEditingController();

  void _newPost(String naslov, tekst, tip, kategorija) {
    if(
      naslov.isEmpty ||
      tekst.isEmpty ||
      tip == null ||
      kategorija == null
    ) {
      return;
    }
    print("$naslov - naslov\n$tekst - tekst\n$tip - tip\n$kategorija - kategorija");
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
  void _changeTip() {
    setState(() {
      tip = tip == Tip.TRAZI ? Tip.NUDI : Tip.TRAZI;
    });
  }

  void _changeKategorja(String kat) {
    Kategorija wantedKat = Kategorija.ALL;
    switch (kat) {
      case 'UCENJE':
        wantedKat = Kategorija.UCENJE;
        break;
      case 'SMESTAJ':
        wantedKat = Kategorija.SMESTAJ;
        break;
      case 'PRODAJA':
        wantedKat = Kategorija.PRODAJA;
        break;
      case 'ZABAVA':
        wantedKat = Kategorija.ZABAVA;
        break;
      default:
        break;
    }
    setState(() {
      kategorija = wantedKat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Novi post'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                      child: SelectorButton(
                          'Trazi', Colors.blue, _changeTip, tip == Tip.TRAZI)),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: SelectorButton(
                          'Nudi', Colors.blue, _changeTip, tip == Tip.NUDI)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _naslovController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Naslov',
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: image == null ? Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png")
                            :
                            Image.file(File(image!.path)), 
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Dodaj sliku'),
                            const Text('Maksimalna velicina 5MB'),
                            ElevatedButton(
                                onPressed: () {
                                  myAlert();
                                },
                                child: const Text('Dodaj'))
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 55,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kategorije.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectorButton(
                            kategorije[index]['title'].toString(), Colors.blue,
                            () {
                          _changeKategorja(kategorije[index]['title']
                              .toString()
                              .toUpperCase());
                        },
                            kategorija.name ==
                                kategorije[index]['title']
                                    .toString()
                                    .toUpperCase()),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tekstController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Opis',
                  ),
                ),
              ),
              const Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _newPost(
                        _naslovController.text,
                        _tekstController.text,
                        tip,
                        kategorija);
                      },
                  child: const Text('Postavi oglas'),
                ),
              )
            ],
          ),
        ));
  }
  
}
