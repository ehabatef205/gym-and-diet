import 'package:flutter/material.dart';
import 'package:gym_and_diet/modules/workout/workout_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeScreen extends StatefulWidget {
  final int indexLanguage;

  const LanguageChangeScreen({this.indexLanguage});

  @override
  _LanguageChangeScreenState createState() => _LanguageChangeScreenState();
}

class _LanguageChangeScreenState extends State<LanguageChangeScreen> {
  int languageOfIndex = 0;

  Future languageOnApp(int value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("indexOfLanguage", value);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutScreen(
          indexLanguage: value,
        ),
      ),
    );
  }

  Future DeleteLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove("indexOfLanguage");
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      languageOfIndex = widget.indexLanguage;
    });
  }

  List<String> language = [
    "Select Language",
    "اختار اللغة",
  ];

  List<String> language2 = [
    "Continue",
    "استمرار",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
      languageOfIndex == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backColor,
          title: Text(
            "${language[languageOfIndex]}",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: backColor,
        body: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Directionality(
                  textDirection:
                  TextDirection.ltr,
                  child: ListView(
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
                              value: 0,
                              title: new Text(
                                "English",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              activeColor: simpleBackColor,
                              groupValue: languageOfIndex,
                              onChanged: (newValue) {
                                setState(() {
                                  languageOfIndex = newValue;
                                });
                                print(languageOfIndex);
                              }),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorTileColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                value: 1,
                                title: new Text(
                                  "اللغة العربية",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                activeColor: simpleBackColor,
                                groupValue: languageOfIndex,
                                onChanged: (newValue) {
                                  setState(() {
                                    languageOfIndex = newValue;
                                  });
                                  print(languageOfIndex);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        DeleteLanguage();
                        languageOnApp(languageOfIndex);
                      },
                      child: Text(
                        "${language2[languageOfIndex]}",
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
