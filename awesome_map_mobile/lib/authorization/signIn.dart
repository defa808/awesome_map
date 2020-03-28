import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              elevation: 0.0,
              leading: MaterialButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: _keyboardIsVisible() ? Text("AMKPI") : Text(""),
              centerTitle: true,
            ),
          ),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: _keyboardIsVisible() ? 0 : 150,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("AMKPI",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 60)),
                    SizedBox(height: 60)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Вхід",
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.blue, fontSize: 40),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Ел. пошта",
                              hintText: "Ел. пошта"),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Пароль",
                              hintText: "Пароль"),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.blue)),
                          minWidth: double.infinity,
                          height: 45,
                          child: Text('Вхід'),
                          textColor: Colors.blue,
                          onPressed: () async {
                            final result =
                                await Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (_) => false);
                          },
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(color: Colors.blue)),
                          minWidth: double.infinity,
                          color: Colors.blue,
                          height: 45,
                          child: Text('Gmail'),
                          textColor: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
        tag: "SignIn");
  }
}
