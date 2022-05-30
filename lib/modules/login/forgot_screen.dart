import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final indexLanguage;

  const ForgotPasswordScreen({this.indexLanguage});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          widget.indexLanguage == 0 ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.indexLanguage == 0 ? "Forgot password" : "نسيت كلمة السر"),
          centerTitle: true,
          backgroundColor: backColor,
        ),
        backgroundColor: backColor,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.indexLanguage == 0
                          ? "Receive an email to reset your password"
                          : "تلقي بريد إلكتروني لإعادة تعيين كلمة المرور الخاصة بك",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                        labelText: widget.indexLanguage == 0
                            ? "Email"
                            : "البريد الإلكتروني",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return widget.indexLanguage == 0
                              ? "Email Address must not be empty"
                              : "يجب ألا يكون عنوان البريد الإلكتروني فارغًا";
                        }
                        return null;
                      },
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              resetPassword();
                            },
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    widget.indexLanguage == 0
                                        ? "Reset Password"
                                        : "إعادة تعيين كلمة المرور",
                                    style: TextStyle(fontSize: 20),
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
        ),
      ),
    );
  }

  Future resetPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Fluttertoast.showToast(
        msg: widget.indexLanguage == 0
            ? "Password Reset Email Sent"
            : "تم إرسال البريد الإلكتروني الخاص بإعادة تعيين كلمة المرور",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      print(e);

      Fluttertoast.showToast(
        msg: widget.indexLanguage == 0
            ? e.message
            : "حدث خطأ أو البريد الإلكتروني غير موجود",
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
}
