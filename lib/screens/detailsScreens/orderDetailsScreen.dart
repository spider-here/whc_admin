import 'package:flutter/cupertino.dart';

import 'desktopView/dOrderDetailsScreen.dart';
import 'mobileView/mOrderDetailsScreen.dart';

class orderDetailsScreen extends StatelessWidget{
  String orderID;

  orderDetailsScreen({super.key, required this.orderID});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mOrderDetailsScreen(orderID: orderID,);
      }
      else{
        return dOrderDetailsScreen(orderID: orderID,);
      }
    });
  }
}