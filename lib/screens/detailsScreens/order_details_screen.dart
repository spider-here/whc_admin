import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import 'package:whc_admin/custom_widgets/order_status_dropdown.dart';

import '../../custom_widgets/general/order_detail_cell.dart';
import '../../database/database.dart';
import '../../utils/constants.dart';
import '../../custom_widgets/general/progress_bar.dart';


class OrderDetailsScreen extends StatelessWidget {
  final String orderID;
  final String orderType;

  OrderDetailsScreen({
    super.key,
    required this.orderID,
    required this.orderType,
  });

  final statusText = [
    'pending',
    'accepted',
    'onTheWay',
    'completed',
  ];

  final Database _db = Database();
  RxBool updateButtonVisibility = false.obs;
  RxBool updateStatusVisibility = false.obs;
  RxInt dropDownMenuValue = 0.obs;

  String getDateTime(Timestamp timestamp) {
    final Timestamp ts = timestamp;
    final DateTime dateTime = ts.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    final dateString = dateTime.toString();
    return dateString;
  }

  int getOrderStatusIndex(String snapshot) {
    if (snapshot == "accepted") {
      dropDownMenuValue.value = 1;
      return 1;
    } else if (snapshot == "onTheWay") {
      dropDownMenuValue.value = 2;
      return 2;
    } else if (snapshot == "completed") {
      dropDownMenuValue.value = 3;
      return 3;
    } else {
      dropDownMenuValue.value = 0;
      return 0;
    }
  }

