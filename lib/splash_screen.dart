import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/login/choose_plan_screen.dart';
import 'package:gym_and_diet/modules/login/language_screen.dart';
import 'package:gym_and_diet/modules/login/login_screen.dart';
import 'package:gym_and_diet/modules/login/shape_screen.dart';
import 'package:gym_and_diet/modules/login/verify_email_screen.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;

  int indexOfLanguage;

  bool isLoad = false;

  bool isAvailable = false;
  bool isAvailable2 = false;
  Map data;

  String _timezone = 'Unknown';
  var data2;
  var s;
  var s2;
  DateTime start_date;
  DateTime end_date;

  Future<void> _initData() async {
    try {
      _timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
  }

  Future getDate() async {
    Response response =
    await get(Uri.http('worldtimeapi.org', '/api/timezone/${_timezone}'));
    await (data2 = jsonDecode(response.body));
    s = data2["utc_datetime"].toString().split("T")[0].split("-");
    start_date = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
    s2 = data["end_date"].toString().split("-");
    isAvailable = DateTime(start_date.year, start_date.month, start_date.day)
        .isAfter(
        DateTime(int.parse(s2[0]), int.parse(s2[1]), int.parse(s2[2])));
  }

  Future getValidationLanguage() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var obtainedId = sharedPreferences.getInt("indexOfLanguage");
    indexOfLanguage = obtainedId;
    print(obtainedId.toString());
  }

  @override
  void initState() {
    super.initState();
    getValidationLanguage().whenComplete(() {
      if (user != null) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .get()
            .then((value) {
          setState(() {
            data = value.data();
          });
        }).whenComplete(() {
          _initData().whenComplete(() {
            getDate().whenComplete(() {
              print("Welcome to gym ${isAvailable}");
              if (data["available"]) {
                setState(() {
                  isAvailable2 = data["available"];
                });
              }
            });
          });
        });
      }
    }).whenComplete(() {
      Timer(Duration(seconds: 5), () {
        indexOfLanguage == null
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageScreen(),
          ),
        )
            : user == null
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoginScreen(
                  indexLanguage: indexOfLanguage,
                ),
          ),
        )
            : !user.emailVerified
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerifyEmailScreen(
                  indexLanguage: indexOfLanguage,
                ),
          ),
        )
            : data["shape"] == ""
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShapeScreen(
                  indexLanguage: indexOfLanguage,
                ),
          ),
        )
            : data["plan"] == ""
            ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChoosePlanScreen(
                  indexLanguage: indexOfLanguage,
                ),
          ),
        )
            : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WorkoutScreen(
                    indexLanguage: indexOfLanguage),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.5,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/iconApp.png"),
                    )),
              ),
              Text(
                "Gym & Diet",
                style: TextStyle(color: simpleBackColor, fontSize: 25),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
