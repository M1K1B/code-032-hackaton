import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hackaton/models/Korisnik.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/screens/login_screen.dart';
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
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () async {
                    bool isLoggedOut = await UserService().logoutKorisnik();
                    if(isLoggedOut){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error while logging out'),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      width: double.infinity,
                      height: 450,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'bg.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 450,
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.blue!.withOpacity(0.9),
                            Colors.blue[400]!.withOpacity(0.9)
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 180,
                            width: 180,
                            child: CircleAvatar(
                              backgroundImage: snapshot.data!.slika != null
                                  ? NetworkImage(
                                      snapshot.data!.slika.toString())
                                  : NetworkImage(
                                      'https://static-media-prod-cdn.itsre-sumo.mozilla.net/static/default-FFA-avatar.2f8c2a0592bda1c5.png'),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            snapshot.data!.ime + " " + snapshot.data!.prezime,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )
                        ],
                      ),
                    ),
                  ]),
                  InfoBar(snapshot.data!.univerzitet, Icons.school),
                  InfoBar(snapshot.data!.email, Icons.alternate_email),
                  InfoBar(snapshot.data!.brTelefona, Icons.phone),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class InfoBar extends StatelessWidget {
  final String text;
  final IconData icon;

  const InfoBar(this.text, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
          border: Border.all(
            width: 3,
            color: Colors.grey[400]!,
          ),
        ),
        padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
        margin: EdgeInsets.only(left: 20, top: 25, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 36,
              color: Colors.grey[700],
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
