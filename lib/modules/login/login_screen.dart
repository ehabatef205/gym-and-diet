import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:gym_and_diet/modules/login/forgot_screen.dart';
import 'package:gym_and_diet/modules/login/gender_Screen.dart';
import 'package:gym_and_diet/modules/login/login_language_lists.dart';
import 'package:gym_and_diet/modules/login/verify_email_screen.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  final int indexLanguage;

  const LoginScreen({this.indexLanguage});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isLoading = false;

  List<List<String>> languages = [
    LoginEnglish,
    LoginArabic,
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
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: backColor,
        body: Directionality(
          textDirection:
              widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
          child: Stack(
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
                                  obscureText: isObscure,
                                  obscuringCharacter: "*",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: widget.indexLanguage == 1
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordScreen(
                                                      indexLanguage:
                                                          widget.indexLanguage,
                                                    )));
                                      },
                                      child: Text(
                                        "${language[5]}",
                                        style: TextStyle(
                                          color: simpleBackColor,
                                        ),
                                      ),
                                    ),
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
                                          _validate(context);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                "${language[6]}",
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
                                      language[9],
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
                                                builder: (context) =>
                                                    GenderScreen(
                                                        isGoogle: false,
                                                        indexLanguage: widget
                                                            .indexLanguage)));
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
                                    "${language[7]}",
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        await firebaseAuth
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .whenComplete(() {
          if (firebaseAuth.currentUser.emailVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkoutScreen(
                        indexLanguage: widget.indexLanguage,
                      )),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyEmailScreen(
                        indexLanguage: widget.indexLanguage,
                      )),
            );
          }
        });
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "${language[8]}",
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

  String userImageUrl = "";

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
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final String emailGoogle = await googleUser.email;
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailGoogle);
      if (list.isNotEmpty) {
        print("true");
        UserCredential userCredential = await signInWithGoogle();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenderScreen(
              isGoogle: true,
              indexLanguage: widget.indexLanguage,
            ),
          ),
        );
      }
    } catch (error) {
      print("");
    }
  }
}
