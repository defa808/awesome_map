import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduce extends StatefulWidget {
  Introduce({Key key}) : super(key: key);

  @override
  _IntroduceState createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
  List<Slide> slides = [
    new Slide(
      
      backgroundImageFit: BoxFit.fill,
      backgroundImage: "images/canDo/createProblem.gif",
      description: "Додавай проблему, яку помітив на карту.",
    ),
    new Slide(
      
      backgroundImageFit: BoxFit.fill,
      backgroundImage: "images/canDo/createEvent.gif",
      description: "Додавай свій захід, та запрошуй людей.",
    ),
    new Slide(
      description: "Переглядай інші проблеми. Коментуй. Слідкуй.",
      backgroundImage: "images/canDo/showProblem.gif",
    ),
    new Slide(
      description: "Переглядай заходи. Коментуй. Приєднуйся.",
      backgroundImage: "images/canDo/showEvents.gif",
    ),
    new Slide(
      title: "Вдосконалюй нас.",
      pathImage: "images/canDo/finish.png",
      description:
          "Почни вже зараз.",
      backgroundColor: Colors.blue,
    ),
  ];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    _prefs.then((res) {
      res.setBool('isShowIntroduce', true);
    });
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

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
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
