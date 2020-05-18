import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/base/photo/photoItem.dart';
import 'package:awesome_map_mobile/base/photo/photoVIewer.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProblemDetailsContent extends StatelessWidget {
  const ProblemDetailsContent(this.problem, {Key key}) : super(key: key);
  final Problem problem;
  @override
  Widget build(BuildContext context) {
    List<PhotoItem> photoes = [
      PhotoItem(
          id: "123", name: "First Image", resource: "images/gallery1.jpg"),
      PhotoItem(
          id: "1223", name: "Second Image", resource: "images/gallery2.jpg"),
      PhotoItem(
          id: "122343", name: "Third Image", resource: "images/gallery3.jpg")
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
              for (var item in problem.problemTypes)
                Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: CategoryItem(
                      icon: item.icon != null
                          ? Icon(IconData(item.icon.iconCode,
                              fontFamily: item.icon.fontFamily,
                              fontPackage: item.icon.fontPackage))
                          : null,
                      label: Text(item.name),
                    )),
            ],
          ),
          Text(problem.description),
          SizedBox(
            height: 10,
          ),
          ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            child: ExpansionTile(
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
                PhotoViewer(
                  galleryItems: photoes,
                )
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
              Text(problem.subscribersCount.toString()),
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
                DateFormat.yMMMd().format(problem.createDate).toString(),
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          if (problem.updateDate != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Відредаговано:"),
                Text(
                  DateFormat.yMMMMd().format(problem.updateDate).toString(),
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
