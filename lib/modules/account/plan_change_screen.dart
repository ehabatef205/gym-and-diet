import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class PlanChangeScreen extends StatefulWidget {
  final int indexLanguage;
  final String shape;

  const PlanChangeScreen({this.indexLanguage, this.shape});

  @override
  _PlanChangeScreenState createState() => _PlanChangeScreenState();
}

class _PlanChangeScreenState extends State<PlanChangeScreen> {
  int plan = 0;

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

  List<String> language3 = [
    "Are you sure you want to start a new program / challenge",
    "هل أنت متأكد أنك تريد بدء برنامج / تحدي جديد",
  ];

  List<String> language4 = ["No", "لا"];

  List<String> language5 = ["Yes", "نعم"];

  int yourPlan;

  String yourShape = "";

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        yourPlan = int.parse(value.data()["plan"]);
        yourShape = value.data()["shape"];
      });
    }).whenComplete(() {
      setState(() {
        plan = yourPlan;
      });
    });
  }

  Future deletePlan() async {
    await FirebaseFirestore.instance
        .collection(yourShape)
        .doc(yourShape)
        .collection("$yourPlan day")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        deletePlanInId(element.id);
      });
    });
  }

  Future deletePlanInId(String dataId) async {
    await FirebaseFirestore.instance
        .collection(yourShape)
        .doc(yourShape)
        .collection("$yourPlan day")
        .doc(dataId)
        .collection("section")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        deletePlanInId2(dataId, element.id);
      });
    });
  }

  Future deletePlanInId2(String dataId, String dataId2) async {
    await FirebaseFirestore.instance
        .collection(yourShape)
        .doc(yourShape)
        .collection("$yourPlan day")
        .doc(dataId)
        .collection("section")
        .doc(dataId2)
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
  }

  Future setPlan() async {
    await FirebaseFirestore.instance
        .collection(widget.shape)
        .doc(widget.shape)
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
        .collection(widget.shape)
        .doc(widget.shape)
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
        .collection(widget.shape)
        .doc(widget.shape)
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
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backColor,
          title: Text(
            "${language[widget.indexLanguage]}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: backColor,
        body: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                children: [
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
                      yourShape == widget.shape && plan == yourPlan
                          ? () {}
                          : showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: backColor,
                                  title: Text(
                                    "${language3[widget.indexLanguage]}",
                                    style: TextStyle(color: Colors.white),
                                    textDirection: widget.indexLanguage == 1
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                          child: Text(language4[
                                              widget.indexLanguage]),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        RaisedButton(
                                            child: Text(language5[
                                                widget.indexLanguage]),
                                            onPressed: () async {
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser.uid)
                                                  .update({
                                                "shape": widget.shape,
                                                "plan": plan.toString(),
                                              }).whenComplete(() {
                                                deletePlan().whenComplete(() {
                                                  setPlan().whenComplete(() {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WorkoutScreen(
                                                          indexLanguage: widget
                                                              .indexLanguage,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                });
                                              });
                                            }),
                                      ],
                                    )
                                  ],
                                );
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
    );
  }
}
