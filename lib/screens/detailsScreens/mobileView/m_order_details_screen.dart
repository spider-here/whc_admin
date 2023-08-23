import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../controllers/order_details_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets.dart';

class MOrderDetailsScreen extends StatelessWidget{
  final String orderID;
  final String orderType;

  MOrderDetailsScreen({super.key, required this.orderID, required this.orderType});

  final OrderDetailsController _getC = Get.put(OrderDetailsController());
  final CustomWidgets _widgets = CustomWidgets();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .doc(orderID)
          .snapshots(),
      builder: (context, snapshot) {
        _getC.dropDownMenuValue.value =
            _getC.getOrderStatusIndex(snapshot.data!.get('status'));
        GeoPoint? address;
        if (orderType == 'labTest' &&
            snapshot.data!.get('labType') == 'inLab') {
          address = null;
        } else {
          address = snapshot.data!.get('address');
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: const IconThemeData(
                color: kPrimarySwatch
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Order Number# ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: kBlack
                      ),
                    ),
                    SelectableText(
                      snapshot.data!.get('orderNumber').toString(),
                      style: const TextStyle(
                        fontSize: 24.0,
                          color: kBlack
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      body: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      _widgets.orderDetailCell(
                          info: "Order ID",
                          value: snapshot.data!.get('orderId')),
                      _widgets.orderDetailCell(
                          info: "Order Type",
                          value: snapshot.data!.get('type')),
                    ]),
                    TableRow(children: [
                      orderType == 'medicine'
                          ? const SizedBox(
                        height: 0.0,
                        width: 0.0,
                      )
                          : orderType == 'labTest'
                          ? snapshot.data!
                          .get('labType') ==
                          'homeSample'
                          ? _widgets.orderDetailCell(
                          info: "Lab Type",
                          value: 'Home Sample')
                          : FutureBuilder<
                          DocumentSnapshot<
                              Map<String,
                                  dynamic>>>(
                        future:
                        FirebaseFirestore
                            .instance
                            .collection(
                            'labs')
                            .doc(snapshot
                            .data!
                            .get('lId'))
                            .get(),
                        builder: (context,
                            labSnapshot) {
                          if (labSnapshot
                              .connectionState ==
                              ConnectionState
                                  .waiting) {
                            return const Text(
                                'Loading..'); // Loading indicator while fetching data.
                          }

                          if (labSnapshot
                              .hasError) {
                            return Text(
                                'Error: ${labSnapshot.error}');
                          }

                          if (!labSnapshot
                              .hasData) {
                            return const Text(
                                'No lab selected.'); // Handle case where data is null.
                          }

                          final labData =
                          labSnapshot.data!
                              .data(); // Extract the lab data.

                          return _widgets
                              .orderDetailCell(
                            info: "Lab",
                            value: labData?[
                            'name'] ??
                                'Lab Name Not Available', // Use the lab data as needed.
                          );
                        },
                      )
                          : _widgets.orderDetailCell(
                          info: "Order Title",
                          value: snapshot.data!
                              .get('title')),
                      _widgets.orderDetailCell(
                          info: "User ID",
                          value: snapshot.data!.get('uid')),
                    ]),
                    TableRow(children: [
                      _widgets.orderDetailCell(
                          info: "Name",
                          value: snapshot.data!.get('name')),
                      _widgets.orderDetailCell(
                          info: "Phone Number",
                          value: snapshot.data!.get('phoneNumber').toString()),
                    ]),
                    TableRow(children: [
                      orderType == 'labTest'
                          ? snapshot.data!.get('labType') !=
                          'homeSample'
                          ? FutureBuilder<
                          DocumentSnapshot<
                              Map<String, dynamic>>>(
                        future: FirebaseFirestore
                            .instance
                            .collection('labs')
                            .doc(snapshot.data!
                            .get('lId'))
                            .get(),
                        builder:
                            (context, labSnapshot) {
                          if (labSnapshot
                              .connectionState ==
                              ConnectionState
                                  .waiting) {
                            return const Text(
                                'Loading..'); // Loading indicator while fetching data.
                          }

                          if (labSnapshot
                              .hasError) {
                            return Text(
                                'Error: ${labSnapshot.error}');
                          }

                          if (!labSnapshot
                              .hasData) {
                            return const Text(
                                'No lab selected.'); // Handle case where data is null.
                          }

                          final labData = labSnapshot
                              .data!
                              .data(); // Extract the lab data.

                          return _widgets
                              .orderDetailCell(
                            info: "Lab Address",
                            value: labData?[
                            'address'] ??
                                'Lab Address Not Available', // Use the lab data as needed.
                          );
                        },
                      )
                          : _widgets.orderDetailCell(
                          info: "Address",
                          value:
                          '${address?.latitude}, ${address?.longitude}')
                          : _widgets.orderDetailCell(
                          info: "Delivery Location",
                          value:
                          '${address?.latitude}, ${address?.longitude}'),
                      orderType == 'labTest'
                          ? snapshot.data!.get('labType') !=
                          'homeSample'
                          ? FutureBuilder<
                          DocumentSnapshot<
                              Map<String, dynamic>>>(
                        future: FirebaseFirestore
                            .instance
                            .collection('labs')
                            .doc(snapshot.data!
                            .get('lId'))
                            .get(),
                        builder:
                            (context, labSnapshot) {
                          if (labSnapshot
                              .connectionState ==
                              ConnectionState
                                  .waiting) {
                            return const Text(
                                'Loading..'); // Loading indicator while fetching data.
                          }

                          if (labSnapshot
                              .hasError) {
                            return Text(
                                'Error: ${labSnapshot.error}');
                          }

                          if (!labSnapshot
                              .hasData) {
                            return const Text(
                                'No lab selected.'); // Handle case where data is null.
                          }

                          final labData = labSnapshot
                              .data!
                              .data(); // Extract the lab data.

                          return _widgets
                              .orderDetailCell(
                            info:
                            "Lab Phone Number",
                            value: labData?[
                            'phoneNumber']
                                .toString() ??
                                'Lab Phone Number Not Available', // Use the lab data as needed.
                          );
                        },
                      )
                          : _widgets.orderDetailCell(
                          info: "Address Description",
                          value: snapshot.data!.get(
                              'addressDescription'))
                          : _widgets.orderDetailCell(
                          info: "Address Description",
                          value: snapshot.data!
                              .get('addressDescription')),
                    ]),

                  ],
                ),
                SizedBox(
                    height: 400.0,
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: orderType == 'medicine'
                        ? Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0),
                            child: Text(
                              'ITEMS',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          ),
                          const Divider(thickness: 1.0),
                          StreamBuilder<
                              QuerySnapshot<
                                  Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('orders')
                                .doc(orderID)
                                .collection('items')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                    CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text(
                                        'Error: ${snapshot.error}'));
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.size == 0) {
                                return const Center(
                                    child: Text(
                                        'No items available.'));
                              }
                              ScrollController sc =
                              ScrollController();
                              return SizedBox(
                                height: 345.0,
                                width: double.maxFinite,
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  controller: sc,
                                  child: ListView.builder(
                                    padding:
                                    const EdgeInsets.all(5.0),
                                    shrinkWrap: true,
                                    controller: sc,
                                    itemCount:
                                    snapshot.data!.size,
                                    itemBuilder: (_, index) {
                                      final itemDoc = snapshot
                                          .data!.docs[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            leading:
                                            Container(
                                              height: 50.0,
                                              width: 50.0,
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    15.0),
                                                image:
                                                DecorationImage(
                                                  image: NetworkImage(
                                                      itemDoc.get(
                                                          'image')),
                                                  fit: BoxFit
                                                      .cover,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                                '${itemDoc.get('name')}'),
                                            subtitle: Text(
                                                '${itemDoc.get('type')}'),
                                            trailing: Text(
                                              '${itemDoc.get('quantity')} ${itemDoc.get('isPack') == true ? "Pack" : "Strip"}',
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 0.2,
                                            color:
                                            kGreyOutline,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                        : orderType == 'labTest'
                        ? FutureBuilder<
                        DocumentSnapshot<
                            Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('labTests')
                          .doc(snapshot.data!.get('ltId'))
                          .get(),
                      builder:
                          (context, labTestSnapshot) {
                        if (labTestSnapshot
                            .connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                              'Loading..'); // Loading indicator while fetching data.
                        }

                        if (labTestSnapshot.hasError) {
                          return Text(
                              'Error: ${labTestSnapshot.error}');
                        }

                        if (!labTestSnapshot.hasData) {
                          return const Text(
                              'No lab selected.'); // Handle case where data is null.
                        }

                        final labTestData = labTestSnapshot
                            .data!
                            .data(); // Extract the lab data.

                        return Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                20.0),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding:
                                EdgeInsets.only(
                                    top: 8.0),
                                child: Text(
                                  'Lab Test',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight:
                                      FontWeight
                                          .bold),
                                ),
                              ),
                              const Divider(thickness: 1.0),
                              SizedBox(
                                  height: 345.0,
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Tooltip(
                                            message:
                                            'Sample Type',
                                            child: Text(
                                                labTestData?[
                                                'sampleType'])),
                                        title: Tooltip(
                                            message:
                                            'Test Name',
                                            child: Text(
                                                labTestData?[
                                                'name'])),
                                        subtitle: Tooltip(
                                            message:
                                            'Type',
                                            child: Text(
                                                labTestData?[
                                                'type'])),
                                        trailing: Tooltip(
                                            message:
                                            'For Gender',
                                            child: Text(
                                                labTestData?[
                                                'testFor'])),
                                      ),
                                      const Divider(
                                        thickness: 0.2,
                                        color:
                                        kGreyOutline,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        );
                      },
                    )
                        : const SizedBox(
                      height: 0.0,
                      width: 0.0,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        _widgets.orderDetailCell(
                            info: "Payment Method",
                            value: snapshot.data!.get('paymentMethod')),
                        orderType == 'labTest'
                            ? FutureBuilder<
                            DocumentSnapshot<
                                Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('labTests')
                              .doc(snapshot.data!.get('ltId'))
                              .get(),
                          builder: (context, labSnapshot) {
                            if (labSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                  'Loading..'); // Loading indicator while fetching data.
                            }

                            if (labSnapshot.hasError) {
                              return Text(
                                  'Error: ${labSnapshot.error}');
                            }

                            if (!labSnapshot.hasData) {
                              return const Text(
                                  'No lab selected.'); // Handle case where data is null.
                            }

                            final labData = labSnapshot.data!
                                .data(); // Extract the lab data.

                            return _widgets.orderDetailCell(
                              info: "Fee",
                              value: labData?['fee']
                                  .toString() ??
                                  'Fee Not Available', // Use the lab data as needed.
                            );
                          },
                        )
                            : _widgets.orderDetailCell(
                            info: "Total Amount",
                            value: snapshot.data!
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
                          snapshot.data!.get('timestamp'))),
                ],),
                Card(
                  margin:
                  const EdgeInsets.only(top: 20.0),
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
                                          .data!
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
                                        snapshot.data!.get('status'))) {
                                  color = kPrimaryColor;
                                } else if (index <
                                    _getC.getOrderStatusIndex(
                                        snapshot.data!.get('status'))) {
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
                                          .data!
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
            )));
          },
    );
  }

}