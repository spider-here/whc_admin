import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../utils/constants.dart';

class AppTabBar extends StatelessWidget{

  final List<Tab> tabs;
  final Function(int) onPress;


  const AppTabBar({super.key, required this.tabs, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: EdgeInsets.zero,
      elevation: 1.0,
      child: SizedBox(
        height: 40.0,
        width: 200.0,
        child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: RectangularIndicator(
                bottomLeftRadius: 0.0,
                bottomRightRadius: 0.0,
                topLeftRadius: 0.0,
                topRightRadius: 0.0,
                color: kPrimaryColor,
                paintingStyle: PaintingStyle.stroke,
                strokeWidth: 1.0),
            onTap: (index) {onPress(index);},
            tabs: tabs
        ),
      ),
    );
  }

}