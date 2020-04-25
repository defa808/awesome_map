import 'package:awesome_map_mobile/comments/commentsList.dart';
import 'package:awesome_map_mobile/problems/problemList.dart';
import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  EventDetails({Key key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final int id = args["id"];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            key: UniqueKey(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'event-details-$id',
                        child: Material(
                          child: Ink.image(
                            image: AssetImage('images/gitar.jpg'),
                            fit: BoxFit.cover,
                            child: Container(),
                          ),
                        ),
                      ),
                      centerTitle: true,
                      title: Text("Гітарний вечір"),
                    )),
              ];
            },
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TabBar(
                  labelColor: CustomTheme.of(context).primaryColor,
                  unselectedLabelColor:
                      CustomTheme.of(context).primaryColor.withOpacity(0.3),
                  tabs: <Widget>[
                    Tab(
                      text: "Детальніше",
                    ),
                    Tab(
                      text: "Коментарії",
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBarView(children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.lightBlue,
                                          ),
                                          Flexible(
                                            child: Text("Палац України",
                                                style: TextStyle(
                                                    color: Colors.lightBlue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "12.10.19",
                                                style: TextStyle(
                                                    color: Colors.lightBlue),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                "14:30",
                                                style: TextStyle(
                                                    color: Colors.lightBlue),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8, bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.label,
                                              color: Colors.lightBlue),
                                          Flexible(
                                            child: Text("Концерт",
                                                style: TextStyle(
                                                    color: Colors.lightBlue)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, right: 8, bottom: 8),
                                    child: Center(child: Text("2 години")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                                "Тихий вечір. За вікном осінь щедро встеляє землю сухим листям, першими іскорками інею, густим туманом. А в приміщенні, де зібралися прихильники літератури та юні автори поетичних творів, панує атмосфера тепла й спокою. Усі в очікуванні початку вечора поезії, який, звісно, подарує незабутні емоції та враження, нові знайомства, допоможе відпочити від важких трудових буднів і поринути у світ поетичного слова.Тихий вечір. За вікном осінь щедро встеляє землю сухим листям, першими іскорками інею, густим туманом. А в приміщенні, де зібралися прихильники літератури та юні автори поетичних творів, панує атмосфера тепла й спокою. Усі в очікуванні початку вечора поезії, який, звісно, подарує незабутні емоції та враження, нові знайомства, допоможе відпочити від важких трудових буднів і поринути у світ поетичного слова.Тихий вечір. За вікном осінь щедро встеляє землю сухим листям, першими іскорками інею, густим туманом. А в приміщенні, де зібралися прихильники літератури та юні автори поетичних творів, панує атмосфера тепла й спокою. Усі в очікуванні початку вечора поезії, який, звісно, подарує незабутні емоції та враження, нові знайомства, допоможе відпочити від важких трудових буднів і поринути у світ поетичного слова."),
                          ),
                          Divider(height: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Учасників:", style: TextStyle(fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                              Text("5"),
                              Icon(Icons.people_outline),
                              Expanded(
                                child: Container(),
                              ),
                              RaisedButton(
                                child: Text("Піду"),
                                onPressed: () {},
                              ),
                            ],
                          )
                          // Expanded(child: CommentsList()),
                        ],
                      ),
                      CommentsList()
                    ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

const List<String> choices = const <String>["Подробніше", "Коментарі"];
