import 'package:awesome_map_mobile/theming/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelContainer extends StatefulWidget {
  SlidingUpPanelContainer({Key key, this.renderChild, this.isShow})
      : super(key: key);

  final Widget Function(ScrollController) renderChild;
  final bool isShow;

  @override
  _SlidingUpPanelContainerState createState() =>
      _SlidingUpPanelContainerState();
}

class _SlidingUpPanelContainerState extends State<SlidingUpPanelContainer> {
  final double _initFabHeight = 200.0;
  double _fabHeight = 0;
  double _panelHeightOpen;
  final double _panelHeightClosed = 100.0;

  @override
  void initState() {
    super.initState();
    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .68;
    return SlidingUpPanel(
      maxHeight: widget.isShow ? _panelHeightOpen : 0,
      minHeight: widget.isShow ? _panelHeightClosed : 0,
      parallaxEnabled: true,
      parallaxOffset: .5,
      color: CustomTheme.of(context).bottomAppBarColor,
      body: Container(),
      panelBuilder: (sc) => widget.isShow
          ? MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: this.widget.renderChild(sc)))
          : null,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      onPanelSlide: (double pos) => setState(() {
        _fabHeight =
            pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
      }),
    );
  }
}
