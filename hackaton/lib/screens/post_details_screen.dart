import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/models/Korisnik.dart';
import 'package:hackaton/models/Objava.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/services/global_service.dart';
import 'package:hackaton/services/posts_service.dart';
import 'package:hackaton/services/user_service.dart';
import 'package:hackaton/widgets/category_bubble.dart';

class PostDetailsScreen extends StatelessWidget {
  static const String routeName = '/post-details-screen';

  final Objava objava;

  PostDetailsScreen(this.objava, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(0, 0, 0, 0.9),
                  Color.fromRGBO(0, 0, 0, 0.7),
                  Color.fromRGBO(0, 0, 0, 0.5),
                  Color.fromRGBO(0, 0, 0, 0.3),
                  Color.fromRGBO(0, 0, 0, 0.0),
                ]),
          ),
        ),
        title: Text(
          objava.naslov,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.network(
            objava.slika,
            fit: BoxFit.cover,
          ),
        ),
        FutureBuilder(
          future: UserService().getKorisnik(objava.kreatorId),
          builder: (context, snapshot) {
            final kreator = snapshot.data ??
                Korisnik(
                    id: "",
                    email: "",
                    ime: "",
                    prezime: "",
                    brTelefona: "",
                    slika: "",
                    univerzitet: "");
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        objava.datum,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (objava.tip != Tip.REKLAMA)
                            CategoryItem(objava.kategorija.name.toString()),
                          if (NetworkService().auth.currentUser!.uid ==
                              objava.kreatorId)
                            IconButton(
                                padding: EdgeInsets.only(left: 17),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  PostService().deleteObjava(objava.id).then(
                                      (value) => Navigator.of(context)
                                          .pushReplacementNamed(
                                              HomeScreen.routeName));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 32,
                                  color: Colors.red[800],
                                ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    objava.tekst,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  if (objava.tip != Tip.REKLAMA)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: kreator.slika != null
                                  ? NetworkImage(kreator.slika!)
                                  : const NetworkImage(
                                      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200"),
                              radius: 35,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  kreator.ime + " " + kreator.prezime,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 23),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.more_vert_sharp,
                                color: Colors.grey[400],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.mail_rounded,
                                    color: Colors.blue[700],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    kreator.email,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_vert_sharp,
                                color: Colors.grey[400],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.blue[700],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    kreator.brTelefona,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
