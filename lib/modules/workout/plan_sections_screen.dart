import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_and_diet/modules/workout/how_to_do_it_screen.dart';
import 'package:gym_and_diet/shared/network/remote/connection_firebase.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanSectionsScreen extends StatefulWidget {
  final data;
  final int indexLanguage;
  final String collection2;
  final dataOfUser;

  const PlanSectionsScreen({
    this.data,
    this.dataOfUser,
    this.indexLanguage,
    this.collection2,
  });

  @override
  _PlanSectionsScreenState createState() => _PlanSectionsScreenState();
}

class _PlanSectionsScreenState extends State<PlanSectionsScreen>
    with SingleTickerProviderStateMixin {
  int currentValue = 0;

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  double day = 0.5;

  bool isTrue = false;

  bool isDone = false;

  List doneUsed = [];

  int numberIsTrue = 0;

  List<String> list = [];

  String a = "";

  Future setPlan() async {
    await FirebaseFirestore.instance
        .collection(widget.dataOfUser["shape"])
        .doc(widget.dataOfUser["shape"])
        .collection(widget.collection2)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setPlanInId(element.id);
      });
    });
  }

  Future setPlanInId(String dataId) async {
    await FirebaseFirestore.instance
        .collection(widget.dataOfUser["shape"])
        .doc(widget.dataOfUser["shape"])
        .collection(widget.collection2)
        .doc(widget.data.id)
        .collection("section")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setPlanInId2(element.id);
      });
    });
  }

  Future setPlanInId2(String dataId) async {
    var doc = await FirebaseFirestore.instance
        .collection(widget.dataOfUser["shape"])
        .doc(widget.dataOfUser["shape"])
        .collection(widget.collection2)
        .doc(widget.data.id)
        .collection("section")
        .doc(dataId)
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    if (!doc.exists) {
      await FirebaseFirestore.instance
          .collection(widget.dataOfUser["shape"])
          .doc(widget.dataOfUser["shape"])
          .collection(widget.collection2)
          .doc(widget.data.id)
          .collection("section")
          .doc(dataId)
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        "done": false,
      });
    }
  }

  Future<void> getDone() async {
    await FirebaseFirestore.instance
        .collection(widget.dataOfUser["shape"])
        .doc(widget.dataOfUser["shape"])
        .collection(widget.collection2)
        .doc(widget.data.id)
        .collection("section")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        list.add(element.id);
      });
    });
  }

  Future<void> getDone1() async {
    for (int i = 0; i < list.length; i++) {
      await FirebaseFirestore.instance
          .collection(widget.dataOfUser["shape"])
          .doc(widget.dataOfUser["shape"])
          .collection(widget.collection2)
          .doc(widget.data.id)
          .collection("section")
          .doc(list[i])
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        doneUsed.add(value.data()["done"]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setPlan().whenComplete(() {
      getDone().whenComplete(() {
        getDone1().whenComplete(() {
          print(doneUsed);
          doneUsed.forEach((element) {
            if (element == true) {
              setState(() {
                numberIsTrue++;
              });
            }
          });
          setState(() {
            isDone = true;
          });
        });
      });
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.data["${languageOfName[widget.indexLanguage]}"],
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          flexibleSpace: Container(
            height: size.height * 0.18,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.data["image"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: backColor,
        body: Column(
          children: [
            isDone
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width *
                              (numberIsTrue / doneUsed.length),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: simpleBackColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Expanded(child: getPlanSection()),
          ],
        ),
      ),
    );
  }

  Widget getPlanSection() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: getPlanSections(
          collection1: widget.dataOfUser["shape"],
          doc1: widget.dataOfUser["shape"],
          collection2: widget.collection2,
          id: widget.data.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HowToDoItScreen(
                                        data: data[index],
                                        dataOfUser: widget.dataOfUser,
                                        indexLanguage: widget.indexLanguage)));
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: NetworkImage(
                                    data[index]["image"],
                                  ),
                                  fit: BoxFit.fill,
                                  width: size.width * 0.2,
                                  height: size.width * 0.2,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index][
                                            "${languageOfName[widget.indexLanguage]}"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: isDone
                          ? Checkbox(
                              value: doneUsed[index],
                              onChanged: (value) {
                                FirebaseFirestore.instance
                                    .collection(widget.dataOfUser["shape"])
                                    .doc(widget.dataOfUser["shape"])
                                    .collection(widget.collection2)
                                    .doc(widget.data.id)
                                    .collection("section")
                                    .doc(data[index].id)
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .update({
                                  "done": value,
                                });
                                if (value == true) {
                                  setState(() {
                                    numberIsTrue++;
                                  });
                                } else {
                                  setState(() {
                                    numberIsTrue--;
                                  });
                                }
                                setState(() {
                                  doneUsed[index] = value;
                                });
                              },
                              activeColor: simpleBackColor,
                            )
                          : Container(),
                    ),
                  ],
                );
              });
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: simpleBackColor,
            ),
          );
        }
      },
    );
  }
}
