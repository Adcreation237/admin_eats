import 'package:admin_eats/admin/slider_bar.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SliderBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Commandes"),
      ),
      body: Center(),
    );
  }
}
