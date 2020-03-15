import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  final drawerItems = [
    new ListTile(
        leading: Icon(Icons.account_circle), title: new Text("Аккаунт")),
    new ListTile(
        leading: Icon(Icons.error_outline), title: new Text("Проблеми")),
    new ListTile(leading: Icon(Icons.event), title: new Text("Заходи")),
    new ListTile(
        leading: Icon(Icons.settings), title: new Text("Налаштування")),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Проблемки?',
      style: optionStyle,
    ),
    Text(
      'Index 1: Головна карта',
      style: optionStyle,
    ),
    Text(
      'Index 2: Заходи',
      style: optionStyle,
    ),
  ];
  int _selectedDrawerIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      drawerOptions.add(new ListTile(
        leading: widget.drawerItems[i].leading,
        title: widget.drawerItems[i].title,
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Map KPI'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:
          BottomNavigationBar(
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
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text("alex@gmail.com"),
                accountName: null,
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text("A", style: TextStyle(fontSize: 40.0))),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: drawerOptions),
              Divider(),
              new ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Вийти"),
                onTap: () async {
                  final result = await Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
