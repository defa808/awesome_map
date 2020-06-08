import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/authorization/authorizationProvider.dart';
import 'package:awesome_map_mobile/authorization/signUp.dart';
import 'package:awesome_map_mobile/comments/provider/commentProvider.dart';
import 'package:awesome_map_mobile/introduce/introduce.dart';
import 'package:awesome_map_mobile/problems/editProblemItem.dart';
import 'package:awesome_map_mobile/problems/problemDetails.dart';
import 'package:awesome_map_mobile/problems/problemListMessage.dart';
import 'package:awesome_map_mobile/settings/settingsHome.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:awesome_map_mobile/theming/themes.dart';
import 'package:awesome_map_mobile/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account/account.dart';
import 'authorization/signIn.dart';
import 'events/eventDetails.dart';
import 'events/eventUserList.dart';
import 'events/providers/eventFilterModel.dart';
import 'events/providers/eventForm.dart';
import 'events/providers/eventMarkers.dart';
import 'events/providers/eventTypes.dart';
import 'home/home.dart';
import 'injector.dart';
import 'models/googleMap/googleMapModel.dart';

import 'problems/providers/problemFilterModel.dart';
import 'problems/providers/problemForm.dart';
import 'problems/providers/problemTypes.dart';
import 'problems/providers/problemMarkers.dart';

final storage = FlutterSecureStorage();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  runApp(MultiProvider(
    child: CustomTheme(initialThemeKey: MyThemeKeys.LIGHT, child: MyApp()),
    providers: <SingleChildWidget>[
      ChangeNotifierProvider<ProblemFilterModel>(
          create: (context) => ProblemFilterModel()),
      ChangeNotifierProvider<EventFilterModel>(
          create: (context) => EventFilterModel()),
      ChangeNotifierProvider<GoogleMapModel>(
          create: (context) => GoogleMapModel()),
      ChangeNotifierProvider<ProblemForm>(create: (context) => ProblemForm()),
      ChangeNotifierProvider<EventForm>(create: (context) => EventForm()),
      ChangeNotifierProvider<ProblemTypes>(create: (context) => ProblemTypes()),
      ChangeNotifierProvider<EventTypes>(create: (context) => EventTypes()),
      ChangeNotifierProvider<ProblemMarkers>(create: (context) => ProblemMarkers()),
      ChangeNotifierProvider<EventMarkers>(create: (context) => EventMarkers()),
      ChangeNotifierProvider<AuthorizationProvider>(create: (context) => AuthorizationProvider()),
      ChangeNotifierProvider<CommentProvider>(create: (context) => CommentProvider()),
      ChangeNotifierProvider<AccountProvider>(create: (context) => GetIt.I.get<AccountProvider>()),
    ],
  ));
}

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
          "/userProblems": (context) => ProblemListMessage(),
          "/userEvents": (context) => EventUserList(),
          "/event": (context) => EventDetails(),
          "/problemDetail": (context) => ProblemDetails(),
          "/editProblemDetail": (context) => EditProblemItem(),
          "/settings": (context) => SettingsHome(),

        },
        debugShowCheckedModeBanner: false,
        title: 'Awesome Map KPI',
        theme: CustomTheme.of(context),
        supportedLocales: [
          const Locale('en'), // English
          const Locale('ua'), // Ukraine
        ],
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
    );
  }
}
