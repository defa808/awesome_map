import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/base/photo/photoItem.dart';
import 'package:awesome_map_mobile/base/photo/photoVIewer.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';

class ProblemDetailsContent extends StatelessWidget {
  const ProblemDetailsContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

List<PhotoItem> photoes = [
  PhotoItem(id: "123", name: "First Image", resource: "images/gallery1.jpg"),
  PhotoItem(id: "1223", name: "Second Image", resource: "images/gallery2.jpg"),
  PhotoItem(id: "122343", name: "Third Image", resource: "images/gallery3.jpg")
];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 0,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: CategoryItem(
                    icon: Icon(Icons.delete),
                    label: Text("Сміття"),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 5.0),
                  child: CategoryItem(
                    icon: Icon(Icons.security),
                    label: Text("Охорона здоров'я"),
                  )),
              
            ],
          ),
          Text(
              "Посилаючись на наведене вище опис проблеми, Швеція пропонує, щоб в разі (цього) контейнерів - цистерн і багатоелементних газових, призначених для перевезення небезпечних вантажів автомобільним та залізничним транспортом, дата наступної перевірки вказувалася на табличках, розташованих на обох бічних сторонах контейнерів."),
          SizedBox(
            height: 10,
          ),
          ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            child: ExpansionTile(
              key: UniqueKey(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Прикріплення",
                    ),
                  ),
                ],
              ),
              children: <Widget>[
               PhotoViewer(galleryItems: photoes,)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text("Слідкують:", style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 10,
              ),
              Text("5"),
              Icon(Icons.people_outline),
              Expanded(
                child: Container(),
              ),
              RaisedButton(
                color: CustomTheme.of(context).accentColor,
                textColor: CustomTheme.of(context).bottomAppBarColor,
                child: Text("Слідкувати"),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Активність",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Створено:"),
              Text(
                "12.10.19 12:10",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Відредаговано:"),
              Text(
                "13.10.19 10:00",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
