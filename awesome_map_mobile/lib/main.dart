import 'package:awesome_map_mobile/authorization/signUp.dart';
import 'package:awesome_map_mobile/introduce/introduce.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account/account.dart';
import 'authorization/signIn.dart';
import 'events/eventList.dart';
import 'home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
      debugShowCheckedModeBanner: false,
      title: 'Awesome Map KPI',
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 72.0, fontFamily: 'Adventure', color: Colors.white),
              body2: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
              body1: TextStyle(fontFamily: 'Lato'))),
      home: AppPage(title: ''),
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