  updateOrderStatus({required String orderID, required String status}) {
    updateButtonVisibility.value = false;
    _db.updateOrderStatus(orderID: orderID, status: status).then((value) {
      updateButtonVisibility.value = false;
    }).onError((_, __) {
      Get.snackbar("Error", "Problem: Status not updated.");
      updateButtonVisibility.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .doc(orderID)
          .snapshots(),
      builder: (context, snapshot) {
        dropDownMenuValue.value =
            getOrderStatusIndex(snapshot.data!.get('status'));

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
              iconTheme: const IconThemeData(color: kPrimarySwatch),
              title: SelectableText(
                'Order Number# ${snapshot.data!.get('orderNumber')}',
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: kBlack),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Table(
                    defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.grey, width: 0.5),
                    children: [
                      TableRow(children: [
                        OrderDetailCell(
                            info: "Order ID",
                            value: snapshot.data!.get('orderId')),
                        OrderDetailCell(
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
                            ? snapshot.data!.get('labType') ==
                            'homeSample'
                            ? const OrderDetailCell(
                            info: "Lab Type",
                            value: 'Home Sample')
                            : FutureBuilder<
                            DocumentSnapshot<
                                Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('labs')
                              .doc(snapshot.data!.get('lId'))
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

                            return OrderDetailCell(
                              info: "Lab",
                              value: labData?['name'] ??
                                  'Lab Name Not Available', // Use the lab data as needed.
                            );
                          },
                        )
                            : OrderDetailCell(
                            info: "Order Title",
                            value: snapshot.data!.get('title')),
                        OrderDetailCell(
                            info: "User ID",
                            value: snapshot.data!.get('uid')),
                      ]),
                      TableRow(children: [
                        OrderDetailCell(
                            info: "Name", value: snapshot.data!.get('name')),
                        OrderDetailCell(
                            info: "Phone Number",
                            value:
                            snapshot.data!.get('phoneNumber').toString()),
                      ]),
                      TableRow(children: [
                        orderType == 'labTest'
                            ? snapshot.data!.get('labType') != 'homeSample'
                            ? FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('labs')
                              .doc(snapshot.data!.get('lId'))
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

                            return OrderDetailCell(
                              info: "Lab Address",
                              value: labData?['address'] ??
                                  'Lab Address Not Available', // Use the lab data as needed.
                            );
                          },
                        )
                            : OrderDetailCell(
                            info: "Address",
                            value:
                            '${address?.latitude}, ${address?.longitude}')
                            : OrderDetailCell(
                            info: "Delivery Location",
                            value:
                            '${address?.latitude}, ${address?.longitude}'),
                        orderType == 'labTest'
                            ? snapshot.data!.get('labType') != 'homeSample'
                            ? FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                          future: FirebaseFirestore.instance
                              .collection('labs')
                              .doc(snapshot.data!.get('lId'))
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

                            return OrderDetailCell(
                              info: "Lab Phone Number",
                              value: labData?['phoneNumber']
                                  .toString() ??
                                  'Lab Phone Number Not Available', // Use the lab data as needed.
                            );
                          },
                        )
                            : OrderDetailCell(
                            info: "Address Description",
                            value: snapshot.data!
                                .get('addressDescription'))
                            : OrderDetailCell(
                            info: "Address Description",
                            value:
                            snapshot.data!.get('addressDescription')),
                      ]),
                    ],
                  ),
                  orderType == 'medicine'
                      ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kGrey, width: 0.5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'ITEMS',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(thickness: 1.0),
                        StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('orders')
                              .doc(orderID)
                              .collection('items')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ProgressBar();
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child:
                                  Text('Error: ${snapshot.error}'));
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.size == 0) {
                              return const Center(
                                  child: Text('No items available.'));
                            }
                            ScrollController sc = ScrollController();
                            return SizedBox(
                              height: 345.0,
                              width: double.maxFinite,
                              child: Scrollbar(
                                thumbVisibility: true,
                                controller: sc,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(5.0),
                                  shrinkWrap: true,
                                  controller: sc,
                                  itemCount: snapshot.data!.size,
                                  itemBuilder: (_, index) {
                                    final itemDoc =
                                    snapshot.data!.docs[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                            height: 50.0,
                                            width: 50.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    itemDoc
                                                        .get('image')),
                                                fit: BoxFit.cover,
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
                                          color: kGreyOutline,
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
                      DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('labTests')
                        .doc(snapshot.data!.get('ltId'))
                        .get(),
                    builder: (context, labTestSnapshot) {
                      if (labTestSnapshot.connectionState ==
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

                      final labTestData = labTestSnapshot.data!
                          .data(); // Extract the lab data.

                      return Table(
                        children: [
                          TableRow(children: [
                            Container(
                                decoration: BoxDecoration(border: Border.all(color: kGrey, width: 0.5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 20.0),
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Lab Test',
                                      style: TextStyle(
                                          color: kGrey,
                                          fontSize: 12.0),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.0)),
                                    ListTile(
                                        dense: true,
                                        title: Text(
                                            labTestData?['name'] ??
                                                'Unknown',
                                            style: const TextStyle(
                                                fontSize: 16.0),
                                            overflow: TextOverflow
                                                .ellipsis),
                                        subtitle: RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: 'Test Type: ',
                                              style:
                                              TextStyle(
                                                  fontSize:
                                                  12.0,
                                                  color: kGrey),
                                            ),
                                            TextSpan(
                                              text:
                                              '${labTestData?['type'] ?? 'Unknown'}            ',
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color:
                                                  kPrimaryColor),
                                            ),
                                            const TextSpan(
                                              text: 'Sample Type: ',
                                              style:
                                              TextStyle(
                                                  fontSize:
                                                  12.0,
                                                  color: kGrey),
                                            ),
                                            TextSpan(
                                              text: labTestData?[
                                              'sampleType'],
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color:
                                                  kPrimaryColor),
                                            ),
                                          ]),
                                        ))
                                  ],
                                ))
                          ])
                        ],
                      );
                    },
                  )
                      : const SizedBox(
                    height: 0.0,
                    width: 0.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Table(
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      border: TableBorder.all(color: Colors.grey, width: 0.5),
                      children: [
                        TableRow(children: [
                          OrderDetailCell(
                              info: "Payment Method",
                              value: snapshot.data!.get('paymentMethod')),
                          orderType == 'labTest'
                              ? FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
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

                              return OrderDetailCell(
                                info: "Fee",
                                value: labData?['fee'].toString() ??
                                    'Fee Not Available', // Use the lab data as needed.
                              );
                            },
                          )
                              : OrderDetailCell(
                              info: "Total Amount",
                              value: snapshot.data!
                                  .get('totalAmount')
                                  .toString()),
                          OrderDetailCell(
                              info: "Time Stamp",
                              value: getDateTime(
                                  snapshot.data!.get('timestamp')))
                        ])
                      ],
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: kGrey, width: 0.5)),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Order Status',
                          style: TextStyle(color: kGrey, fontSize: 12.0),
                        ),
                        Flexible(
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
                              MediaQuery.of(context).size.width / 6,
                              contentsBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    statusText[index],
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: (getOrderStatusIndex(snapshot
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
                                    getOrderStatusIndex(
                                        snapshot.data!.get('status'))) {
                                  color = kPrimaryColor;
                                } else if (index <
                                    getOrderStatusIndex(
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
                                      getOrderStatusIndex(
                                          snapshot.data!.get('status'))) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            OrderStatusDropdown((value) {
                              dropDownMenuValue.value = value;
                              updateButtonVisibility.value = true;
                            }, statusText,
                              initialVal: statusText.indexOf(snapshot.data!.get('status')),),
                            const Padding(
                                padding: EdgeInsets.only(left: 20.0)),
                            Obx(
                                  () => Visibility(
                                visible: updateButtonVisibility.value,
                                child: ElevatedButton(
                                    onPressed: () {
                                      updateOrderStatus(
                                          orderID: orderID,
                                          status: statusText[
                                          dropDownMenuValue.value]);
                                    },
                                    child: const Text("Update")),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );

  }
}
