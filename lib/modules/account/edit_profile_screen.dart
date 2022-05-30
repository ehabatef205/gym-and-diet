import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gym_and_diet/modules/account/view_profile_language.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class EditProfile extends StatefulWidget {
  final data;
  final int indexLanguage;

  const EditProfile({this.data, this.indexLanguage});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  List<List<String>> languages = [
    ViewProfileEnglish,
    ViewProfileArabic,
  ];

  List<String> language;

  String selectedUnit = "Kg";

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      language = languages[widget.indexLanguage];
    });
    nameController.text = widget.data["username"];
    emailController.text = widget.data["email"];
    phoneController.text = widget.data["phone"];
    ageController.text = widget.data["age"];
    weightController.text = widget.data["weight"];
    heightController.text =
        widget.data["heights"].toString().replaceAll(" cm", "");
    selectedUnit = widget.data["units"];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "${language[15]}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: backColor,
          ),
          backgroundColor: backColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: _imageFile == null
                                        ? NetworkImage(widget.data["image"])
                                        : FileImage(_imageFile),
                                  ),
                                ),
                              ),
                              onTap: () {
                                _selectAndPickImage();
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: simpleBackColor),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          labelText: "${language[1]}",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "${language[2]}";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          labelText: "${language[5]}",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "${language[6]}";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          labelText: "${language[12]}",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "${language[16]}";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: weightController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  labelText: "${language[13]}",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "${language[17]}";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.grey,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 20),
                            child: Text(selectedUnit, style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: heightController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  labelText: "${language[14]}",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "${language[18]}";
                                  }
                                  return null;
                                },
                                cursorColor: Colors.grey,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, right: 20),
                            child: Text("Cm", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: simpleBackColor,
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                uploadToStorage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: simpleBackColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Text(
                                    "${language[19]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  File _imageFile;
  String userImageUrl = "";

  Future<void> _selectAndPickImage() async {
    var pickerImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickerImage.path);
    });
  }

  uploadToStorage() async {
    setState(() {
      isLoading = true;
    });
    var user = FirebaseAuth.instance.currentUser;
    if (_imageFile == null) {
      setState(() {
        userImageUrl = widget.data["image"];
      });
      saveUserInfoToFireStore(user).whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutScreen(
              indexLanguage: widget.indexLanguage,
            ),
          ),
        );
      });
      setState(() {
        isLoading = false;
      });
    } else {
      String imageFileName = emailController.text;

      Reference reference =
          FirebaseStorage.instance.ref().child("Users").child(imageFileName);

      UploadTask uploadTask = reference.putFile(_imageFile);

      await uploadTask.whenComplete(() async {
        await reference.getDownloadURL().then((urlImage) {
          userImageUrl = urlImage;

          saveUserInfoToFireStore(user).whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutScreen(
                  indexLanguage: widget.indexLanguage,
                ),
              ),
            );
          });
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  Future saveUserInfoToFireStore(User user) async {
    FirebaseFirestore.instance.collection("Users").doc(user.uid).update({
      "uid": user.uid,
      "username": nameController.text,
      "image": _imageFile == null ? widget.data["image"] : userImageUrl,
      "phone": phoneController.text,
      "age": "${ageController.text}",
      "heights": "${heightController.text} cm",
      "weight": "${weightController.text}",
      "units": "$selectedUnit",
    });
  }
}
