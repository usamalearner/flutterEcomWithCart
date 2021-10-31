// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Map data;
  CardComponent({required this.data});

  dynamic addtocart(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(data);
    try {
      db.collection("cart").doc(data["id"]).set({
        'url': data["url"],
        'title': data["title"],
        'price': data["price"],
      });
      showAlertDialog(context);
    } catch (e) {
      print("error $e");
    }

    // FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // final String email = emailController.text;
    // final String password = passwordController.text;

    // print(email);
    // print(password);

    // try {
    //   final UserCredential user = await auth.signInWithEmailAndPassword(
    //       email: email, password: password);
    //   final DocumentSnapshot snapshot =
    //       await db.collection("users").doc(user.user.uid).get();
    //   final data = snapshot.data();
    //   print("user is logged in ");
    //   print(data["username"]);
    //    print(data["email"]);
    //     print(data["phone"]);
    //   Navigator.of(context).pushNamed("/categories",arguments: data);
    // } catch (e) {
    //   print("error $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(data["title"]),
          GestureDetector(
            onTap: () {
              showAlertPic(context, data["url"], data["price"]);
            },
            child: Image.network(
              data["url"],
              width: 100,
              height: 150,
            ),
          ),
          Text(data["desc"]),
          Text(data["price"]),
          ElevatedButton(
            onPressed: () {
              addtocart(context);
            },
            child: Text("ADD TO CART"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink),
                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 10))),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Go to Cart"),
    onPressed: () {
      Navigator.of(context).pushNamed("/cart");
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success!"),
    content: Text("Added to cart."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertPic(BuildContext context, url, price) {
  // set up the buttons

  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(price),
    content: Image.network(
      url,
      width: 120,
      height: 200,
    ),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
