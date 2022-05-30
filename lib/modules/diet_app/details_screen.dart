import 'package:flutter/material.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';

class DetailsScreen extends StatefulWidget {
  final int indexLanguage;
  final String image;
  final String meal;
  final data;

  const DetailsScreen({this.indexLanguage, this.image, this.meal, this.data});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.meal}",
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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Image(
                  image: AssetImage("assets/${widget.image}.png"),
                  height: size.width * 0.3,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${widget.data}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
