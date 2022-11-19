import 'package:flutter/material.dart';
import 'package:hackaton/data/categories.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Tip.dart';

import 'home_screen.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});
  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  Tip tip = Tip.TRAZI;

  Kategorija kategorija = Kategorija.ALL;
  final kategorije = CATEGORIES;

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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
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
                        child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png"),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Dodaj sliku'),
                            Text('Maksimalna velicina 5MB'),
                            ElevatedButton(
                                onPressed: null, child: const Text('Dodaj'))
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
                      print(kategorije[index]);
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Opis',
                  ),
                ),
              ),
              const Divider(color: Colors.black),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: null,
                  child: Text('Postavi oglas'),
                ),
              )
            ],
          ),
        ));
  }
}
