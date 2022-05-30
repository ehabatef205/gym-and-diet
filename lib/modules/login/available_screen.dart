import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class AvailableScreen extends StatefulWidget {
  final indexLanguage;

  const AvailableScreen({this.indexLanguage});

  @override
  State<AvailableScreen> createState() => _AvailableScreenState();
}

class _AvailableScreenState extends State<AvailableScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.indexLanguage == 0
              ? "Activate The Account"
              : "تفعيل الحساب"),
          centerTitle: true,
          backgroundColor: backColor,
          leading: Container(),
        ),
        backgroundColor: backColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.indexLanguage == 0
                      ? "Activate The Account"
                      : "تفعيل الحساب",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
