// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
 
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
   final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('cart').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(child: Text("CART")),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/6097841/pexels-photo-6097841.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  fit: BoxFit.cover)),
          child: Center(
              child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map data = document.data();
                  return 
                  cartList(data);
                }).toList(),
              );
            },
          )),
        ),
      ),
    );
  }
}


Widget cartList(data) {
  return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data["url"]),
        radius: 40,
      ),
      title: Text(data["title"]),
      subtitle: Text(data["price"],style: TextStyle(color: Colors.red[900])),
      );
}
