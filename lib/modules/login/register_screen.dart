import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gym_and_diet/modules/login/login_screen.dart';
import 'package:gym_and_diet/modules/login/register_language.dart';
import 'package:gym_and_diet/modules/login/shape_screen.dart';
import 'package:gym_and_diet/modules/login/verify_email_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterScreen extends StatefulWidget {
  final int indexLanguage;
  final String gender;
  final int age;
  final String units;
  final String weight;
  final int heights;

  const RegisterScreen(
      {this.indexLanguage,
      this.heights,
      this.gender,
      this.age,
      this.units,
      this.weight});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isLoading = false;

  List<List<String>> languages = [
    RegisterEnglish,
    RegisterArabic,
  ];

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
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            child: Image(
              image: AssetImage("assets/firstPage.jpg"),
              height: size.height,
              width: size.width,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, backColor],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gym & Diet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Expanded(
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
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
                                              ? AssetImage("assets/default.png")
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
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
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  child: Icon(
                                    isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
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
                              obscureText: isObscure,
                              obscuringCharacter: "*",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: cPasswordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                suffixIcon: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  child: Icon(
                                    isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                labelText: "${language[9]}",
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
                              obscureText: isObscure,
                              obscuringCharacter: "*",
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "${language[10]}";
                                } else if (passwordController.text !=
                                    cPasswordController.text) {
                                  return "${language[11]}";
                                }
                                return null;
                              },
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: simpleBackColor,
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: simpleBackColor),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        simpleBackColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      signUp();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            "${language[15]}",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "I already have an account ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginScreen(
                                                  indexLanguage:
                                                      widget.indexLanguage,
                                                )));
                                  },
                                  child: Text(
                                    "${language[0]}",
                                    style: TextStyle(
                                      color: simpleBackColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${language[16]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: simpleBackColor),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.transparent,
                                      ),
                                    ),
                                    onPressed: () {
                                      googleSignIn();
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.google,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Google",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void signUp() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        uploadAndSaveImage();
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "${language[17]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      _imageFile = await getImageFileFromAssets("default.png");
    }
    passwordController.text == cPasswordController.text
        ? emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                cPasswordController.text.isNotEmpty &&
                nameController.text.isNotEmpty
            ? _registerUser()
            : Fluttertoast.showToast(
                msg: "${language[18]}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16,
              )
        : Fluttertoast.showToast(
            msg: "${language[19]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16,
          );
  }

  uploadToStorage(User user) async {
    String imageFileName = emailController.text;

    Reference reference =
        FirebaseStorage.instance.ref().child("Users").child(imageFileName);

    UploadTask uploadTask = reference.putFile(_imageFile);

    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((urlImage) {
        userImageUrl = urlImage;

        saveUserInfoToFireStore(user).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyEmailScreen(
                        indexLanguage: widget.indexLanguage,
                      )));
        });
      });
    });
  }

  void _registerUser() async {
    User user;

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((auth) {
      user = auth.user;
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "${language[20]}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      setState(() {
        isLoading = false;
      });
    });

    if (user != null) {
      uploadToStorage(user);
    }
  }

  Future saveUserInfoToFireStore(User user) async {
    FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
      "uid": user.uid,
      "username": nameController.text,
      "email": user.email,
      "image": userImageUrl,
      "phone": phoneController.text,
      "age": "${widget.age}",
      "heights": "${widget.heights} cm",
      "weight": "${widget.weight}",
      "units": "${widget.units}",
      "gender": "${widget.gender}",
      "plan": "",
      "shape": "",
      "start_date": "",
      "end_date": "",
      "available": false
    });
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
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user.uid)
        .set({
      "uid": userCredential.user.uid,
      "username": userCredential.user.displayName,
      "email": userCredential.user.email,
      "image": userCredential.user.photoURL,
      "phone": userCredential.user.phoneNumber,
      "age": "${widget.age}",
      "heights": "${widget.heights} cm",
      "weight": "${widget.weight}",
      "units": "${widget.units}",
      "gender": "${widget.gender}",
      "plan": "",
      "shape": "",
      "start_date": "",
      "end_date": "",
      "available": false
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShapeScreen(
            indexLanguage: widget.indexLanguage,
          ),
        ),
      );
    });
  }
}
