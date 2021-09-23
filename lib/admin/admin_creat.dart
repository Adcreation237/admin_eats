// ignore_for_file: unnecessary_statements, deprecated_member_use

import 'dart:io';

import 'package:admin_eats/admin/dashbord.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatingAdmin extends StatefulWidget {
  const CreatingAdmin({Key? key}) : super(key: key);

  @override
  _CreatingAdminState createState() => _CreatingAdminState();
}

class _CreatingAdminState extends State<CreatingAdmin> {
  var currentUser = FirebaseAuth.instance.currentUser;
  var localisation;
  String? chosenValue;
  String? chosenValue2;
  TextEditingController nomEts = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController desc = TextEditingController();
  bool isLoading = false;
  String? imageUrl;

  final formKey = GlobalKey<FormState>();

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Fluttertoast.showToast(
        msg: "Location services are disabled.",
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        Fluttertoast.showToast(
          msg: "Location permissions are denied",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      Fluttertoast.showToast(
        msg:
            "Location permissions are permanently denied, we cannot request permissions.",
        textColor: Colors.white,
        timeInSecForIosWeb: 3,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    localisation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(localisation.latitude);
  }

  void addAdmin() async {
    setState(() {
      isLoading == true;
    });
    print("Started");
    try {
      DocumentReference users = FirebaseFirestore.instance
          .collection('usersResto')
          .doc(currentUser!.uid);
      await users.set({
        'iduser': currentUser!.uid,
        'nomEts': nomEts.text,
        'location': location.text,
        'repere': localisation.toString(),
        'type': chosenValue.toString(),
        'desc': desc.text,
        'images': imageUrl.toString(), // 42
      }).then((value) {
        DocumentReference users2 = FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid);
        users2.update({'statut': 'resto'});
        setState(() {
          isLoading == false;
        });
        print("Started 2");
        Fluttertoast.showToast(
          msg: "Le compte Professionnel de " +
              currentUser!.email.toString() +
              " a été crée",
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
        );
        Navigator.pushAndRemoveUntil(
          context,
          // ignore: non_constant_identifier_names
          MaterialPageRoute(builder: (Context) {
            return Dashboard();
          }),
          (route) => false,
        );
      }).catchError((error) {
        setState(() {
          isLoading == false;
        });
        Fluttertoast.showToast(
          msg: "Erreur is" + error,
          textColor: Colors.white,
          timeInSecForIosWeb: 3,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  uploadImage() async {
    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    PickedFile? image;

    await Permission.photos.request();

    var persmissionStatut = await Permission.photos.status;

    if (persmissionStatut.isGranted) {
      image = await picker.getImage(source: ImageSource.gallery);
      //await picker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        var snapshot = await storage.ref().child('Profil/resto').putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print("No file received");
      }
    } else {
      print("Grant permissions and try again");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Partner",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Register and start your business now.",
                  style: TextStyle(
                      fontFamily: "Roboto", fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                ),
                imageUrl != null
                    ? Image.network(imageUrl!)
                    : Placeholder(
                        fallbackHeight: 200,
                        fallbackWidth: double.infinity,
                      ),
                RaisedButton(
                  onPressed: () {
                    uploadImage();
                  },
                  color: Colors.deepOrangeAccent,
                  child: Text("Upload image"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: nomEts,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter the Enterprise Name !";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Name of the enterprise",
                      prefixIcon: Icon(
                        Icons.business_center_sharp,
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
                  controller: location,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your Location !";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Location of the enterprise",
                      prefixIcon: Icon(
                        Icons.location_on,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          value: chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.grey,
                          items: <String>[
                            'Restaurant',
                            'Magasin de boisson',
                            'Cafétariat',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Type of entreprise",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (value) {
                            setState(() {
                              chosenValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusColor: Colors.white,
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          value: chosenValue2,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.grey,
                          items: <String>[
                            'Livraison',
                            'A Emporter',
                            'Sur Place',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Type de service après commande",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (value) {
                            setState(() {
                              chosenValue2 = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: desc,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter your description !";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "description of the enterprise",
                      prefixIcon: Icon(
                        Icons.description,
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
                      if (chosenValue != "" && chosenValue != null) {
                        print("Email : ${nomEts.text}");
                        print("Email : ${location.text}");
                        print("Email : ${desc.text}");
                        print("Email : ${chosenValue.toString()}");
                        addAdmin();
                      } else {
                        Fluttertoast.showToast(
                          msg: "Choisir le type de restaurant.",
                          textColor: Colors.white,
                          timeInSecForIosWeb: 3,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM_LEFT,
                          backgroundColor: Colors.red,
                        );
                      }
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
                          "Active now",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
