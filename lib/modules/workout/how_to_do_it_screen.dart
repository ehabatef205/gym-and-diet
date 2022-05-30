import 'package:chewie/chewie.dart';
import 'package:gym_and_diet/modules/workout/how_to_do_it_language.dart';
import 'package:gym_and_diet/modules/workout/start_now_screen.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HowToDoItScreen extends StatefulWidget {
  final data;
  final dataOfUser;
  final int indexLanguage;

  const HowToDoItScreen({this.data, this.dataOfUser, this.indexLanguage});

  @override
  _HowToDoItScreenState createState() => _HowToDoItScreenState();
}

class _HowToDoItScreenState extends State<HowToDoItScreen> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  String reps = "";
  bool isDone = false;

  List<String> languageOfName = [
    "nameEn",
    "nameAr",
  ];

  List<String> languageOfDescription = [
    "descriptionEn",
    "descriptionAr",
  ];

  List<List<String>> languages = [
    HowToDoItEnglish,
    HowToDoItArabic,
  ];

  List<String> language;

  @override
  void initState() {
    super.initState();
    getDiet().whenComplete(() {
      setState(() {
        isDone = true;
      });
    });
    setState(() {
      language = languages[widget.indexLanguage];
    });
    initializePlayer();
  }

  Future getDiet() async {
    if (widget.dataOfUser["units"] == "lbs") {
      double w = double.parse(widget.dataOfUser["weight"]) * 0.45359237;
      if (w < 101) {
        setState(() {
          reps = "100";
        });
      } else if (w > 100 && w < 151) {
        setState(() {
          reps = "150";
        });
      } else {
        setState(() {
          reps = "200";
        });
      }
    } else {
      double w = double.parse(widget.dataOfUser["weight"]);
      if (w < 101) {
        setState(() {
          reps = "100";
        });
      } else if (w > 100 && w < 151) {
        setState(() {
          reps = "150";
        });
      } else {
        setState(() {
          reps = "200";
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.data["video"]);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      showOptions: false,
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection:
          widget.indexLanguage == 1 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.4),
          child: AppBar(
            backgroundColor: backColor,
            elevation: 0,
            flexibleSpace: Container(
              child: Column(
                children: <Widget>[
                  _chewieController != null &&
                          _chewieController
                              .videoPlayerController.value.isInitialized
                      ? Container(
                          height: size.height * 0.437,
                          child: Chewie(
                            controller: _chewieController,
                          ),
                        )
                      : Container(
                          height: size.height * 0.437,
                          child: Image(
                            image: NetworkImage(widget.data["image"]),
                            fit: BoxFit.fill,
                          ),
                        )
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        backgroundColor: backColor,
        body: isDone
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data["${languageOfName[widget.indexLanguage]}"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                        child: Text(
                          "${language[0]}",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(
                        widget.data[
                            "${languageOfDescription[widget.indexLanguage]}"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartNowScreen(
                                        data: widget.data,
                                        time: widget.data["time1($reps)"],
                                        indexLanguage: widget.indexLanguage)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.indexLanguage == 0
                                            ? "Weight"
                                            : "الوزن",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.dataOfUser["weight"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.indexLanguage == 0
                                            ? "Reps"
                                            : "عدد المرات",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.data["reps1($reps)"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartNowScreen(
                                        data: widget.data,
                                        time: widget.data["time2($reps)"],
                                        indexLanguage: widget.indexLanguage)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.dataOfUser["weight"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Reps",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.data["reps2($reps)"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.2),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartNowScreen(
                                        data: widget.data,
                                        time: widget.data["time3($reps)"],
                                        indexLanguage: widget.indexLanguage)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.dataOfUser["weight"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Reps",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${widget.data["reps3($reps)"]}",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      /*Container(
                  height: size.height * 0.089,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StartNowScreen(data: widget.data, indexLanguage: widget.indexLanguage)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: simpleBackColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Text(
                              "${language[1]}",
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
                )*/
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: simpleBackColor,
                ),
              ),
      ),
    );
  }
}
