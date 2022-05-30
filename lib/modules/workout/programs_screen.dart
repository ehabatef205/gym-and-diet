import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_and_diet/modules/workout/standard_course_details_screen.dart';
import 'package:gym_and_diet/modules/workout/workout_language.dart';
import 'package:gym_and_diet/shared/network/remote/connection_firebase.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgramsScreen extends StatefulWidget {
  final int indexLanguage;
  final dataOfUser;

  const ProgramsScreen({this.indexLanguage, this.dataOfUser});
  @override
  _ProgramsScreenState createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen>{
  TabController tabController;
  bool isTrainers = true;

  List<List<String>> languages = [
    workoutEnglish,
    workoutArabic,
  ];

  List<String> language;

  @override
  void initState() {
    super.initState();
      setState(() {
        language = languages[widget.indexLanguage];
    });
  }

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  List<String> language2 = [
    "Programs",
    "البرامج",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: widget.indexLanguage == 1? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${language2[widget.indexLanguage]}",
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
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: StreamBuilder<QuerySnapshot>(
                stream: getPrograms(),
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
                                      image:
                                      NetworkImage(data[index]["image"]),
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
                                              StandardCourseScreen(
                                                  data: data[index],
                                                  dataOfUser: widget.dataOfUser,
                                                  id: data[index].id, indexLanguage: widget.indexLanguage)),
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
              ),
            ),
          ],
        )
      ),
    );
  }
}
