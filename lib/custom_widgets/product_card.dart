import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String info1;
  final String info2;
  final String info3;
  final VoidCallback onPressed;
  final bool isDoctor;

  const ProductCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.info1,
      required this.info2,
      required this.info3,
      required this.onPressed,
      required this.isDoctor,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: kGreyOutline, width: 0.5)),
        child: Stack(
          children: [
            Align(
              alignment: FractionalOffset.center,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: AspectRatio(
                aspectRatio: 2.2,
                child: Container(
                  decoration: BoxDecoration(color: kBlack.withOpacity(0.3)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: kWhite),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                        ),
                        child: Text(
                          info1,
                          style: const TextStyle(
                            color: kWhite,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          right: 10.0,
                        ),
                        child: Text(
                          info2.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: kWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.topRight,
              child: isDoctor
                  ? Container(
                      width: 40.0,
                      decoration: BoxDecoration(color: kBlack.withOpacity(0.3)),
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            info3.toString(),
                            style:
                                const TextStyle(color: kWhite, fontSize: 12.0),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 3.0)),
                          const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 14.0,
                          )
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(color: kGreen.withOpacity(0.8)),
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        info3.toString(),
                        style: const TextStyle(color: kWhite, fontSize: 11.0),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
