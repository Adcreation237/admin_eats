import 'package:admin_eats/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushAndRemoveUntil(
      context,
      // ignore: non_constant_identifier_names
      MaterialPageRoute(builder: (Context) {
        return LoginScreen();
      }),
      (route) => false,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0, fontFamily: "Lato");

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
          fontStyle: FontStyle.normal),
      bodyTextStyle: bodyStyle,
      titlePadding: EdgeInsets.only(top: 15.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 5.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(10),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      doneColor: Colors.deepOrangeAccent,
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('step1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('step2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('step3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.deepOrangeAccent),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.deepOrangeAccent),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.deepOrangeAccent)),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.deepOrangeAccent,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
