import 'dart:async';

import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Timer _timer;
  bool showFirst = true;
  TextEditingController emailController =
      TextEditingController(text: "alex@gmail.com");
  TextEditingController loginConroller = TextEditingController(text: "alex");
  final _formKey = GlobalKey<FormState>();

  bool isEditMode = false;

  @override
  void initState() {
    _timer = Timer.periodic(new Duration(seconds: 2), (Timer t) {
      setState(() {
        showFirst = !showFirst;
      });
    });
    super.initState();
    setState(() {
      isEditMode = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    emailController.dispose();
    loginConroller.dispose();
    super.dispose();
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isEditMode
          ? !_keyboardIsVisible()? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = false;
                    });
                  },
                  child: Icon(Icons.cancel),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = false;
                    });
                  },
                  child: Icon(Icons.done),
                ),
              ],
            ) : null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  isEditMode = true;
                });
              },
              child: Icon(Icons.edit),
            ),
      appBar: AppBar(
        leading: MaterialButton(child: Icon(Icons.arrow_back, color: Colors.white), onPressed: () { Navigator.pop(context, true);},),
        title: const Text('Аккаунт'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
               
                TextFormField(
                    controller: emailController,
                    enabled: isEditMode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Ел. пошта",
                        hintText: "Ел. пошта")),
                TextFormField(
                  controller: loginConroller,
                  enabled: isEditMode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Нік в системі",
                      hintText: "Нік в системі"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
