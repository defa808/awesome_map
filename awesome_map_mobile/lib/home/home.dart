import 'dart:math';
import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/authorization/authorizationProvider.dart';
import 'package:awesome_map_mobile/base/baseMap.dart';
import 'package:awesome_map_mobile/events/eventHome.dart';
import 'package:awesome_map_mobile/events/filter/eventFilterButton.dart';
import 'package:awesome_map_mobile/events/providers/eventFilterModel.dart';
import 'package:awesome_map_mobile/events/providers/eventMarkers.dart';
import 'package:awesome_map_mobile/models/googleMap/googleMapModel.dart';
import 'package:awesome_map_mobile/models/googleMap/markerType.dart';
import 'package:awesome_map_mobile/problems/filter/problemFilterButton.dart';
import 'package:awesome_map_mobile/problems/problemHome.dart';
import 'package:awesome_map_mobile/problems/providers/problemFilterModel.dart';
import 'package:awesome_map_mobile/problems/providers/problemMarkers.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:awesome_map_mobile/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'mainMap.dart';

class DrawerItem {
  Text title;
  Icon icon;
  String path;
  DrawerItem({icon, title, path}) {
    this.title = title;
    this.icon = icon;
    this.path = path;
  }
}

class BottomTabItem {
  Widget title;
  List<Widget> actions;
  Widget body;

  BottomTabItem({this.title, this.actions, this.body});
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  final drawerItems = [
    DrawerItem(
        icon: Icon(Icons.account_circle),
        title: Text("Аккаунт"),
        path: '/account'),
    DrawerItem(
        icon: Icon(Icons.error_outline),
        title: Text("Проблеми"),
        path: '/userProblems'),
    DrawerItem(
        icon: Icon(Icons.event), title: Text("Заходи"), path: '/userEvents'),
    DrawerItem(
        icon: Icon(Icons.settings),
        title: Text("Налаштування"),
        path: '/settings'),
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final bottomTabBarItems = [
    BottomTabItem(
        title: Text("Проблеми"),
        actions: <Widget>[ProblemFilterButton()],
        body: ProblemHome()),
    BottomTabItem(title: Text("Карта"), body: MainMap()),
    BottomTabItem(
        title: Text("Заходи"),
        actions: <Widget>[EventFilterButton()],
        body: EventHome()),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    Future.microtask(() {
      var arguments = ModalRoute.of(context).settings.arguments;
      if (arguments != null)
        setState(() {
          _selectedIndex = arguments ?? 0;
        });
    });
    _selectedDrawerIndex = -1;
    loadData();

    // checkAuthorization();
  }

  void loadData() async {
    await loadEvents();

    await loadProblems();
  }

  Future loadEvents() async {
    GoogleMapModel googleMapProvider = context.read<GoogleMapModel>();
    EventMarkers eventMarkersProvider = context.read<EventMarkers>();
    EventFilterModel filterProvider = context.read<EventFilterModel>();
    eventMarkersProvider.addListener(() {
      googleMapProvider.updateMarkers(eventMarkersProvider.createMarkers(),
          markerType: MarkerType.Event);
    });
    filterProvider.addListener(() {
      eventMarkersProvider.updateFilter(filterProvider);
      googleMapProvider.updateMarkers(eventMarkersProvider.createMarkers(),
          markerType: MarkerType.Event);
    });
   
    eventMarkersProvider.getEvents();
  }

  Future loadProblems() async {
    GoogleMapModel googleMapProvider = context.read<GoogleMapModel>();
    ProblemMarkers problemMarkersProvider = context.read<ProblemMarkers>();
    ProblemFilterModel filterProvider = context.read<ProblemFilterModel>();
    problemMarkersProvider.addListener(() {
      googleMapProvider.updateMarkers(problemMarkersProvider.createMarkers(),
          markerType: MarkerType.Problem);
    });
    filterProvider.addListener(() {
      problemMarkersProvider.updateFilter(filterProvider);
      googleMapProvider.updateMarkers(problemMarkersProvider.createMarkers(),
          markerType: MarkerType.Problem);
    });
    problemMarkersProvider.getProblems();
  }

  // checkAuthorization() async {
  //   if (context.read<AuthorizationProvider>().googleAccount == null)
  //     SchedulerBinding.instance.addPostFrameCallback((_) {
  //       Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
  //     });
  // }

  int _selectedDrawerIndex = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelectItem(int index, String path) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
    Navigator.of(context).pushNamed(path);
    setState(() {
      _selectedDrawerIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
        leading: widget.drawerItems[i].icon,
        title: widget.drawerItems[i].title,
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i, widget.drawerItems[i].path),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        actions: widget.bottomTabBarItems.elementAt(_selectedIndex).actions,
        title: widget.bottomTabBarItems.elementAt(_selectedIndex).title,
        centerTitle: true,
      ),
      body: Center(
        child: widget.bottomTabBarItems.elementAt(_selectedIndex).body,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.error_outline),
            title: Text('Проблеми'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Карта'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Заходи'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: SizedBox(
        child: Consumer<AccountProvider>(builder: (BuildContext context,
            AccountProvider accountProvider, Widget child) {
          return Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: Column(
              // Important: Remove any padding from the ListView.
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  accountEmail: Text(accountProvider.googleAccount?.email ??
                      accountProvider.userInfo?.email ??
                      ''),
                  accountName: Text(
                      accountProvider.googleAccount?.displayName ??
                          accountProvider.userInfo?.userName ??
                          ''),
                  otherAccountsPictures: <Widget>[
                    CustomTheme.instanceOf(context).themeKey ==
                            MyThemeKeys.LIGHT
                        ? Transform.rotate(
                            child: IconButton(
                              icon: Icon(Icons.brightness_3),
                              color: Colors.white,
                              onPressed: () {
                                _changeTheme(context, MyThemeKeys.DARK);
                              },
                            ),
                            angle: 30 * pi / 180,
                          )
                        : Transform.rotate(
                            child: IconButton(
                              icon: Icon(Icons.brightness_1),
                              color: Colors.white,
                              onPressed: () {
                                _changeTheme(context, MyThemeKeys.LIGHT);
                              },
                            ),
                            angle: 30 * pi / 180,
                          )
                  ],
                  currentAccountPicture: accountProvider.googleAccount != null
                      ? GoogleUserCircleAvatar(
                          identity: accountProvider.googleAccount,
                        )
                      : CircleAvatar(
                          child: Text("A"),
                        ),
                ),
                Column(children: drawerOptions),
                Expanded(
                  child: SizedBox(),
                ),
                Divider(),
                Container(
                  child: new ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Вийти"),
                    onTap: () async {
                      if (await context
                          .read<AuthorizationProvider>()
                          .handleSignOut())
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/welcome', (_) => false);
                        });
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }
}
