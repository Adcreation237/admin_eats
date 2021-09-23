import 'package:admin_eats/admin/slider_bar.dart';
import 'package:flutter/material.dart';

class Revenus extends StatefulWidget {
  const Revenus({Key? key}) : super(key: key);

  @override
  _RevenusState createState() => _RevenusState();
}

class _RevenusState extends State<Revenus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SliderBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Revenus"),
      ),
      body: Center(),
    );
  }
}
