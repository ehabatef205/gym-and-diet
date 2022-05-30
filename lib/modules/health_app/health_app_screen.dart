import 'dart:io';

import 'package:gym_and_diet/modules/health_app/health_language.dart';
import 'package:gym_and_diet/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthAppScreen extends StatefulWidget {
  final int indexLanguage;

  const HealthAppScreen({this.indexLanguage});

  @override
  _HealthAppScreenState createState() => _HealthAppScreenState();
}

class _HealthAppScreenState extends State<HealthAppScreen> {
  List<HealthDataPoint> _healthDataList = [];
  List<HealthDataPoint> _healthDataList2 = [];
  List<HealthDataPoint> _healthDataList3 = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  PermissionStatus permissions;

  List<List<String>> languages = [
    HealthEnglish,
    HealthArabic,
  ];

  List<String> language;

  @override
  void initState() {
    super.initState();
    setState(() {
      language = languages[widget.indexLanguage];
    });
    getPermission();
  }

  void getPermission() async {
    if (Platform.isAndroid) {
      permissions = await Permission.activityRecognition.request();
      permissions = await Permission.locationAlways.request();
    }
    getSteps().then((value) {
      getCalories().then((value) {
        getDistance();
      });
    });
  }

  int steps = 0;

  int distance = 0;

  int calories = 0;

  bool isDone = false;

  /// Fetch data from the health plugin and print it
  Future getSteps() async {
    // get everything from midnight until now
    DateTime startDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    DateTime endDate = DateTime.now();

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [HealthDataType.STEPS];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList.addAll(healthData);
        setState(() {
          isDone = true;
        });
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      _healthDataList.forEach((x) {
        steps += x.value.round();
      });

      print("Welcome to Fitness App Your Steps is $steps");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future getDistance() async {
    // get everything from midnight until now
    DateTime startDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    DateTime endDate = DateTime.now();

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [HealthDataType.DISTANCE_DELTA];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList2.addAll(healthData);
        setState(() {
          isDone = true;
        });
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList2 = HealthFactory.removeDuplicates(_healthDataList2);

      // print the results
      _healthDataList2.forEach((x) {
        distance += x.value.round();
      });

      print("Welcome to Fitness App Your Steps is $distance");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList2.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future getCalories() async {
    // get everything from midnight until now
    DateTime startDate = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
    DateTime endDate = DateTime.now();

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [HealthDataType.ACTIVE_ENERGY_BURNED];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList3.addAll(healthData);
        setState(() {
          isDone = true;
        });
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList3 = HealthFactory.removeDuplicates(_healthDataList3);

      // print the results
      _healthDataList3.forEach((x) {
        calories += x.value.round();
      });

      print("Welcome to Fitness App Your Steps is $calories");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList3.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20), child: CircularProgressIndicator()),
        Text(
          'Fetching data...',
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _contentDataReady() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.directions_walk,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[1]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$steps",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.local_fire_department_sharp,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[2]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$calories Cal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.add_road,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[3]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${distance / 1000} Km",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentNoData() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.directions_walk,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[1]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$steps",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.local_fire_department_sharp,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[2]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$calories Cal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.2,
                    child: Icon(
                      Icons.add_road,
                      color: Colors.white,
                      size: size.width * 0.2,
                    ),
                  ),
                  Container(
                    width: size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${language[3]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${distance / 1000} Km",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Platform.isAndroid
              ? Column(
                  children: [
                    Text(
                      widget.indexLanguage == 0
                          ? "If you have not downloaded Google Fit before, please download it"
                          : "إذا لم تقم بتنزيل Google Fit من قبل ، فيرجى تنزيله",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async => await launch(
                          "https://play.google.com/store/apps/details?id=com.google.android.apps.fitness&hl=ar&gl=US/"),
                      child: Image(
                        image: AssetImage("assets/fit.png"),
                        height: size.width * 0.2,
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Text(
                      widget.indexLanguage == 0
                          ? "If you have not downloaded Health Kit before, please download it"
                          : "إذا لم تقم بتنزيل Health Kit من قبل ، فيرجى تنزيله",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async => await launch(
                          "https://play.google.com/store/apps/details?id=com.google.android.apps.fitness&hl=ar&gl=US/"),
                      child: Image(
                        image: AssetImage("assets/kit.png"),
                        height: size.width * 0.2,
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget _contentNotFetched() {
    return Text(
      'Press the download button to fetch data',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _authorizationNotGranted() {
    return Text(
      '''Authorization not given.
        For Android please check your OAUTH2 client ID is correct in Google Developer Console.
         For iOS check your permissions in Apple Health.''',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == AppState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();

    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      ),
      backgroundColor: backColor,
      body: SingleChildScrollView(
        child: Center(
          child: _content(),
        ),
      ),
    );
  }
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}
