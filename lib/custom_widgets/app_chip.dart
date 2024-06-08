import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppChip extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  const AppChip({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: kGrey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
          color: kWhite
      ),
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, overflow: TextOverflow.fade,),
          InkWell(
            onTap: onTap,
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kGreyOutline
                ),
                padding: const EdgeInsets.all(2.0),
                child: const Icon(Icons.close, size: 12.0, color: kGrey,)),
          )
        ],
      ),
    );
  }

}