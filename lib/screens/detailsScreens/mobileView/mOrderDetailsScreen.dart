import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../controllers/orderDetailsController.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';

class mOrderDetailsScreen extends StatelessWidget{
  final String orderID;

  mOrderDetailsScreen({super.key, required this.orderID});

  final orderDetailsController _getC = Get.put(orderDetailsController());
  final customWidgets _widgets = customWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('orderId', isEqualTo: orderID)
              .snapshots(),
          builder: (context, snapshot) {
            _getC.dropDownMenuValue.value = _getC.getOrderStatusIndex(snapshot.data!.docs[0].get('status'));
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Order Number# ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      SelectableText(
                        snapshot.data!.docs[0].get('orderNumber').toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Order ID",
                            value: snapshot.data!.docs[0].get('orderId')),
                        _widgets.orderDetailCell(
                            info: "Order Type",
                            value: snapshot.data!.docs[0].get('type')),
                      ]),
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Order Title",
                            value: snapshot.data!.docs[0].get('title')),
                        _widgets.orderDetailCell(
                            info: "User ID",
                            value: snapshot.data!.docs[0].get('uid')),
                      ]),
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Name",
                            value: snapshot.data!.docs[0].get('name')),
                        _widgets.orderDetailCell(
                            info: "Phone Number",
                            value: snapshot.data!.docs[0].get('phoneNumber')),
                      ]),
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Delivery Address",
                            value: snapshot.data!.docs[0].get('address')),
                        _widgets.orderDetailCell(
                            info: "Address Description",
                            value: snapshot.data!.docs[0]
                                .get('addressDescription')),
                      ]),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Payment Method",
                            value: snapshot.data!.docs[0].get('paymentMethod')),
                        _widgets.orderDetailCell(
                            info: "Total Amount",
                            value: snapshot.data!.docs[0]
                                .get('totalAmount')
                                .toString()),
                      ])
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _widgets.orderDetailCell(
                      info: "Time Stamp",
                      value: _getC.getDateTime(
                          snapshot.data!.docs[0].get('timestamp'))),
                ],),
                Card(
                  margin:
                  const EdgeInsets.all(20.0),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: SizedBox(
                    height: 200.0,
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 100.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.2,
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Timeline.tileBuilder(
                            theme: TimelineThemeData(
                              direction: Axis.horizontal,
                              connectorTheme: const ConnectorThemeData(
                                thickness: 5.0,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              itemExtentBuilder: (_, __) =>
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.2,
                              contentsBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    _getC.statusText[index],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: (_getC.getOrderStatusIndex(snapshot
                                          .data!.docs[0]
                                          .get('status')) ==
                                          index)
                                          ? kPrimaryColor
                                          : kBlack,
                                    ),
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) {
                                Color color;
                                if (index ==
                                    _getC.getOrderStatusIndex(
                                        snapshot.data!.docs[0].get('status'))) {
                                  color = kPrimaryColor;
                                } else if (index <
                                    _getC.getOrderStatusIndex(
                                        snapshot.data!.docs[0].get('status'))) {
                                  color = kPrimaryColor;
                                } else {
                                  color = kGrey.withOpacity(0.3);
                                }
                                return OutlinedDotIndicator(
                                  size: 14.0,
                                  color: color,
                                  borderWidth: 5,
                                );
                              },
                              connectorBuilder: (_, index, type) {
                                if (index > 0) {
                                  if (index <=
                                      _getC.getOrderStatusIndex(snapshot
                                          .data!.docs[0]
                                          .get('status'))) {
                                    return const SolidLineConnector(
                                      color: kPrimaryColor,
                                      thickness: 3,
                                    );
                                  } else {
                                    return SolidLineConnector(
                                      color: kGrey.withOpacity(0.3),
                                      thickness: 5,
                                    );
                                  }
                                } else {
                                  return null;
                                }
                              },
                              itemCount: 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _getC.dropDownMenuValue.value,
                                  focusColor: Colors.transparent,
                                  items: [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text(_getC.statusText[0]),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text(_getC.statusText[1]),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text(_getC.statusText[2]),
                                    ),
                                    DropdownMenuItem(
                                      value: 3,
                                      child: Text(_getC.statusText[3]),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    _getC.dropDownMenuValue.value =
                                    value!;
                                    _getC.updateButtonVisibility.value =
                                    true;
                                  }
                              ),
                            ),
                              const Padding(padding: EdgeInsets.only(left: 10.0)),
                              Obx(
                                    () =>
                                    Visibility(
                                      visible: _getC.updateButtonVisibility
                                          .value,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            _getC.updateOrderStatus(
                                                orderID: orderID,
                                                status: _getC.statusText[_getC
                                                    .dropDownMenuValue.value]);
                                          },
                                          child: const Text("Update Order Status")),
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}