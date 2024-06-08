import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget{
  final bool full;
  final double width;

  const ProgressBar({super.key, this.full = true, this.width = double.maxFinite});

  @override
  Widget build(BuildContext context) {
    return full? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: width,
            height: 4.0,
            child: const LinearProgressIndicator()),
      ],
    ) : SizedBox(
        width: width,
        height: 4.0,
        child: const LinearProgressIndicator());
  }

}