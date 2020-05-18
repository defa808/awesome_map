import 'package:awesome_map_mobile/base/title.dart';
import 'package:flutter/material.dart';

class MapDetails extends StatelessWidget {
  MapDetails({Key key, @required this.child, @required this.title, @required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  final Widget child;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(18))),
        ),
         SizedBox(
          height: 10,
        ),
        this.title,
        SizedBox(
          height: 10,
        ),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 5), child: child),
          ),
        ),
      ],
    );
  }
}
