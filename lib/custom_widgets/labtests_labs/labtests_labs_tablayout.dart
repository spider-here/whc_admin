import 'package:flutter/material.dart';

import '../general/app_search_bar.dart';
import '../general/app_tab_bar.dart';

class LabTestsLabsTabLayout extends StatelessWidget {
  final List<Widget> tabViews;
  final Function(int) onPress;
  final bool isMobile;

  const LabTestsLabsTabLayout(
      {super.key,
        required this.tabViews,
        required this.onPress,
        this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(children: tabViews),
        Align(
          alignment: FractionalOffset.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: isMobile
                  ? [
                AppTabBar(
                  tabs: const [
                    Tab(
                      text: "Lab Tests",
                    ),
                    Tab(
                      text: "Labs",
                    ),
                  ],
                  onPress: (index) {
                    onPress(index);
                  },
                )
              ]
                  : [
                const AppSearchBar(),
                const Padding(padding: EdgeInsets.only(left: 20.0)),
                AppTabBar(
                  tabs: const [
                    Tab(
                      text: "Lab Tests",
                    ),
                    Tab(
                      text: "Labs",
                    ),
                  ],
                  onPress: (index) {
                    onPress(index);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}