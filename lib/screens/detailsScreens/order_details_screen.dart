import 'package:flutter/cupertino.dart';

import 'desktopView/d_order_details_screen.dart';
import 'mobileView/m_order_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget{
  final String orderID;
  final String orderType;

  const OrderDetailsScreen({super.key, required this.orderID,  required this.orderType});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MOrderDetailsScreen(orderID: orderID, orderType: orderType);
      }
      else{
        return DOrderDetailsScreen(orderID: orderID, orderType: orderType);
      }
    });
  }
}