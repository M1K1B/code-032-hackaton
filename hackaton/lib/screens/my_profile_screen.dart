import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackaton/models/Korisnik.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/services/global_service.dart';
import 'package:hackaton/services/user_service.dart';

class MyProfileScreen extends StatelessWidget {
  static const String routeName = '/my-profile-page';

  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currUserId = NetworkService().auth.currentUser!.uid;

    return FutureBuilder(
        future: UserService().getKorisnik(currUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.data!.brTelefona);
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(snapshot.data!.ime),
                actions: [
                  IconButton(
                      onPressed: () {
                        UserService().logoutKorisnik();
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              body: Center(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: snapshot.data!.slika != null
                              ? NetworkImage(snapshot.data!.slika.toString())
                              : NetworkImage(
                                  'https://static-media-prod-cdn.itsre-sumo.mozilla.net/static/default-FFA-avatar.2f8c2a0592bda1c5.png'),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: const [
                          Text(
                            'Pero Peric',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Divider(
                            color: Colors.blue,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Info",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(children: [
                          Container(
                            child: const Icon(
                              Icons.email,
                              size: 36,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'email od pere',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(children: [
                          Container(
                            child: const Icon(
                              Icons.phone,
                              size: 36,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'broj od pere',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(children: [
                          Container(
                            child: const Icon(
                              Icons.school,
                              size: 36,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.grey,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text(
                            'uni od pere',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ]))
                  ],
                )),
              ),
            );
          }
        });
  }
}
