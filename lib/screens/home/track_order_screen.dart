import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/app_search_controller.dart';
import 'package:whc_admin/custom_widgets/order_status_dropdown.dart';
import 'package:whc_admin/custom_widgets/track_orders/orders_list_view.dart';
import 'package:whc_admin/models/track_orders_item_model.dart';

import '../../controllers/track_orders_controller.dart';
import '../../custom_widgets/general/app_search_bar.dart';
import '../../custom_widgets/general/page_view_page.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../utils/constants.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TrackOrdersController getC = Get.put(TrackOrdersController());
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0;
        if (isMobile) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: OrderStatusDropdown((i) {
                      getC.dropdownStatusOnChanged(i);
                    }, getC.filterText),
                  ),
                ],
              ),
              const Divider(
                height: 0.0,
                color: kGreyOutline,
                thickness: 0.5,
              ),
              Obx(
                    () => StreamBuilder<List<TrackOrdersItemModel>>(
                  stream: getC.getOrdersByStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ProgressBar(full: true,);
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No orders found'));
                    } else {
                      List<TrackOrdersItemModel> ordersList =
                      snapshot.data!;
                      return OrdersListView(dataList: ordersList, isMobile: true,);
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          final AppSearchController searchC = Get.put(AppSearchController());
          return PageViewPage(
              width: constraints.maxWidth,
              child: Stack(
                children: [
                  Obx(
                    () => StreamBuilder<List<TrackOrdersItemModel>>(
                      stream: getC.getOrdersByStatus(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ProgressBar(full: true,);
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No orders found'));
                        } else {
                          return Obx(() {
                            List<TrackOrdersItemModel> ordersList =
                            snapshot.data!;
                            if(searchC.searchTrigger.isTrue){
                              List<TrackOrdersItemModel> filteredOrders = ordersList.where((i) => i.title.toLowerCase().startsWith(searchC.searchText.value)).toList();
                              return OrdersListView(dataList: filteredOrders);
                            }
                            else{
                              return OrdersListView(dataList: ordersList);
                            }
                          });
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppSearchBar(),
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          OrderStatusDropdown((i) {
                            getC.dropdownStatusOnChanged(i);
                          }, getC.filterText),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        }
      }),
    );
  }
}
