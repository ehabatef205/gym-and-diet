import 'package:gym_and_diet/modules/account/get_pro_language.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetProScreen extends StatefulWidget {
  final int indexLanguage;

  const GetProScreen({this.indexLanguage});

  @override
  _GetProScreenState createState() => _GetProScreenState();
}

class _GetProScreenState extends State<GetProScreen> {
  List<List<String>> languages = [
    GetProEnglish,
    GetProArabic,
    GetProFrench,
    GetProSpanish,
    GetProTurkish,
    GetProRussian,
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
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "${language[0]}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: backColor,
        ),
        backgroundColor: backColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.78,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        "${language[3]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "${language[4]}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      leading: Container(
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.15),
                          border: Border.all(
                            color: simpleBackColor,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.accessibility_sharp,
                            color: simpleBackColor,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "${language[7]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "${language[8]}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      leading: Container(
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.15),
                          border: Border.all(
                            color: simpleBackColor,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.refresh_outlined,
                            color: simpleBackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: simpleBackColor),
                    child: Center(
                      child: Text(
                        "${language[0]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
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
