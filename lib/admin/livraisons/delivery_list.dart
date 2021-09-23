import 'package:admin_eats/admin/slider_bar.dart';
import 'package:flutter/material.dart';

class DeliveryList extends StatefulWidget {
  const DeliveryList({Key? key}) : super(key: key);

  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SliderBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Delivery"),
      ),
      body: Center(),
    );
  }
}
