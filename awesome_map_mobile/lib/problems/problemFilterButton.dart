import 'package:awesome_map_mobile/models/problem/problemFilterModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemFilterButton extends StatelessWidget {
  const ProblemFilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: IconButton(
        iconSize: 30,
        color: Colors.white,
        icon: Icon(Icons.filter_list),
        // AnimatedIcon(
        //   icon: AnimatedIcons.filter,
        //   progress: _animationController,
        // ),
        // onPressed: () => _handleOnPressed(),
        onPressed: () {
          Provider.of<ProblemFilterModel>(context).showOrHide();
        },
      ),
    );
  }
}
