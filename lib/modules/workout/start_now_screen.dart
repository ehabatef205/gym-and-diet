import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:gym_and_diet/modules/workout/start_now_language.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartNowScreen extends StatefulWidget {
  final data;
  final String time;
  final int indexLanguage;

  const StartNowScreen({this.data, this.time, this.indexLanguage});

  @override
  _StartNowScreenState createState() => _StartNowScreenState();
}

class _StartNowScreenState extends State<StartNowScreen> {
  CountDownController _controller = CountDownController();
  bool isPlay = true;
  bool isStart = false;
  Duration d;
  int time;
  bool isComplete = false;

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  List<String> language;

  List<List<String>> languages = [
    StartNowEnglish,
    StartNowArabic,
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      d = Duration(seconds: int.parse(widget.time));
      time = int.parse(widget.time);
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
        backgroundColor: backColor,
        body: Stack(
          children: [
            Container(
              child: Image(
                image: NetworkImage(widget.data["image"]),
                height: size.height,
                width: size.width,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, backColor],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.15,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.data["${languageOfName[widget.indexLanguage]}"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircularCountDownTimer(
                        ringColor: isStart ? Colors.grey[800] : simpleBackColor,
                        isTimerTextShown: false,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        strokeWidth: isStart ? 5 : 12,
                        isReverse: true,
                        duration: 0,
                        isReverseAnimation: true,
                        fillColor: simpleBackColor,
                        controller: _controller,
                      ),
                    ),
                    Center(
                      child: CircularCountDownTimer(
                        ringColor: Colors.transparent,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        strokeWidth: 12,
                        isReverse: true,
                        isTimerTextShown: isStart ? true : false,
                        autoStart: false,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        strokeCap: StrokeCap.round,
                        duration:  time,
                        textFormat: "mm:ss",
                        isReverseAnimation: true,
                        fillColor: simpleBackColor,
                        controller: _controller,
                        onComplete: () {
                          setState((){
                            isComplete = true;
                            isStart = false;
                            time = int.parse(widget.time);
                          });
                        },
                      ),
                    ),
                    isStart
                        ? Container()
                        : Center(
                            child: Container(
                              height: size.width * 0.5,
                              width: size.width * 0.5,
                              child: widget.indexLanguage == 1? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (d.inSeconds.remainder(60)) > 9
                                        ? "${(d.inSeconds.remainder(60))}"
                                        : "0${(d.inSeconds.remainder(60))}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (d.inMinutes.remainder(60)) > 9
                                        ? ":${d.inMinutes.remainder(60)}"
                                        : ":0${d.inMinutes.remainder(60)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ) : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (d.inMinutes.remainder(60)) > 9
                                        ? "${d.inMinutes.remainder(60)}:"
                                        : "0${d.inMinutes.remainder(60)}:",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (d.inSeconds.remainder(60)) > 9
                                        ? "${(d.inSeconds.remainder(60))}"
                                        : "0${(d.inSeconds.remainder(60))}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                MaterialButton(
                  color: simpleBackColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    if (!isStart) {
                      setState(() {
                        isStart = true;
                        _controller.start();
                      });
                    }
                    if (isComplete) {
                      setState(() {
                        isComplete = false;
                        _controller.start();
                        isPlay = !isPlay;
                      });
                    }
                    setState(() {
                      isPlay = !isPlay;
                      if (isPlay) {
                        _controller.pause();
                      } else {
                        _controller.resume();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: simpleBackColor,
                      ),
                      child: Text(
                        isComplete? "${language[3]}" : isStart
                            ? isPlay
                                ? "${language[0]}"
                                : "${language[1]}"
                            : "${language[2]}",
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
          ],
        ),
      ),
    );
  }
}
