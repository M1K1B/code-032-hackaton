import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/screens/register_screen.dart';
import 'package:hackaton/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-page';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailContr = TextEditingController();
  final _passContr = TextEditingController();

  @override
  void dispose() {
    _emailContr.dispose();
    _passContr.dispose();
    super.dispose();
  }

  void _login(String email, pass) {
    if (email.isEmpty || pass.isEmpty) {
      return;
    }
    UserService().loginKorisnik(email, pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      //backgroundColor: Colors.blue,
      body: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'bg.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.blue[700]!.withOpacity(0.9),
                Colors.blue[400]!.withOpacity(0.9)
              ],
            ),
          ),
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            // Text(
                            //   'Prijava',
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.grey[900],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 12),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _emailContr,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.alternate_email),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Email',
                                      hintText: 'Unesite vašu email adresu'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _passContr,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      labelText: 'Password',
                                      hintText: 'Unesite vašu lozinku'),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Nemate nalog?',
                                        style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 16,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              RegisterScreen.routeName);
                                        },
                                        child: Text(
                                          'Napravite novi',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.grey[900],
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_checkFields(
                                          _emailContr.text, _passContr.text)) {
                                        _login(
                                            _emailContr.text, _passContr.text);
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 15)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: const BorderSide(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Prijavite se',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: Container(
                        height: 90,
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Image.asset('assets/images/logo.png')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  bool _checkFields(String email, String pass) {
    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Morate popuniti sva polja!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    // check if email is valid using regex
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email adresa nije validna!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;

  }
}
