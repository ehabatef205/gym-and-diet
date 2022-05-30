import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_and_diet/modules/login/old_language.dart';
import 'package:gym_and_diet/modules/login/register_screen.dart';
import 'package:gym_and_diet/modules/login/shape_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class OldAndWeightScreen extends StatefulWidget {
  final int indexLanguage;
  final String gender;
  final bool isGoogle;

  const OldAndWeightScreen({this.indexLanguage, this.gender, this.isGoogle});

  @override
  _OldAndWeightScreenState createState() => _OldAndWeightScreenState();
}

class _OldAndWeightScreenState extends State<OldAndWeightScreen> {
  TextEditingController age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController heights = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String selectedUnit = "Kg";

  List<List<String>> languages = [
    OldEnglish,
    OldArabic,
  ];

  bool isDone = true;

  List<String> language;

  @override
  void initState() {
    super.initState();
    setState(() {
      language = languages[widget.indexLanguage];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          "${language[0]}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: backColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    Text(
                      "${language[1]}",
                      style: TextStyle(color: Colors.white, fontSize: 31),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${language[2]}",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          labelText: "${language[3]}",
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
                            return "${language[4]}";
                          }
                          return null;
                        },
                        cursorColor: Colors.grey,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: weight,
                              keyboardType: TextInputType.number,
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: heights,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                labelText: "${language[7]}",
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
                                  return "${language[8]}";
                                }
                                return null;
                              },
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "cm",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    isDone
                        ? ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: simpleBackColor),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                simpleBackColor,
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();
                                if (widget.isGoogle) {
                                  googleSignIn();
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                        indexLanguage: widget.indexLanguage,
                                        gender: widget.gender,
                                        age: int.parse(age.text),
                                        weight: "${weight.text}",
                                        units: "$selectedUnit",
                                        heights: int.parse(heights.text),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "${language[9]}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: simpleBackColor,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void googleSignIn() async {
    UserCredential userCredential = await signInWithGoogle();
    setState(() {
      isDone = false;
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user.uid)
        .set({
      "uid": userCredential.user.uid,
      "username": userCredential.user.displayName,
      "email": userCredential.user.email,
      "image": userCredential.user.photoURL,
      "phone": userCredential.user.phoneNumber,
      "age": "${age.text}",
      "heights": "${heights.text} cm",
      "weight": "${weight.text}",
      "units": "${selectedUnit}",
      "gender": "${widget.gender}",
      "plan": "",
      "shape": "",
    }).then((value) {
      if(userCredential.user.emailVerified){
        print("Email is verified: ${userCredential.user.emailVerified}");
      }else{
        print("Email is verified: ${userCredential.user.emailVerified}");
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShapeScreen(
            indexLanguage: widget.indexLanguage,
          ),
        ),
      );
    }).whenComplete(() {
      setState(() {
        isDone = true;
      });
    });
  }
}
