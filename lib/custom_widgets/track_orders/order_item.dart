import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OrderItem extends StatelessWidget{
  final String orderNumber;
  final String title;
  final String subtitle;
  final String orderType;
  final VoidCallback onPress;

  const OrderItem(
      {super.key, required this.orderNumber, required this.title, required this.subtitle, required this.orderType, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: kGrey, width: 0.5)
      ),
      margin: const EdgeInsets.only(bottom: 5.0),
      child: ListTile(
        leading: Tooltip(
            message: "Order Number",
            child: Text(
              orderNumber
            )),
        title: Text(
            title,
            style: const TextStyle(
                fontSize: 16.0),
            overflow: TextOverflow
                .ellipsis),
        subtitle:Text(
          subtitle,
          style: const TextStyle(
              fontSize: 12.0,
              color:
              kPrimarySwatch),
          overflow:
          TextOverflow
              .ellipsis,
        ),
        trailing: orderType ==
            'medicine'
            ? Tooltip(
            message:
            'Order Type: Medicine',
            child: Image.asset(
                "assets/images/Capsule.png",
                width: 24.0,
                height: 24.0))
            : orderType ==
            'labTest'
            ? Tooltip(
            message:
            'Order Type: Lab Test',
            child: Image.asset(
                "assets/images/labIcon.png",
                width: 24.0,
                height:
                24.0))
            : Tooltip(
            message:
            'Order Type: Home Service',
            child: Image.asset(
                "assets/images/homeService.png",
                width: 24.0,
                height: 24.0)),
        dense: true,
        onTap: onPress,
      ),
    );
  }

}