import 'package:flutter/material.dart';

class FilterContainer extends StatefulWidget {
  final Widget child;
  FilterContainer({Key key, @required this.child}) : super(key: key);

  @override
  _FilterContainerState createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInToLinear,
      alignment: Alignment.topCenter,
      child: widget.child,
      vsync: this,
    );
  }
}
