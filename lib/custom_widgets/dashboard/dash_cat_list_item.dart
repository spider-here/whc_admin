import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DashCatListItem extends StatelessWidget {
  final Widget leadingWidget;
  final String titleText;
  final String subTitleText;
  final Widget trailingWidget;
  final VoidCallback onClick;

  const DashCatListItem(
      {super.key, required this.leadingWidget,
        required this.titleText,
        required this.subTitleText,
        required this.trailingWidget,
        required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhite,
      surfaceTintColor: kWhite,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      elevation: 1.0,
      child: ListTile(
        leading: leadingWidget,
        title: Text(titleText,
          style: const TextStyle(fontSize: 16.0),
        ),
        subtitle: Text(subTitleText,
          style: const TextStyle(fontSize: 14.0),
        ),
        trailing: trailingWidget,
        dense: true,
        onTap: onClick,
      ),
    );
  }
}
