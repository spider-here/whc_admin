
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/utils/extensions.dart';

import '../../../controllers/track_orders_controller.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets.dart';
import '../../detailsScreens/order_details_screen.dart';

class DTrackOrderScreen extends StatelessWidget {
  final CustomWidgets _widgets = CustomWidgets();

  DTrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgets.pageViewPage(
            context: context,
            widget: GetBuilder(
                init: TrackOrdersController(),
                builder: (getC) {
                  if (getC.searchTrigger == true) {
                  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: getC.radioGroupValue == 1
                            ? FirebaseFirestore.instance
                                    .collection('orders')
                                    .where('status', isEqualTo: "pending")
                                    .where('name', whereIn: [
                                    getC.searchText.trim().toUpperCase(),
                                    getC.searchText.trim().toLowerCase(),
                                    getC.searchText.trim().camelCase,
                                    getC.searchText.trim().capitalizeFirst,
                                    getC.searchText.trim().capitalizeByWord()
                                  ]).snapshots()
                                : getC.radioGroupValue == 2
                                    ? FirebaseFirestore.instance
                                            .collection('orders')
                                            .where('status',
                                                isEqualTo: "accepted")
                                            .where('name', whereIn: [
                                            getC.searchText
                                                .trim()
                                                .toUpperCase(),
                                            getC.searchText
                                                .trim()
                                                .toLowerCase(),
                                            getC.searchText.trim().camelCase,
                                            getC.searchText
                                                .trim()
                                                .capitalizeFirst,
                                            getC.searchText
                                                .trim()
                                                .capitalizeByWord()
                                          ]).snapshots()
                                        : getC.radioGroupValue == 3
                                            ? FirebaseFirestore.instance
                                                    .collection('orders')
                                                    .where('status',
                                                        isEqualTo: "onTheWay")
                                                    .where('name', whereIn: [
                                                    getC.searchText
                                                        .trim()
                                                        .toUpperCase(),
                                                    getC.searchText
                                                        .trim()
                                                        .toLowerCase(),
                                                    getC.searchText
                                                        .trim()
                                                        .camelCase,
                                                    getC.searchText
                                                        .trim()
                                                        .capitalizeFirst,
                                                    getC.searchText
                                                        .trim()
                                                        .capitalizeByWord()
                                                  ]).snapshots()
                                                : getC.radioGroupValue == 4
                                                    ? FirebaseFirestore.instance
                                                            .collection(
                                                                'orders')
                                                            .where('status',
                                                                isEqualTo:
                                                                    "completed")
                                                            .where('name',
                                                                whereIn: [
                                                                getC.searchText
                                                                    .trim()
                                                                    .toUpperCase(),
                                                                getC.searchText
                                                                    .trim()
                                                                    .toLowerCase(),
                                                                getC.searchText
                                                                    .trim()
                                                                    .camelCase,
                                                                getC.searchText
                                                                    .trim()
                                                                    .capitalizeFirst,
                                                                getC.searchText
                                                                    .trim()
                                                                    .capitalizeByWord()
                                                              ]).snapshots()
                                                        : FirebaseFirestore.instance.collection('orders').where('name', whereIn: [
                                                                getC.searchText
                                                                    .trim()
                                                                    .toUpperCase(),
                                                                getC.searchText
                                                                    .trim()
                                                                    .toLowerCase(),
                                                                getC.searchText
                                                                    .trim()
                                                                    .camelCase,
                                                                getC.searchText
                                                                    .trim()
                                                                    .capitalizeFirst,
                                                                getC.searchText
                                                                    .trim()
                                                                    .capitalizeByWord()
                                                              ])
                            .orderBy('orderNumber', descending: true).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Column(
                              children: [
                                _widgets.searchBar(
                                    width: 400.0,
                                    controller: getC.searchC,
                                    onChanged: (val) {
                                      String txt = val;
                                      if (txt.isEmpty) {
                                        getC.searchText = '';
                                        getC.searchTrigger = false;
                                        getC.update();
                                      } else {
                                        getC.searchText = txt;
                                        getC.update(['dataList']);
                                      }
                                    },
                                    onSubmit: (val) {
                                      String txt = val;
                                      if (txt.isEmpty) {
                                        getC.searchTrigger = false;
                                        getC.update();
                                      } else {
                                        getC.searchText = txt;
                                        getC.update();
                                      }
                                    }),
                                SizedBox(
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: RadioListTile(
                                          value: 0,
                                          groupValue: getC.radioGroupValue,
                                          onChanged: (value) {
                                            getC.radioOnChanged(value!);
                                            getC.update();
                                          },
                                          title: const Text('All'),
                                          dense: true,
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          value: 1,
                                          groupValue: getC.radioGroupValue,
                                          onChanged: (value) {
                                            getC.radioOnChanged(value!);
                                            getC.update();
                                          },
                                          title: const Text('Pending'),
                                          dense: true,
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          value: 2,
                                          groupValue: getC.radioGroupValue,
                                          onChanged: (value) {
                                            getC.radioOnChanged(value!);
                                            getC.update();
                                          },
                                          title: const Text('Accepted'),
                                          dense: true,
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          value: 3,
                                          groupValue: getC.radioGroupValue,
                                          onChanged: (value) {
                                            getC.radioOnChanged(value!);
                                            getC.update();
                                          },
                                          title: const Text('On the Way'),
                                          dense: true,
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          value: 4,
                                          groupValue: getC.radioGroupValue,
                                          onChanged: (value) {
                                            getC.radioOnChanged(value!);
                                            getC.update();
                                          },
                                          title: const Text('Completed'),
                                          dense: true,
                                        )),
                                      ]),
                                ),
                                GetBuilder(
                                    init: TrackOrdersController(),
                                    id: 'dataList',
                                    builder: (controller) {
                                      return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            itemCount:
                                                snapshot.data?.docs.length,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 40.0),
                                            itemBuilder: (context, index) {
                                                return Card(
                                                  elevation: 2.0,
                                                  child: ListTile(
                                                    leading: Tooltip(
                                                        message: "Order Number",
                                                        child: Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                                  'orderNumber')
                                                              .toString(),
                                                        )),
                                                    title: Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('name'),
                                                        style: const TextStyle(
                                                            fontSize: 16.0),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    subtitle: Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('title'),
                                                        style: const TextStyle(
                                                            fontSize: 14.0),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    trailing: Text(
                                                        getC.radioGroupValue ==
                                                                0
                                                            ? snapshot.data!
                                                                .docs[index]
                                                                .get('status')
                                                            : snapshot.data!
                                                                .docs[index]
                                                                .get(
                                                                    'totalAmount')
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimarySwatch),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    dense: true,
                                                    onTap: () {
                                                      Get.to(() =>
                                                          OrderDetailsScreen(
                                                            orderID: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .id,
                                                            orderType: snapshot.data!.docs[index].get('type'),
                                                          ));
                                                    },
                                                  ),
                                                );
                                            },
                                          ));
                                    })
                              ],
                            );
                          }
                        },
                      );
                }
                else{
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: getC.radioGroupValue == 1
                          ? FirebaseFirestore.instance
                          .collection('orders')
                          .where('status', isEqualTo: "pending")
                          .snapshots()
                          : getC.radioGroupValue == 2
                          ? FirebaseFirestore.instance
                          .collection('orders')
                          .where('status', isEqualTo: "accepted")
                          .snapshots()
                          : getC.radioGroupValue == 3
                          ? FirebaseFirestore.instance
                          .collection('orders')
                          .where('status',
                          isEqualTo: "onTheWay")
                          .snapshots()
                          : getC.radioGroupValue == 4
                          ? FirebaseFirestore.instance
                          .collection('orders')
                          .where('status',
                          isEqualTo:
                          "completed")
                          .snapshots()
                          : FirebaseFirestore.instance.collection('orders').orderBy('orderNumber', descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: [
                              _widgets.searchBar(
                                  width: 400.0,
                                  controller: getC.searchC,
                                  onChanged: (val) {
                                    String txt = val;
                                    if (txt.isEmpty) {
                                      getC.searchText = '';
                                      getC.searchTrigger = false;
                                      getC.update();
                                    } else {
                                      getC.searchText = txt;
                                      getC.update(['dataList']);
                                    }
                                  },
                                  onSubmit: (val) {
                                    String txt = val;
                                    if (txt.isEmpty) {
                                      getC.searchTrigger = false;
                                      getC.update();
                                    } else {
                                      getC.searchText = txt;
                                      getC.update();
                                    }
                                  }),
                              SizedBox(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: RadioListTile(
                                            value: 0,
                                            groupValue: getC.radioGroupValue,
                                            onChanged: (value) {
                                              getC.radioOnChanged(value!);
                                              getC.update();
                                            },
                                            title: const Text('All'),
                                            dense: true,
                                          )),
                                      Expanded(
                                          child: RadioListTile(
                                            value: 1,
                                            groupValue: getC.radioGroupValue,
                                            onChanged: (value) {
                                              getC.radioOnChanged(value!);
                                              getC.update();
                                            },
                                            title: const Text('Pending'),
                                            dense: true,
                                          )),
                                      Expanded(
                                          child: RadioListTile(
                                            value: 2,
                                            groupValue: getC.radioGroupValue,
                                            onChanged: (value) {
                                              getC.radioOnChanged(value!);
                                              getC.update();
                                            },
                                            title: const Text('Accepted'),
                                            dense: true,
                                          )),
                                      Expanded(
                                          child: RadioListTile(
                                            value: 3,
                                            groupValue: getC.radioGroupValue,
                                            onChanged: (value) {
                                              getC.radioOnChanged(value!);
                                              getC.update();
                                            },
                                            title: const Text('On the Way'),
                                            dense: true,
                                          )),
                                      Expanded(
                                          child: RadioListTile(
                                            value: 4,
                                            groupValue: getC.radioGroupValue,
                                            onChanged: (value) {
                                              getC.radioOnChanged(value!);
                                              getC.update();
                                            },
                                            title: const Text('Completed'),
                                            dense: true,
                                          )),
                                    ]),
                              ),
                              GetBuilder(
                                  init: TrackOrdersController(),
                                  id: 'dataList',
                                  builder: (controller) {
                                    return SizedBox(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height -
                                            150.0,
                                        width:
                                        MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount:
                                          snapshot.data?.docs.length,
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0,
                                              horizontal: 40.0),
                                          itemBuilder: (context, index) {
                                            var data = snapshot
                                                .data!.docs[index]
                                                .data()
                                            as Map<String, dynamic>;
                                            if (getC.searchText == "") {
                                              return Card(
                                                elevation: 2.0,
                                                child: ListTile(
                                                  leading: Tooltip(
                                                      message: "Order Number",
                                                      child: Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get(
                                                            'orderNumber')
                                                            .toString(),
                                                      )),
                                                  title: Text(
                                                      snapshot
                                                          .data!.docs[index]
                                                          .get('name'),
                                                      style: const TextStyle(
                                                          fontSize: 16.0),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  subtitle: getC.radioGroupValue == 0
                                                ? Text(
                                                snapshot.data!.docs[index].get('status'),
                                                style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                                : snapshot.data!.docs[index].get('type') == 'labTest' ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                            future: FirebaseFirestore.instance.collection('labTests').doc(snapshot.data!.docs[index].get('ltId')).get(),
                                            builder: (context, labTestSnapshot) {
                                            if (labTestSnapshot.hasError) {
                                            return const Text('Error', style: TextStyle(fontSize: 12.0, color: Colors.red));
                                            } else if(labTestSnapshot.connectionState == ConnectionState.waiting){
                                              return const SizedBox(height: 0.0, width: 0.0,);
                                            } else {
                                            final labTestFee = labTestSnapshot.data!.get('fee');
                                            return Text(
                                            labTestFee.toString(),
                                            style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                            overflow: TextOverflow.ellipsis,
                                            );
                                            }
                                            },
                                            ) : Text(
                                                    snapshot.data!.docs[index].get('totalAmount').toString(),
                                                    style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                            trailing: snapshot.data!
                                                      .docs[index]
                                                      .get('type') == 'medicine' ? Tooltip(
                                                message: 'Order Type: Medicine',
                                                child: Image.asset("assets/images/Capsule.png", width: 24.0, height: 24.0))
                                                  : snapshot.data!
                                                      .docs[index]
                                                      .get('type') == 'labTest' ? Tooltip(
                                                message: 'Order Type: Lab Test',
                                                child: Image.asset("assets/images/labIcon.png", width: 24.0, height: 24.0))
                                                  : Tooltip(
                                                message: 'Order Type: Home Service',
                                                child: Image.asset("assets/images/homeService.png", width: 24.0, height: 24.0)),
                                                  dense: true,
                                                  onTap: () {
                                                    Get.to(() =>
                                                        OrderDetailsScreen(
                                                          orderID: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id,
                                                          orderType: snapshot.data!.docs[index].get('type'),
                                                        ));
                                                  },
                                                ),
                                              );
                                            } else if (data['name']
                                                .toString()
                                                .toLowerCase()
                                                .startsWith(
                                                getC.searchText)) {
                                              return Card(
                                                elevation: 2.0,
                                                child: ListTile(
                                                  leading: Tooltip(
                                                      message: "Order Number",
                                                      child: Text(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get(
                                                            'orderNumber')
                                                            .toString(),
                                                      )),
                                                  title: Text(
                                                      snapshot
                                                          .data!.docs[index]
                                                          .get('name'),
                                                      style: const TextStyle(
                                                          fontSize: 16.0),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  subtitle: getC.radioGroupValue == 0
                                                      ? Text(
                                                    snapshot.data!.docs[index].get('status'),
                                                    style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                      : snapshot.data!.docs[index].get('type') == 'labTest' ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                    future: FirebaseFirestore.instance.collection('labTests').doc(snapshot.data!.docs[index].get('ltId')).get(),
                                                    builder: (context, labTestSnapshot) {
                                                      if (labTestSnapshot.hasError) {
                                                        return const Text('Error', style: TextStyle(fontSize: 12.0, color: Colors.red));
                                                      } else if(labTestSnapshot.connectionState == ConnectionState.waiting){
                                                        return const SizedBox(height: 0.0, width: 0.0,);
                                                      } else {
                                                        final labTestFee = labTestSnapshot.data!.get('fee');
                                                        return Text(
                                                          labTestFee.toString(),
                                                          style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                                          overflow: TextOverflow.ellipsis,
                                                        );
                                                      }
                                                    },
                                                  ) : Text(
                                                    snapshot.data!.docs[index].get('totalAmount').toString(),
                                                    style: const TextStyle(fontSize: 12.0, color: kPrimarySwatch),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  trailing: snapshot.data!
                                                      .docs[index]
                                                      .get('type') == 'medicine' ? Tooltip(
                                                      message: 'Order Type: Medicine',
                                                      child: Image.asset("assets/images/Capsule.png", width: 24.0, height: 24.0))
                                                      : snapshot.data!
                                                      .docs[index]
                                                      .get('type') == 'labTest' ? Tooltip(
                                                      message: 'Order Type: Lab Test',
                                                      child: Image.asset("assets/images/labIcon.png", width: 24.0, height: 24.0))
                                                      : Tooltip(
                                                      message: 'Order Type: Home Service',
                                                      child: Image.asset("assets/images/homeService.png", width: 24.0, height: 24.0)),
                                                  dense: true,
                                                  onTap: () {
                                                    Get.to(() =>
                                                        OrderDetailsScreen(
                                                          orderID: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id,
                                                          orderType: snapshot.data!.docs[index].get('type'),
                                                        ));
                                                  },
                                                ),
                                              );
                                            }
                                            return null;
                                          },
                                        ));
                                  })
                            ],
                          );
                        }
                      },
                    );
                  }
                })));
  }
}