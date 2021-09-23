import 'package:admin_eats/auth/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool isLoading = false;

  void loginState(String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.email!.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
          msg: "Le compte " +
              userCredential.user!.email.toString() +
              " a été connecté !",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
        );
        Navigator.pushAndRemoveUntil(
          context,
          // ignore: non_constant_identifier_names
          MaterialPageRoute(builder: (Context) {
            return Wrapper();
          }),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(
          msg: "An error appear.",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
        );
        setState(() {
          isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
        );
        setState(() {
          isLoading = false;
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user.",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign In to start.",
                    style: TextStyle(
                        fontFamily: "Roboto", fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: email,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter your Email address !";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Your Email",
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    obscureText: true,
                    controller: password,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (value.length >= 8) {
                          return null;
                        } else {
                          return "Password too short. 8 characters requiered !";
                        }
                      } else {
                        return "Please enter your Password !";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Your Password",
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        print("Email : ${email.text}");
                        print("Email : ${password.text}");
                        loginState(email.text, password.text);
                      }
                    },
                    height: 50,
                    minWidth: isLoading == true ? null : double.infinity,
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: isLoading == true
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "Connexion",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account ?"),
                      TextButton(onPressed: () {}, child: Text("Register."))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
