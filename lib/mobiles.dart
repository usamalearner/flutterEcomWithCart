// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:ecommerce/card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mobiles extends StatelessWidget {

   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('mobiles').snapshots();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
         appBar: AppBar(
            backgroundColor: Colors.red[700],
            title: Center(child: Text("MOBILES")),
          ),
          drawer: Drawer(
            
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/5797908/pexels-photo-5797908.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                  fit: BoxFit.fitHeight)),
            child: ListView(
              
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/5357363/pexels-photo-5357363.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    fit: BoxFit.fitWidth)
                  ),
                  
                  child: Text(""),
                ),
                GestureDetector(
                  onTap: () {}, child : ListTile(
                    tileColor: Colors.pink[100],
                    title: Text("Name"),subtitle: Text("Usama"),),
                ),
                ListTile(
                  tileColor: Colors.pink[200],
                  title: Text('Email'),subtitle: Text("Usama@gmail.com"),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  title: Text('Phone'),subtitle: Text("03122063585"),
                )
              ],
            ),
          ),
        ),
        body: DecoratedBox(
           decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/3825880/pexels-photo-3825880.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                  fit: BoxFit.cover)),
          child: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map data = document.data();
            return CardComponent(data:data);
          }).toList(),
        );
      },
    )
           
        ),
      ),
    );
  }
}

