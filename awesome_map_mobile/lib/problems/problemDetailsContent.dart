import 'package:awesome_map_mobile/account/provder/accountProvider.dart';
import 'package:awesome_map_mobile/base/filter/categoryItem.dart';
import 'package:awesome_map_mobile/base/photo/fileItemThumbnail.dart';
import 'package:awesome_map_mobile/base/photo/photoVIewer.dart';
import 'package:awesome_map_mobile/models/problem/problem.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProblemDetailsContent extends StatelessWidget {
  const ProblemDetailsContent(this.problem, {Key key}) : super(key: key);
  final Problem problem;
  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 10,
          ),
          Text(problem.description, style: TextStyle(fontSize: 16)),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Статус:", style: TextStyle(fontSize: 16)),
              Text(
                  EnumToString.parseCamelCase(
                      ProblemStatus.values[this.problem.status]),
                  style: TextStyle(fontSize: 16)),
            ],
          ),
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
                // FileItemThumbnail(file: problem.files[0],),
                PhotoViewer(
                  galleryItems: problem.files,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<AccountProvider>(builder:
              (BuildContext context, AccountProvider account, Widget child) {
            return Row(children: <Widget>[
              Text("Слідкують:", style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 10,
              ),
              Text(problem.subscribersCount.toString()),
              Icon(Icons.people_outline),
              Expanded(
                child: Container(),
              ),
              account.userInfo.observedProblemIds.any((x) => x == problem.id)
                  ? RaisedButton(
                      color: CustomTheme.of(context).accentColor,
                      textColor: CustomTheme.of(context).bottomAppBarColor,
                      child: Text("Відписатись"),
                      onPressed: () => account.unsubsribeOnProblem(problem))
                  : RaisedButton(
                      color: CustomTheme.of(context).accentColor,
                      textColor: CustomTheme.of(context).bottomAppBarColor,
                      child: Text("Слідкувати"),
                      onPressed: () => account.subsribeOnProblem(problem))
            ]);
          }),
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
