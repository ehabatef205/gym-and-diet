import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/login/gender_language.dart';
import 'package:gym_and_diet/modules/login/old_and_weight_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class GenderScreen extends StatefulWidget {
  final int indexLanguage;
  final bool isGoogle;

  const GenderScreen({this.indexLanguage, this.isGoogle});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  bool isMale;

  List<List<String>> languages = [
    GenderEnglish,
    GenderArabic,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          "${language[0]}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: backColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              height: size.height * 0.78,
              child: ListView(
                children: [
                  Text(
                    "${language[1]}",
                    style: TextStyle(color: Colors.white, fontSize: 31),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${language[2]}",
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isMale == null
                      ? Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = false;
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.female,
                                          size: size.height * 0.13,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${language[3]}",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = true;
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.male,
                                          size: size.height * 0.13,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${language[4]}",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = false;
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.female,
                                          size: size.height * 0.13,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${language[3]}",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isMale
                                        ? Colors.grey[800]
                                        : simpleBackColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isMale = true;
                                  });
                                },
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.male,
                                          size: size.height * 0.13,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "${language[4]}",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isMale
                                        ? simpleBackColor
                                        : Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: isMale == null ? Colors.grey : simpleBackColor),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  isMale == null ? Colors.grey : simpleBackColor,
                ),
              ),
              onPressed: () {
                isMale == null
                    ? () {}
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OldAndWeightScreen(
                            isGoogle: widget.isGoogle,
                            indexLanguage: widget.indexLanguage,
                            gender: isMale ? "Male" : "Female",
                          ),
                        ),
                      );
              },
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "${language[5]}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
