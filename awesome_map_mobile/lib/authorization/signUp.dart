import 'package:awesome_map_mobile/authorization/authorizationProvider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController passwordTwoController;
  bool _validate = true;
  bool _first = false;
  @override
  void initState() {
    super.initState();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    passwordTwoController = new TextEditingController();
    // _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              title: Text("AMKPI"),
              centerTitle: true,
            ),
          ),
          body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: 0,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("AMKPI",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 60, fontFamily: "Adventure")),
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
                          "Реєстрація",
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
                              errorText: _first && emailController.text.isEmpty
                                  ? "Введіть email."
                                  : _validate
                                      ? null
                                      : "Введіть корректний email."),
                          onChanged: (val) => setState(() {
                            _validate = true;
                          }),
                        ),
                        TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Пароль",
                              hintText: "Пароль",
                              errorText: _first
                                  ? passwordController.text.isEmpty
                                      ? "Введіть пароль."
                                      : passwordController.text ==
                                              passwordTwoController.text
                                          ? null
                                          : "Паролі не співпадають"
                                  : null),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          controller: passwordTwoController,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Підтвердити пароль",
                              hintText: "Підтвердити пароль",
                              errorText: _first
                                  ? passwordTwoController.text.isEmpty
                                      ? "Введіть пароль."
                                      : passwordController.text ==
                                              passwordTwoController.text
                                          ? null
                                          : "Паролі не співпадають"
                                  : null),
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
                            if (!EmailValidator.validate(
                                emailController.text)) {
                              setState(() {
                                _first = true;
                                _validate = false;
                              });
                              return;
                            }
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                passwordController.text !=
                                    passwordTwoController.text) {
                              setState(() {
                                _first = true;
                              });
                              return;
                            }
                            setState(() {
                              _validate = true;
                            });
                            bool result = await context
                                .read<AuthorizationProvider>()
                                .handleCustomSignUp(
                                    email: emailController.text,
                                    password: passwordController.text);
                            if (result)
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
                          onPressed: null
                          //  () async {
                          //   bool res = await context
                          //       .read<AuthorizationProvider>()
                          //       .handleGoogleSignIn();
                          //   if (res)
                          //     await Navigator.pushNamedAndRemoveUntil(
                          //         context, '/home', (_) => false);
                          // },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
        tag: "SignUp");
  }
}
