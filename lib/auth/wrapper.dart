import 'package:admin_eats/admin/dashbord.dart';
import 'package:admin_eats/auth/login_screen.dart';
import 'package:admin_eats/deliver/Dashbord_deliver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;

    void verifyCommande() async {
      await FirebaseFirestore.instance
          .collection('usersResto')
          .where('iduser', isEqualTo: currentUser!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Navigator.pushAndRemoveUntil(
            context,
            // ignore: non_constant_identifier_names
            MaterialPageRoute(builder: (Context) {
              return Dashboard();
            }),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            // ignore: non_constant_identifier_names
            MaterialPageRoute(builder: (Context) {
              return DashBoardDeliver();
            }),
            (route) => false,
          );
        }
      });
    }

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
          context,
          // ignore: non_constant_identifier_names
          MaterialPageRoute(builder: (Context) {
            return LoginScreen();
          }),
          (route) => false,
        );
      } else {
        verifyCommande();
      }
    });
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
