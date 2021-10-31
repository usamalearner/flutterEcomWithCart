// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // void imagePick() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final image = await _picker.getImage(source: ImageSource.gallery);
  //   print(image.path);
  // }

  void register() async {
    
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String phone = phoneController.text;
    final String address = addressController.text;
    print(username);
    print(email);
    print(password);
    print(phone);
    print(address);

    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      db
          .collection("users")
          .doc(user.user.uid)
          .set({
          'email': email, 
          'username': username,
          'phone':phone,
          'address':address,

          });

      Navigator.of(context).pushNamed("/categories");
    } catch (e) {
      print("error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown[900],
          title: Center(child: Text("REGISTER")),
        ),
      body: SingleChildScrollView(
        child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/1467435/pexels-photo-1467435.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.cover),
                    ),
          child: Center(
            child: Container(
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SafeArea(
                child: Column(children: [
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter your username",
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter your email",
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter your password",
                    ),
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter your Phone No",
                    ),
                  ),
                       TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Enter your Address",
                    ),
                  ),
                  ElevatedButton(onPressed: register,
                   child: Text("REGISTER"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                        padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 15))),
                  ),
                  // ElevatedButton(onPressed: imagePick, child: Text("Profile Pic"))
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}