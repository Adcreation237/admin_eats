import 'package:admin_eats/admin/categories/categories.dart';
import 'package:admin_eats/admin/dashbord.dart';
import 'package:admin_eats/admin/livraisons/delivery_list.dart';
import 'package:admin_eats/admin/livreurs/deliver.dart';
import 'package:admin_eats/admin/orders/orders_list.dart';
import 'package:admin_eats/admin/product/product_list.dart';
import 'package:admin_eats/admin/revenus/revenus.dart';
import 'package:admin_eats/admin/settings/profil_settings.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SliderBar extends StatefulWidget {
  const SliderBar({Key? key}) : super(key: key);

  @override
  _SliderBarState createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/profil.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pauline",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        currentUser!.email.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            buildMenuItem(
              text: "Dashboard",
              icon: Icons.dashboard_outlined,
              press: () {
                selectedItem(context, 0);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Menus",
              icon: Icons.category_outlined,
              press: () {
                selectedItem(context, 1);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Plats",
              icon: Icons.apps_outlined,
              press: () {
                selectedItem(context, 2);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Commandes",
              icon: Icons.local_dining_outlined,
              press: () {
                selectedItem(context, 3);
              },
              widget: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      "8",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Livraisons",
              icon: Icons.local_shipping_outlined,
              press: () {
                selectedItem(context, 4);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Livreurs",
              icon: Icons.delivery_dining_outlined,
              press: () {
                selectedItem(context, 5);
              },
            ),
            SizedBox(height: 10),
            Divider(
              height: 5,
            ),
            buildMenuItem(
              text: "Revenus",
              icon: Icons.account_balance_wallet_outlined,
              press: () {
                selectedItem(context, 6);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Setings",
              icon: Icons.settings,
              press: () {
                selectedItem(context, 7);
              },
            ),
            SizedBox(height: 5),
            buildMenuItem(
              text: "Exit",
              icon: Icons.logout_outlined,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required Function() press,
    Widget? widget,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      onTap: press,
      hoverColor: Colors.white,
      trailing: widget,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Dashboard()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Categories()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductList()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OrdersList()));
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DeliveryList()));
        break;
      case 5:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DeliverList()));
        break;
      case 6:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Revenus()));
        break;
      case 7:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfilSettings()));
        break;
      default:
        null;
    }
  }
}
