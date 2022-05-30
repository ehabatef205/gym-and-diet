import 'package:gym_and_diet/modules/account/edit_profile_screen.dart';
import 'package:gym_and_diet/modules/account/view_profile_language.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  final data;
  final int indexLanguage;

  const ViewProfileScreen({this.data, this.indexLanguage});

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  List<List<String>> languages = [
    ViewProfileEnglish,
    ViewProfileArabic,
  ];

  List<String> language;

  String selectedUnit;

  @override
  void initState() {
    super.initState();
    setState(() {
      language = languages[widget.indexLanguage];
    });
    nameController.text = widget.data["username"];
    emailController.text = widget.data["email"];
    phoneController.text = widget.data["phone"];
    ageController.text = widget.data["age"];
    weightController.text = widget.data["weight"];
    heightController.text =
        widget.data["heights"].toString().replaceAll(" cm", "");
    selectedUnit = widget.data["units"];
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
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(
                        indexLanguage: widget.indexLanguage,
                        data: widget.data,
                      ),
                    ),
                  );
                },
                child: Text(
                  language[15],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: backColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(
                                widget.data["image"],
                              ),
                              fit: BoxFit.fill,
                              width: size.width * 0.4,
                              height: size.width * 0.4,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: nameController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "${language[1]}",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: emailController,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "${language[3]}",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: phoneController,
                          readOnly: true,
                          enabled: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "${language[5]}",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          controller: ageController,
                          readOnly: true,
                          enabled: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "${language[12]}",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: weightController,
                                readOnly: true,
                                enabled: false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  labelText: "${language[13]}",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            selectedUnit,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TextFormField(
                                controller: heightController,
                                readOnly: true,
                                enabled: false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                  labelText: "${language[14]}",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Cm",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
