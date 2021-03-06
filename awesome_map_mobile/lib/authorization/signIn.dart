import 'dart:convert';
import 'package:awesome_map_mobile/env/config.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'authorizationProvider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _contactText;
  TextEditingController emailController;
  TextEditingController passwordController;
  bool _validate = true;
  bool _first = false;

  @override
  void initState() {
    super.initState();
    emailController = new TextEditingController(text: "admin@gmail.com");
    passwordController = new TextEditingController(text: "password");

    // _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              title: _keyboardIsVisible()
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Awesome Map"),
                    )
                  : Text(""),
              centerTitle: true,
            ),
          ),
          body: Consumer<AuthorizationProvider>(builder: (BuildContext context,
              AuthorizationProvider authorizationProvider, Widget child) {
            return SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  height: _keyboardIsVisible() ? 0 : 150,
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Awesome Map",
                          style: Theme.of(context).textTheme.headline.copyWith(
                              fontSize: 50,
                              color: Colors.white,
                              fontFamily: "Adventure")),
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
                            style: Theme.of(context).textTheme.body1.copyWith(
                                color: Colors.blue,
                                fontFamily: 'Lato',
                                fontSize: 40),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Ел. пошта",
                                hintText: "Ел. пошта",
                                errorText:
                                    _first && emailController.value.text.isEmpty
                                        ? "Введіть email."
                                        : _validate ? null : ""),
                            onChanged: (val) => setState(() {
                              _validate = true;
                            }),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Пароль",
                                hintText: "Пароль",
                                errorText: _first &&
                                        passwordController.value.text.isEmpty
                                    ? "Введіть пароль."
                                    : _validate
                                        ? null
                                        : "Невірний логін або пароль."),
                            onChanged: (val) => setState(() {
                              _validate = true;
                            }),
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
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                setState(() {
                                  _validate = false;
                                  _first = true;
                                });
                                return;
                              }

                              bool result = await authorizationProvider
                                  .handleCustomSignIn(emailController.text,
                                      passwordController.text);
                              if (result)
                                await Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (_) => false);
                              else
                                setState(() {
                                  _validate = false;
                                });
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
                              onPressed: 
                              // null
                              () async {
                                bool res =
                                    await authorizationProvider.handleGoogleSignIn();
                                if (res)
                                  await Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (_) => false);
                              }
                              ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            );
          }),
        ),
        tag: "welcomeHeader");
  }
}
