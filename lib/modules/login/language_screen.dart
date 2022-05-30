import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_and_diet/modules/login/login_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int languageOfIndex = 0;

  Future languageOnApp(int value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setInt("indexOfLanguage", value);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(indexLanguage: value,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backColor,
          title: Text(
            languageOfIndex == 0? "Select Language" : "اختر اللغة",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: Container(),
          centerTitle: true,
        ),
        backgroundColor: backColor,
        body: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      languageOnApp(languageOfIndex);
                    },
                    child: Text(
                      languageOfIndex == 0? "Continue" : "استمرار",
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
    );
  }
}
