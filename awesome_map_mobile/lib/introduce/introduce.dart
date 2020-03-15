import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduce extends StatefulWidget {
  Introduce({Key key}) : super(key: key);

  @override
  _IntroduceState createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
  List<Slide> slides = new List();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    _prefs.then((res) {
      res.setBool('isShowIntroduce', true);
    });

    slides.add(
      new Slide(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: Colors.orange,
      ),
    );
    slides.add(
      new Slide(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "images/photo_pencil.png",
        backgroundColor: Colors.pink,
      ),
    );
    slides.add(
      new Slide(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/photo_ruler.png",
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> onDonePress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isShowIntroduce', false);
    final result = await Navigator.pushNamed(context, '/welcome');
    // TODO: go to next screen
  }

  Future<void> onSkipPress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isShowIntroduce', false);
    final result = await Navigator.pushNamed(context, '/welcome');
    // TODO: go to next screen
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    ));
  }
}
