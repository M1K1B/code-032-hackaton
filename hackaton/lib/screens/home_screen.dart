import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/data/categories.dart';
import 'package:hackaton/models/Kategorija.dart';
import 'package:hackaton/models/Objava.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/screens/login_screen.dart';
import 'package:hackaton/screens/my_profile_screen.dart';

import 'package:hackaton/screens/new_post_screen.dart';
import 'package:hackaton/services/global_service.dart';
import 'package:hackaton/services/posts_service.dart';
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

  Future<List<Objava>> getLista() async {
    final uni = await UserService()
        .getKorisnik(NetworkService().auth.currentUser!.uid)
        .then((value) => value.univerzitet);

    final l = await PostService().getObjaveByUniversity(uni);

    return l;
  }

  List<Objava> objave = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLista(),
      builder: (context, snapshot) {
        //objave = snapshot.data != null ? snapshot.data as List<Objava> : [];
        objave = ((snapshot.data ?? []) as List<Objava>);
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              width: 70,
              child: Image.asset('assets/logo.png'),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                // check if user is logged in
                // if yes, show profile page
                // if no, show login page whit no back button
                NetworkService().auth.currentUser != null
                    ? Navigator.pushNamed(context, MyProfileScreen.routeName)
                    : Navigator.pushReplacementNamed(
                        context,
                        LoginScreen.routeName,
                      );
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
                        searchQuery = newValue.toLowerCase();
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
                          child: SelectorButton('Trazi', Colors.blue,
                              _changeTip, tip == Tip.TRAZI)),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                          child: SelectorButton('Nudi', Colors.blue, _changeTip,
                              tip == Tip.NUDI)),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: SizedBox(
                    width: double.infinity,
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
                            kategorije[index]['title']
                                    .toString()
                                    .toUpperCase() ==
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
                            (objave[index]
                                    .naslov
                                    .toLowerCase()
                                    .contains(searchQuery) ||
                                objave[index]
                                    .tekst
                                    .toLowerCase()
                                    .contains(searchQuery)))
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
      },
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
