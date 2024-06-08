import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/track_orders/order_item.dart';

import '../../models/track_orders_item_model.dart';
import '../../screens/detailsScreens/order_details_screen.dart';

class OrdersListView extends StatelessWidget {
  final List<TrackOrdersItemModel> dataList;
  final bool isMobile;

  const OrdersListView({super.key, required this.dataList, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: isMobile? 20.0 : 80.0, horizontal: 20.0),
      itemBuilder: (context, index) {
        TrackOrdersItemModel order = dataList[index];
        return OrderItem(
          orderNumber: order.orderNumber,
          title: order.title,
          orderType: order.orderType,
          subtitle: order.subtitle,
          onPress: () {
            Get.to(() => OrderDetailsScreen(
                  orderID: order.id,
                  orderType: order.orderType,
                ));
          },
        );
      },
    );
  }
}
