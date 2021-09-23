import 'package:admin_eats/admin/slider_bar.dart';
import 'package:flutter/material.dart';

class ProfilSettings extends StatefulWidget {
  const ProfilSettings({Key? key}) : super(key: key);

  @override
  _ProfilSettingsState createState() => _ProfilSettingsState();
}

class _ProfilSettingsState extends State<ProfilSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SliderBar(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Settings"),
      ),
      body: Center(),
    );
  }
}
