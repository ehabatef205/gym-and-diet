import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/diet_app/details_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class ChooseMeal extends StatefulWidget {
  final int indexLanguage;
  final data;

  const ChooseMeal({this.indexLanguage, this.data});

  @override
  _ChooseMealState createState() => _ChooseMealState();
}

class _ChooseMealState extends State<ChooseMeal> {
  List<String> languageOfData = [
    "En",
    "Ar",
  ];

  List<String> language = [
    "Details Diet",
    "تفاصيل النظام الغذائي",
  ];

  List<String> language2 = [
    "Breakfast",
    "الفطار",
  ];

  List<String> language3 = [
    "The Lunch",
    "الغداء",
  ];

  List<String> language4 = [
    "The Dinner",
    "العشاء",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
      widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
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
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Card(
                    color: Colors.white.withOpacity(0.2),
                    child: Container(
                      height: size.height * 0.25,
                      width: size.width * 0.6,
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                indexLanguage: widget.indexLanguage,
                                image: "breakfast",
                                meal: language2[widget.indexLanguage],
                                data: widget.data["breakfast${languageOfData[widget.indexLanguage]}"],
                              ),
                            ),
                          );
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/breakfast.png"),
                              height: size.width * 0.3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${language2[widget.indexLanguage]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Card(
                    color: Colors.white.withOpacity(0.2),
                    child: Container(
                      height: size.height * 0.25,
                      width: size.width * 0.6,
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                indexLanguage: widget.indexLanguage,
                                image: "lunch",
                                meal: language3[widget.indexLanguage],
                                data: widget.data["lunch${languageOfData[widget.indexLanguage]}"],
                              ),
                            ),
                          );
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/lunch.png"),
                              height: size.width * 0.3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${language3[widget.indexLanguage]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Card(
                    color: Colors.white.withOpacity(0.2),
                    child: Container(
                      height: size.height * 0.25,
                      width: size.width * 0.6,
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                indexLanguage: widget.indexLanguage,
                                image: "dinner",
                                meal: language4[widget.indexLanguage],
                                data: widget.data["dinner${languageOfData[widget.indexLanguage]}"],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/dinner.png"),
                              height: size.width * 0.3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${language4[widget.indexLanguage]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
