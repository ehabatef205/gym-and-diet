import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_and_diet/modules/login/choose_plan_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class ShapeScreen extends StatefulWidget {
  final int indexLanguage;

  const ShapeScreen({this.indexLanguage});

  @override
  _ShapeScreenState createState() => _ShapeScreenState();
}

class _ShapeScreenState extends State<ShapeScreen> {
  String shape = "";

  List<String> language = [
    "Choose your plan",
    "اختر خطتك",
  ];

  List<String> language2 = [
    "Continue",
    "استمرار",
  ];

  Stream<QuerySnapshot> getShapes() {
    return FirebaseFirestore.instance.collection("shape").snapshots();
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
          appBar: AppBar(
            backgroundColor: backColor,
            title: Text(
              "${language[widget.indexLanguage]}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            leading: Container(),
          ),
          backgroundColor: backColor,
          body: Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  children: [
                    Container(
                      height: size.height * 0.8,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getShapes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data.docs;
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colorTileColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: RadioListTile(
                                            contentPadding: EdgeInsets.zero,
                                            value: data[index]["nameEn"],
                                            title: new Text(
                                              widget.indexLanguage == 0? "${data[index]["nameEn"]}" : "${data[index]["nameAr"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            activeColor: simpleBackColor,
                                            groupValue: shape,
                                            onChanged: (newValue) {
                                              setState(() {
                                                shape = newValue;
                                              });
                                              print(shape);
                                            }),
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
                        shape == ""
                            ? () {}
                            : FirebaseFirestore.instance
                                .collection("Users")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .update({"shape": shape.replaceAll(" / ", " ")}).whenComplete(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChoosePlanScreen(
                                      indexLanguage: widget.indexLanguage,
                                      shape: shape,
                                    ),
                                  ),
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
      ),
    );
  }
}
