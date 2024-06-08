import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PageViewPage extends StatelessWidget{
  final Widget child;
  final double width;
  const PageViewPage({super.key, required this.child, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: kWhite
        ),
        child: Row(
          children: [
            const VerticalDivider(color: kGreyOutline, width: 0.0, thickness: 1.0,),
            SizedBox(
                width: width,
                child: child),
          ],
        )
    );
  }

}