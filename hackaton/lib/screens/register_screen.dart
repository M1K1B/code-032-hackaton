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

  File? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = File(img!.path);
    });
  }

  void _register(
      String name, surname, email, password, university, phone, File? image) {
    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        university.isEmpty ||
        phone.isEmpty) {
      return;
    }
    UserService()
        .addKorisnik(name, surname, email, password, image, university, phone);
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
          child: SizedBox(
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
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
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey[100]),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      getImage(ImageSource.gallery);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 30),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Ime',
                                      hintText: 'Unesite vaše ime'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _surnameController,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Prezime',
                                      hintText: 'Unesite vaše prezime'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10),
                              child: SizedBox(
                                height: 55,
                                child: DropdownButtonFormField(
                                    elevation: 0,
                                    borderRadius: BorderRadius.circular(15),
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 16),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    value: dropdownValue,
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        alignment: Alignment.centerLeft,
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _emailController,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.alternate_email),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Email',
                                      hintText: 'Unesite vaš email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _passController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Lozinka',
                                      hintText: 'Unesite vašu lozinku'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 10),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      labelText: 'Telefon',
                                      hintText: 'Unesite vaš broj telefona'),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_checkFields(
                                          _nameController.text,
                                          _surnameController.text,
                                          _emailController.text,
                                          _passController.text,
                                          dropdownValue,
                                          _phoneController.text)) {
                                        _register(
                                            _nameController.text,
                                            _surnameController.text,
                                            _emailController.text,
                                            _passController.text,
                                            dropdownValue,
                                            _phoneController.text,
                                            image);
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
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
                                      'Registrujte se',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                '/login-page');
                                      },
                                      child: const Text(
                                        "Imate nalog? Prijavite se",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
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
        ),
      ]),
    );
  }

  bool _checkFields(String name, String surname, String email, String pass,
      String uni, String phone) {
    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        pass.isEmpty ||
        uni.isEmpty ||
        phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Morate popuniti sva polja'),
        ),
      );
      return false;
    }

    // check if email is valid using regex
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email nije validan'),
        ),
      );
      return false;
    }

    // check if password is valid using regex
    if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")
        .hasMatch(pass)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Lozinka mora imati najmanje 8 karaktera, jedno veliko slovo i jedan broj'),
        ),
      );
      return false;
    }

    // check if phone number is valid using regex
    if (!RegExp(r"^(06)[0-9]{7,8}$").hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Broj telefona nije validan'),
        ),
      );
      return false;
    }

    // check if name and surname are valid using regex
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(name) ||
        !RegExp(r"^[a-zA-Z]+$").hasMatch(surname)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ime i prezime moraju sadržati samo slova'),
        ),
      );
      return false;
    }

    return true;
  }
}
