import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/data/categories.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Objava.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/screens/my_profile_screen.dart';

import 'package:hackaton/screens/new_post_screen.dart';
import 'package:hackaton/services/user_service.dart';
import 'package:hackaton/widgets/post_card.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Tip tip = Tip.TRAZI;
  Kategorija kategorija = Kategorija.ALL;
  final kategorije = CATEGORIES;
  String searchQuery = "";

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

  List<Objava> objave = [
    Objava(
      id: 'asdasd',
      tip: Tip.NUDI,
      naslov: 'da',
      tekst: 'dassda',
      slika:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.ALL,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.NUDI,
      naslov: '2',
      tekst: 'dassda',
      slika:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.SMESTAJ,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.TRAZI,
      naslov: 'Casovi matematike',
      tekst: 'Treb mi pomoc oko Analize 1, funkcija, integrala, itd.',
      slika:
          'https://connect-assets.prosple.com/cdn/ff/_Y2JMj06AZeNzNBX8EBCSJg4_A71dSbBAXXPqCplgFw/1567731370/public/2019-09/feature-article-tips-for-being-a-mathematics-student-at-university-838x484-2019.jpg',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.UCENJE,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.TRAZI,
      naslov: 'Treba mi cimer',
      tekst:
          'Nisam upao u dom ove godine i trazim cimera da delimo stan, pozeljno bi bilo ako taj cimer vec ima stan u koji mogu samo da se uselim.',
      slika:
          'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1403414884l/20518986.jpg',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.SMESTAJ,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.NUDI,
      naslov: '5',
      tekst: 'dassda',
      slika:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.SMESTAJ,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.TRAZI,
      naslov: 'Igraci za 3x3',
      tekst:
          'Trazimo jos 2 igraca za igranje basketa 3x3 na djackom terenu svake nedelje. Potrebno je da samo budete izmedju 16 i 25 godina i da volite sport.',
      slika:
          'https://media.istockphoto.com/id/1058718840/photo/young-man-jumping-and-making-a-fantastic-slam-dunk.jpg?s=612x612&w=0&k=20&c=klUP4I6L5bqlTukSuE_Zfmdac_nQngpZlgCRALJm198=',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.ZABAVA,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.NUDI,
      naslov: '7',
      tekst: 'dassda',
      slika:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.SMESTAJ,
      univerzitet: 'Novi Sad',
    ),
    Objava(
      id: 'asdasd',
      tip: Tip.TRAZI,
      naslov: '8',
      tekst: 'dassda',
      slika:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
      datum: DateFormat("dd/MM/yyyy").format(DateTime.now()),
      kreatorId: 'adsadsad',
      kategorija: Kategorija.SMESTAJ,
      univerzitet: 'Novi Sad',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 70,
          child: Image.asset('assets/logo.png'),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MyProfileScreen.routeName);
          },
          icon: Icon(Icons.person_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NewPostScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[600]!),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                onFieldSubmitted: (newValue) {
                  setState(() {
                    kategorija = Kategorija.ALL;
                    searchQuery = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: SelectorButton(
                          'Trazi', Colors.blue, _changeTip, tip == Tip.TRAZI)),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: SelectorButton(
                          'Nudi', Colors.blue, _changeTip, tip == Tip.NUDI)),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: kategorije.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SelectorButton(
                        kategorije[index]['title'].toString(),
                        Colors.blue,
                        () {
                          _changeKategorja(kategorije[index]['title']
                              .toString()
                              .toUpperCase());
                        },
                        kategorije[index]['title'].toString().toUpperCase() ==
                            kategorija.name,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(color: Colors.black),
            Expanded(
              child: ListView.builder(
                  itemCount: objave.length,
                  itemBuilder: (context, index) {
                    if (objave[index].tip == tip &&
                        (objave[index].kategorija == kategorija ||
                            kategorija == Kategorija.ALL) &&
                        (objave[index].naslov.contains(searchQuery) ||
                            objave[index].tekst.contains(searchQuery)))
                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: PostCard(objave[index]),
                      );
                    else
                      return SizedBox(
                        height: 0,
                      );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectorButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback func;
  final bool isOn;

  const SelectorButton(this.text, this.color, this.func, this.isOn,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: isOn ? color : color.withOpacity(0.4),
          border: Border.all(
              color: isOn ? color : color.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
