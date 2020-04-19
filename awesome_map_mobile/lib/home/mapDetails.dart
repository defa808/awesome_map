import 'package:awesome_map_mobile/home/title.dart';
import 'package:flutter/material.dart';

class MapDetails extends StatelessWidget {
  Widget child;
  MapDetails({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, //important part
      child: DraggableScrollableSheet(
        minChildSize: 0.4,
        maxChildSize: 0.85,
        initialChildSize: 0.5,
        expand: true,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            padding: EdgeInsets.only(top: 20, left:20, right:20),
            child: Column(
              children: <Widget>[
                Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(18))),
               SizedBox(
                  height: 20,
                ), 
               Header(
                text: "Розкидане сміття біля скверу",
              ),
                SizedBox(
                  height: 10,
                ),
                 Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 5),
                        child: child),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
