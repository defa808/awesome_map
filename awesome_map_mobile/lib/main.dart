import 'dart:io';
import 'package:awesome_map_mobile/authorization/signUp.dart';
import 'package:awesome_map_mobile/introduce/introduce.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:awesome_map_mobile/theming/themes.dart';
import 'package:awesome_map_mobile/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account/account.dart';
import 'authorization/signIn.dart';
import 'events/eventDetails.dart';
import 'events/eventList.dart';
import 'home/home.dart';
import 'models/googleMap/googleMapModel.dart';
import 'models/problem/problemForm.dart';

void main() => runApp(MultiProvider(
      child: CustomTheme(
        initialThemeKey: MyThemeKeys.LIGHT,
        child: MyApp()),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<GoogleMapModel>.value(
            notifier: GoogleMapModel()),
        ChangeNotifierProvider<ProblemForm>.value(
            notifier: ProblemForm(0, 0, "", -1, "", new List<File>()))
      ],
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) => MaterialApp(
        initialRoute: "/",
        routes: {
          "/welcome": (context) => Welcome(),
          "/signIn": (context) => SignIn(),
          "/signUp": (context) => SignUp(),
          "/introduce": (context) => Introduce(),
          "/home": (context) => Home(),
          "/account": (context) => Account(),
          "/problems": (context) => ProblemList(),
          "/events": (context) => EventList(),
          "/event": (context) => EventDetails(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Awesome Map KPI',
        theme:CustomTheme.of(context),
        home: AppPage(title: ''),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  AppPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> isShowIntroduce;
  @override
  void initState() {
    super.initState();

    isShowIntroduce = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('isShowIntroduce') ?? true);
    });
  }

  // checkFirstRun() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isShowIntroduce = (prefs.getBool('isShowIntroduce') ?? false);
  //   return !isShowIntroduce;
  // }

  @override
  Widget build(BuildContext context) {
  
    // Widget startWidget = isShowIntroduce ? Introduce() : Welcome();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: FutureBuilder<bool>(
          future: isShowIntroduce,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                      child: snapshot.data ? Introduce() : Welcome());
                }
            }
          }),
      // Center(
      //   child: Column(
      //     children: <Widget>[
      //       // Text(
      //       //   'You have pushed the button this many times:',
      //       // ),
      //       // Text(
      //       //   '$_counter',
      //       //   style: Theme.of(context).textTheme.display1,
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}
