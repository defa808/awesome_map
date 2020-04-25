import 'package:flutter/material.dart';

class EventDetailsContent extends StatelessWidget {
  const EventDetailsContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
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
                              style: TextStyle(color: Colors.lightBlue)),
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
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "12.10.19",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "14:30",
                              style: TextStyle(color: Colors.lightBlue),
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
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.label, color: Colors.lightBlue),
                        Flexible(
                          child: Text("Концерт",
                              style: TextStyle(color: Colors.lightBlue)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 8, bottom: 8),
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
    );
  }
}
