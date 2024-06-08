import 'package:flutter/material.dart';
import 'package:whc_admin/utils/constants.dart';

class DashItemHead extends StatelessWidget{
  final String headingText; final Widget image;
  const DashItemHead({super.key, required this.headingText, required this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.zero,
      color: kWhite,
      surfaceTintColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 0.2)
        ),
        child: ListTile(
            title: Text(
              headingText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  overflow: TextOverflow.ellipsis),
            ),
            trailing: image),
      ),
    );
  }

}