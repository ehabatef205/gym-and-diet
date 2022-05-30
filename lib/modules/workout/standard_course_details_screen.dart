import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_and_diet/modules/workout/how_to_do_it_screen.dart';
import 'package:gym_and_diet/modules/workout/standard_course_language.dart';
import 'package:gym_and_diet/shared/network/remote/connection_firebase.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StandardCourseScreen extends StatefulWidget {
  final data;
  final String id;
  final dataOfUser;
  final int indexLanguage;

  const StandardCourseScreen(
      {this.data, this.id, this.dataOfUser, this.indexLanguage});

  @override
  _StandardCourseScreenState createState() => _StandardCourseScreenState();
}

class _StandardCourseScreenState extends State<StandardCourseScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int currentValue = 0;

  List<List<String>> languages = [
    StandardCourseEnglish,
    StandardCourseArabic,
  ];

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  List<String> languageOfDescription = [
    "descriptionEn",
    "descriptionAr",
  ];

  List<String> language;

  @override
  void initState() {
    super.initState();
    setState(() {
      language = languages[widget.indexLanguage];
    });
    tabController = TabController(length: 3, vsync: this);
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
          bottom: TabBar(
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.transparent,
              labelColor: simpleBackColor,
              controller: tabController,
              unselectedLabelColor: Colors.white,
              onTap: (value) {
                setState(() {
                  currentValue = value;
                });
              },
              physics: NeverScrollableScrollPhysics(),
              tabs: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: widget.indexLanguage == 1
                        ? BorderRadius.only(
                            topRight: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                    color: backColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "${language[0]}",
                        style: TextStyle(
                          color: currentValue == 0
                              ? simpleBackColor
                              : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: backColor,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${language[1]}",
                        style: TextStyle(
                          color: currentValue == 1
                              ? simpleBackColor
                              : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: widget.indexLanguage == 1
                        ? BorderRadius.only(
                            topLeft: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                    color: backColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${language[2]}",
                        style: TextStyle(
                          color: currentValue == 2
                              ? simpleBackColor
                              : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        backgroundColor: backColor,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            getBeginners(),
            getSkills(),
            getMaster(),
          ],
        ),
      ),
    );
  }

  Widget getBeginners() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: getProgramBeginner(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HowToDoItScreen(
                                    data: data[index],
                                    dataOfUser: widget.dataOfUser,
                                    indexLanguage: widget.indexLanguage,
                                  )));
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
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget getSkills() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: getProgramSkills(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HowToDoItScreen(
                                    data: data[index],
                                    dataOfUser: widget.dataOfUser,
                                    indexLanguage: widget.indexLanguage,
                                  )));
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
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget getMaster() {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: getProgramMaster(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data.docs;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HowToDoItScreen(
                                    dataOfUser: widget.dataOfUser,
                                    data: data[index],
                                    indexLanguage: widget.indexLanguage,
                                  )));
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
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
