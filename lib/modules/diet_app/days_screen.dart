import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/diet_app/choose_meal.dart';
import 'package:gym_and_diet/shared/network/remote/connection_firebase.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class DaysScreen extends StatefulWidget {
  final int indexLanguage;
  final double weight;
  final String unit;

  const DaysScreen({this.indexLanguage, this.weight, this.unit});

  @override
  _DaysScreenState createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  bool loading = false;

  String weights;

  @override
  void initState() {
    super.initState();
    getDiet().whenComplete(() {
      print(weights);
      setState(() {
        loading = true;
      });
    });
  }

  List<String> languageOfData = [
    "En",
    "Ar",
    "Fr",
    "Sp",
    "Tu",
    "Ru",
  ];

  List<String> language = [
    "My Diet",
    "نظامي الغذائي",
    "mon régime",
    "mi dieta",
    "benim diyetim",
    "моя диета",
  ];

  Future getDiet() async {
    if (widget.unit == "lbs") {
      double w = widget.weight * 0.45359237;
      if (w < 91) {
        setState(() {
          weights = "70-90";
        });
      } else if (w > 90 && w < 111) {
        setState(() {
          weights = "91-110";
        });
      } else if (w > 110 && w < 131) {
        setState(() {
          weights = "111-130";
        });
      } else if (w > 130 && w < 151) {
        setState(() {
          weights = "131-150";
        });
      } else {
        setState(() {
          weights = "more150";
        });
      }
    } else {
      if (widget.weight < 91) {
        setState(() {
          weights = "70-90";
        });
      } else if (widget.weight > 90 && widget.weight < 111) {
        setState(() {
          weights = "91-110";
        });
      } else if (widget.weight > 110 && widget.weight < 131) {
        setState(() {
          weights = "111-130";
        });
      } else if (widget.weight > 130 && widget.weight < 151) {
        setState(() {
          weights = "131-150";
        });
      } else {
        setState(() {
          weights = "more150";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: loading
          ? Scaffold(
              appBar: AppBar(
                title: Text(
                  "${language[widget.indexLanguage]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                backgroundColor: backColor,
                elevation: 0,
                centerTitle: true,
              ),
              backgroundColor: backColor,
              body: StreamBuilder<QuerySnapshot>(
                stream: getMyDiet(
                  collection1: weights,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.docs;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChooseMeal(
                                      indexLanguage: widget.indexLanguage,
                                      data: data[index],
                                    ),
                                  ),
                                );
                              },
                              title: Text(
                                data[index][
                                    "day${languageOfData[widget.indexLanguage]}"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: simpleBackColor,
                      ),
                    );
                  }
                },
              ))
          : Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Gym & Diet",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                leading: Container(),
                backgroundColor: backColor,
                elevation: 0,
                centerTitle: true,
              ),
              backgroundColor: backColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: simpleBackColor,
                ),
              ),
            ),
    );
  }
}
