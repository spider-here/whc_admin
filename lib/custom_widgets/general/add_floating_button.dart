import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class AddFloatingButton extends StatelessWidget{
  final VoidCallback onPress;
  final String tooltipMessage;

  const AddFloatingButton({super.key, required this.onPress, this.tooltipMessage = 'Add New Item'});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(kPrimaryColor),
            elevation: MaterialStateProperty.all(2.0),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10.0))
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16.0,),
            Padding(padding: EdgeInsets.only(left: 3.0)),
            Text('Add New')
          ],
        ),
      ),
    );
  }

}