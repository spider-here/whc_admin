import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OrderDetailCell extends StatelessWidget{
  final String info; final String value;
  const OrderDetailCell({super.key, required this.info, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info,
              style: const TextStyle(color: kGrey, fontSize: 12.0),
            ),
            const Padding(padding: EdgeInsets.only(top: 5.0)),
            SelectableText(value, style: const TextStyle(fontSize: 16.0)),
          ],
        ));
  }

}