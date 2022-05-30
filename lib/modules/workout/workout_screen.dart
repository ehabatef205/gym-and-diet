import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_and_diet/modules/account/account_screen.dart';
import 'package:gym_and_diet/modules/diet_app/days_screen.dart';
import 'package:gym_and_diet/modules/health_app/health_app_screen.dart';
import 'package:gym_and_diet/modules/login/login_screen.dart';
import 'package:gym_and_diet/modules/workout/plan_sections_screen.dart';
import 'package:gym_and_diet/modules/workout/programs_screen.dart';
import 'package:gym_and_diet/modules/workout/workout_language.dart';
import 'package:gym_and_diet/shared/network/remote/connection_firebase.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  final int indexLanguage;

  const WorkoutScreen({this.indexLanguage});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  bool isTrainers = true;

  List<List<String>> languages = [
    workoutEnglish,
    workoutArabic,
  ];

  List<String> language;

  Map data1;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    print(FirebaseAuth.instance.currentUser.uid);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        data1 = value.data();
      });
    }).whenComplete(() {
      setState(() {
        loading = true;
      });
    });
    setState(() {
      language = languages[widget.indexLanguage];
    });
  }

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Directionality(
        textDirection:
            widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
        child: loading
            ? Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Gym & Diet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  backgroundColor: backColor,
                  elevation: 0,
                  centerTitle: true,
                ),
                backgroundColor: backColor,
                drawer: Drawer(
                  child: Container(
                    color: backColor,
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                          currentAccountPicture: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data1["image"])),
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.12),
                            ),
                          ),
                          accountName: Text(data1["username"]),
                          accountEmail: Text(data1["email"]),
                          decoration: BoxDecoration(
                            color: backColor,
                          ),
                          currentAccountPictureSize:
                              Size(size.width * 0.24, size.width * 0.24),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                            color: simpleBackColor,
                          ),
                          title: Text(
                            language[4],
                            style: TextStyle(color: simpleBackColor),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountScreen(
                                    indexLanguage: widget.indexLanguage),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.directions_walk,
                            color: simpleBackColor,
                          ),
                          title: Text(
                            language[3],
                            style: TextStyle(color: simpleBackColor),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HealthAppScreen(
                                    indexLanguage: widget.indexLanguage),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.no_food_outlined,
                            color: simpleBackColor,
                          ),
                          title: Text(
                            language[7],
                            style: TextStyle(color: simpleBackColor),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DaysScreen(
                                    indexLanguage: widget.indexLanguage,
                                    weight: double.parse(data1["weight"]),
                                    unit: data1["units"]),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.all_inclusive_sharp,
                            color: simpleBackColor,
                          ),
                          title: Text(
                            language[5],
                            style: TextStyle(color: simpleBackColor),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgramsScreen(
                                    dataOfUser: data1,
                                    indexLanguage: widget.indexLanguage),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          onTap: () {
                            FirebaseAuth.instance.signOut().whenComplete(() {
                              GoogleSignIn().signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(
                                            indexLanguage: widget.indexLanguage,
                                          )));
                            });
                          },
                          leading: Icon(
                            Icons.logout,
                            color: simpleBackColor,
                          ),
                          title: Text(
                            language[6],
                            style: TextStyle(color: simpleBackColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: StreamBuilder<QuerySnapshot>(
                  stream: getPlans(
                      collection1: data1["shape"],
                      doc1: data1["shape"],
                      collection2: "${data1["plan"]} day"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data.docs;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == data.length - 1
                                    ? EdgeInsets.only(
                                        bottom: size.height * 0.11, top: 5)
                                    : const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  width: double.infinity,
                                  height: size.height * 0.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(data[index]["image"]),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: MaterialButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PlanSectionsScreen(
                                            data: data[index],
                                            collection2: "${data1["plan"]} day",
                                            indexLanguage: widget.indexLanguage,
                                            dataOfUser: data1,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: size.height * 0.2,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        alignment: widget.indexLanguage == 1
                                            ? Alignment.bottomRight
                                            : Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            data[index][
                                                "${languageOfName[widget.indexLanguage]}"],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
      ),
    );
  }
}
