import 'package:flutter/material.dart';
import 'package:hackaton/data/categories.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Korisnik.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/services/global_service.dart';
import 'package:hackaton/services/posts_service.dart';
import 'package:hackaton/services/user_service.dart';
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
    // check if image is grater than 1MB
    if (img != null) {
      File file = File(img.path);
      if (file.lengthSync() > 1000000) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Slika je prevelika!'),
          ),
        );
      } else {
        setState(() {
          image = img;
        });
      }
    }
  }

  Tip tip = Tip.TRAZI;

  Kategorija kategorija = Kategorija.UCENJE;
  final kategorije = CATEGORIES;

  // controllers
  final _naslovController = TextEditingController();
  final _tekstController = TextEditingController();

  Future<void> _newPost(String naslov, tekst, tip, kategorija) async {
    if (naslov.isEmpty || tekst.isEmpty || tip == null || kategorija == null) {
      return;
    }
    final user =
        await UserService().getKorisnik(NetworkService().auth.currentUser!.uid);

    PostService().addObjava(tip, naslov, tekst, File(image!.path),
        DateTime.now(), user.id, kategorija, user.univerzitet);

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
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Kreirajte novu objavu'),
          ],
        ),
        actions: [
          SizedBox(
            width: 40,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: image == null
                      ? Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    label: const Text('Dodajte sliku')),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: SelectorButton(
                          'Traži', Colors.blue, _changeTip, tip == Tip.TRAZI)),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: SelectorButton(
                          'Nudi', Colors.blue, _changeTip, tip == Tip.NUDI)),
                ],
              ),
              SizedBox(
                height: 52,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kategorije.length,
                    itemBuilder: (context, index) {
                      return kategorije[index]['title'] != 'All'
                          ? Container(
                              padding: const EdgeInsets.only(right: 8),
                              child: SelectorButton(
                                kategorije[index]['title'].toString(),
                                Colors.blue,
                                () {
                                  _changeKategorja(
                                    kategorije[index]['title']
                                        .toString()
                                        .toUpperCase(),
                                  );
                                },
                                kategorija.name ==
                                    kategorije[index]['title']
                                        .toString()
                                        .toUpperCase(),
                              ),
                            )
                          : SizedBox(width: 0);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 55,
                child: TextField(
                  controller: _naslovController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: 'Naslov',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: TextField(
                  maxLines: 6,
                  maxLength: 200,
                  controller: _tekstController,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    labelText: 'Opis',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_checkFields(_naslovController.text, _tekstController.text)){
                      _newPost(_naslovController.text, _tekstController.text, tip,
                          kategorija);
                    }

                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Kreirajte novu objavu',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  bool _checkFields(String naslov, String tekst) {
    if (naslov.isEmpty || tekst.isEmpty) {
      return false;
    }
    // naslov must have at least 3 characters and tekst must have at least 10 characters
    if (naslov.length < 3 || tekst.length < 10) {
      return false;
    }

    return true;
  }
}
