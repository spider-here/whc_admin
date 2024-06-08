import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LabTestCard extends StatelessWidget {
  final int index;
  final String title;
  final String info2;
  final String info1;
  final int fee;
  final VoidCallback onPress;
  final bool isLab;
  final bool isMobile;

  const LabTestCard(
      {super.key, required this.fee,
      required this.title,
      required this.info2,
      required this.info1,
      required this.onPress, required this.index, this.isLab = false, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: kGrey, width: 0.5)),
      margin: const EdgeInsets.only(bottom: 5.0),
      child: ListTile(
        leading: Text('${index + 1}'),
        title: Text(title,
            style: const TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis),
        subtitle: RichText(text: TextSpan(
          children: [
            TextSpan(
              text: isLab? 'Address: ' : 'Test Type: ',
              style: const TextStyle(fontSize: 10.0, color: kGrey),
            ),
            TextSpan(
              text: isMobile? '$info1\n' : '$info1            ',
              style: const TextStyle(fontSize: 12.0, color: kPrimaryColor),
            ),
            TextSpan(
              text: isLab? 'Phone# ' : 'Sample Type: ',
              style: const TextStyle(fontSize: 10.0, color: kGrey),
            ),
            TextSpan(
              text: info2,
              style: const TextStyle(fontSize: 12.0, color: kPrimaryColor),
            ),
          ]
        ),
        ),
        trailing: isLab ? const SizedBox() : Text(
          'Rs. $fee',
          style: const TextStyle(fontSize: 12.0, color: kGreen),
          overflow: TextOverflow.ellipsis,
        ),
        dense: true,
        onTap: onPress,
      ),
    );
  }
}
