import 'package:admin_eats/admin/dashbord.dart';
import 'package:admin_eats/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    String email = "";

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
        Navigator.pushAndRemoveUntil(
          context,
          // ignore: non_constant_identifier_names
          MaterialPageRoute(builder: (Context) {
            return Dashboard();
          }),
          (route) => false,
        );
      }
    });
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
