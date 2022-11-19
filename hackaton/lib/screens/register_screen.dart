import 'package:flutter/material.dart';
import 'package:hackaton/screens/home_screen.dart';
import 'package:hackaton/screens/my_profile_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:hackaton/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-page';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var items = <String>[
    'Univerzitet u Novom Sadu',
    'Univerzitet u Beogradu',
    'Univerzitet u Kragujevcu',
    'Univerzitet u Čačku'
  ];

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

  void _register(String name, surname, email, password, university, phone) {
    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        university.isEmpty ||
        phone.isEmpty) {
      return;
    }
    UserService()
        .addKorisnik(name, surname, email, password, null, university, phone);
  }

  // Controlers
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();

  var dropdownValue = 'Univerzitet u Novom Sadu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Registracija',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blue,
                          child: ClipOval(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: (image != null)
                                      ? Image.file(
                                          File(image!.path),
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          'assets/images/default_user.png',
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, top: 5),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      myAlert();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15, left: 15, top: 16),
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ime',
                                hintText: 'Unesite vaše ime'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8, bottom: 0),
                          child: TextField(
                            controller: _surnameController,
                            obscureText: false,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Prezime',
                                hintText: 'Unesite vaše prezime'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8, bottom: 0),
                          child: DropdownButtonFormField(
                              borderRadius: BorderRadius.circular(32),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value: dropdownValue,
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8, bottom: 0),
                          child: TextField(
                            controller: _emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Unesite vaš email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8, bottom: 0),
                          child: TextField(
                            controller: _passController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Lozinka',
                                hintText: 'Unesite vašu lozinku'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8, bottom: 0),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Telefon',
                                hintText: 'Unesite vaš broj telefona'),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _register(
                                      _nameController.text,
                                      _surnameController.text,
                                      _emailController.text,
                                      _passController.text,
                                      dropdownValue,
                                      _phoneController.text);
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color: Colors.white)))),
                                child: const Text(
                                  'Registruj se',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
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
          ],
        ),
      ),
    );
  }
}
