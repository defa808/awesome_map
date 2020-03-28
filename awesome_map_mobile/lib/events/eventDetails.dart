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

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.lightBlue,
                                  ),
                                  Flexible(
                                    child: Text("Палац України",
                                        style:
                                            TextStyle(color: Colors.lightBlue)),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "12.10.19",
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "14:30",
                                        style:
                                            TextStyle(color: Colors.lightBlue),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.label, color: Colors.lightBlue),
                                  Text("Концерт",
                                      style: TextStyle(color: Colors.lightBlue))
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                        "Тихий вечір. За вікном осінь щедро встеляє землю сухим листям, першими іскорками інею, густим туманом. А в приміщенні, де зібралися прихильники літератури та юні автори поетичних творів, панує атмосфера тепла й спокою. Усі в очікуванні початку вечора поезії, який, звісно, подарує незабутні емоції та враження, нові знайомства, допоможе відпочити від важких трудових буднів і поринути у світ поетичного слова."),
                  ),
                  Divider(height: 1),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Компонент коментарії"),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
