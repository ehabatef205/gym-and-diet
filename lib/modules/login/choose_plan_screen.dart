import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:http/http.dart';

class ChoosePlanScreen extends StatefulWidget {
  final int indexLanguage;
  final String shape;

  const ChoosePlanScreen({this.indexLanguage, this.shape});

  @override
  _ChoosePlanScreenState createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  int plan;
  String _timezone = 'Unknown';
  var data2;
  var s;
  DateTime start_date;
  DateTime end_date;

  List<String> language = [
    "How many days want to your workout?",
    "كم يوما تريد التمرين الخاص بك؟",
  ];

  List<String> language1 = [
    "Days",
    "أيام",
  ];

  List<String> language2 = [
    "Continue",
    "استمرار",
  ];

  var data;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        data = value.data();
      });
    });

    _initData().whenComplete(() {
      getDate();
    });
  }

  List<String> ids = [];

  Future setPlan() async {
    await FirebaseFirestore.instance
        .collection(data["shape"])
        .doc(data["shape"])
        .collection("$plan day")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setPlanInId(element.id);
      });
    });
  }

  Future setPlanInId(String dataId) async {
    await FirebaseFirestore.instance
        .collection(data["shape"])
        .doc(data["shape"])
        .collection("$plan day")
        .doc(dataId)
        .collection("section")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setPlanInId2(dataId, element.id);
      });
    });
  }

  Future setPlanInId2(String dataId, String dataId2) async {
    await FirebaseFirestore.instance
        .collection(data["shape"])
        .doc(data["shape"])
        .collection("$plan day")
        .doc(dataId)
        .collection("section")
        .doc(dataId2)
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      "done": false,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: backColor,
          body: SafeArea(
            child: Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${language[widget.indexLanguage]}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorTileColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: 3,
                              title: new Text(
                                "3 ${language1[widget.indexLanguage]}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              activeColor: simpleBackColor,
                              groupValue: plan,
                              onChanged: (newValue) {
                                setState(() {
                                  plan = newValue;
                                });
                                print(plan);
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorTileColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: 4,
                              title: new Text(
                                "4 ${language1[widget.indexLanguage]}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              activeColor: simpleBackColor,
                              groupValue: plan,
                              onChanged: (newValue) {
                                setState(() {
                                  plan = newValue;
                                });
                                print(plan);
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorTileColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: 5,
                              title: new Text(
                                "5 ${language1[widget.indexLanguage]}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              activeColor: simpleBackColor,
                              groupValue: plan,
                              onChanged: (newValue) {
                                setState(() {
                                  plan = newValue;
                                });
                                print(plan);
                              }),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: simpleBackColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          plan == null
                              ? () {}
                              : FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .update(
                                  {
                                    "plan": plan.toString(),
                                    "start_date":
                                        "${start_date.year}-${start_date.month}-${start_date.day}",
                                    "end_date":
                                        "${end_date.year}-${end_date.month}-${end_date.day}"
                                  },
                                ).whenComplete(() {
                                  setPlan().whenComplete(() {
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
                        },
                        child: Text(
                          "${language2[widget.indexLanguage]}",
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
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _initData() async {
    try {
      _timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
  }

  getDate() async {
    Response response =
        await get(Uri.http('worldtimeapi.org', '/api/timezone/${_timezone}'));
    await (data2 = jsonDecode(response.body));
    s = data2["utc_datetime"].toString().split("T")[0].split("-");
    start_date = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
    end_date = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]))
        .add(Duration(days: 7));
  }
}
