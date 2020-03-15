import 'package:awesome_map_mobile/welcome/welcome.dart';
import 'package:flutter/material.dart';

import 'authorization/signIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/welcome",
        routes: {
          "/welcome": (context) => Welcome(),
          "/signIn": (context) => SignIn()
        },
      debugShowCheckedModeBanner: false,
      title: 'Awesome Map KPI',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 72.0, fontFamily: 'Adventure', color: Colors.white),
              body2: TextStyle(fontSize: 25.0, fontFamily: 'Lato', fontWeight: FontWeight.bold),
              body1: TextStyle(fontFamily: 'Lato')
              )),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Container(
        child: Welcome(),
      ),
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
