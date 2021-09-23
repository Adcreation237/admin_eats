import 'package:admin_eats/admin/slider_bar.dart';
import 'package:flutter/material.dart';

class DeliverList extends StatefulWidget {
  const DeliverList({Key? key}) : super(key: key);

  @override
  _DeliverListState createState() => _DeliverListState();
}

class _DeliverListState extends State<DeliverList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SliderBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Deliver"),
      ),
      body: Center(),
    );
  }
}
