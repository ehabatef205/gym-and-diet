import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_and_diet/modules/login/login_screen.dart';
import 'package:gym_and_diet/modules/login/shape_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class VerifyEmailScreen extends StatefulWidget {
  final indexLanguage;

  const VerifyEmailScreen({this.indexLanguage});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool isLoading = false;
  bool canResendEmail = false;
  Timer timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (timer) {
          checkEmailVerified();
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser.emailVerified;
    });
    if (isEmailVerified) {
      timer.cancel();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShapeScreen(
            indexLanguage: widget.indexLanguage,
          ),
        ),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: widget.indexLanguage == 0? e.message : "حدث خطأ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(widget.indexLanguage == 0
              ? "Verify Email"
              : "التحقق من البريد الإلكتروني"),
          centerTitle: true,
          backgroundColor: backColor,
        ),
        backgroundColor: backColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.indexLanguage == 0
                    ? "A verification email has been send to your email"
                    : "تم إرسال بريد إلكتروني للتحقق إلى بريدك الإلكتروني",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: simpleBackColor,
                      ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: simpleBackColor),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          simpleBackColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        canResendEmail ? sendVerificationEmail() : null;
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              widget.indexLanguage == 0
                                  ? "Resend Email"
                                  : "إعادة إرسال البريد الإلكتروني",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          indexLanguage: widget.indexLanguage,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    widget.indexLanguage == 0 ? "Cancel" : "إلغاء",
                    style: TextStyle(
                      fontSize: 20,
                      color: simpleBackColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
