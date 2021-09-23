import 'package:admin_eats/auth/wrapper.dart';
import 'package:admin_eats/onBoard/onboarding.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  int? initScreen;
  void asyncMehod() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = await preferences.getInt('initScreen');
    await preferences.setInt('initScreen', 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncMehod();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var d = Duration(seconds: 5);

          Future.delayed(d, () {
            initScreen == 0 || initScreen == null
                ? Navigator.pushAndRemoveUntil(
                    context,
                    // ignore: non_constant_identifier_names
                    MaterialPageRoute(builder: (Context) {
                      return OnBoarding();
                    }),
                    (route) => false,
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    // ignore: non_constant_identifier_names
                    MaterialPageRoute(builder: (Context) {
                      return Wrapper();
                    }),
                    (route) => false,
                  );
          });
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Flash(
                  duration: Duration(seconds: 3),
                  child: Image.asset(
                    "assets/images/logo_o.png",
                    width: 350,
                    height: 350,
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          print("Error " + snapshot.error.toString());
          return ErrorWidget();
        }
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied_outlined,
              size: 140,
              color: Colors.grey,
            ),
            Text("Check Your Connexion, please"),
          ],
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 140,
            ),
            Flash(child: Text("Something went wrong !")),
          ],
        ),
      ),
    );
  }
}
