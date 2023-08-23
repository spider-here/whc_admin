import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/track_orders_controller.dart';
import '../../../utils/constants.dart';
import '../../detailsScreens/order_details_screen.dart';

class MTrackOrderScreen extends StatelessWidget {

  const MTrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: TrackOrdersController(),
            builder: (getC) {
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
                                .where('status', isEqualTo: "onTheWay")
                                .snapshots()
                            : getC.radioGroupValue == 4
                                ? FirebaseFirestore.instance
                                    .collection('orders')
                                    .where('status', isEqualTo: "completed")
                                    .snapshots()
                                : FirebaseFirestore.instance
                                    .collection('orders')
                                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 2.0,
                          child: Container(
                            height: 50.0,
                            width: 200.0,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  items: [
                                    DropdownMenuItem(
                                      value: 0,
                                      child: Text(getC.filterText[0]),
                                    ),
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text(getC.filterText[1]),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text(getC.filterText[2]),
                                    ),
                                    DropdownMenuItem(
                                      value: 3,
                                      child: Text(getC.filterText[3]),
                                    ),
                                    DropdownMenuItem(
                                      value: 4,
                                      child: Text(getC.filterText[4]),
                                    ),
                                  ],
                                  focusColor: Colors.transparent,
                                  hint: Text(
                                      getC.filterText[getC.radioGroupValue]),
                                  isDense: true,
                                  onChanged: (val) {
                                    getC.radioOnChanged(val!);
                                    getC.update();
                                  }),
                            ),
                          ),
                        ),
                        GetBuilder(
                            init: TrackOrdersController(),
                            builder: (controller) {
                              return SizedBox(
                                  height: MediaQuery.of(context).size.height -
                                      200.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 24.0),
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
                                                return Text('Error', style: const TextStyle(fontSize: 12.0, color: Colors.red));
                                              } else if(labTestSnapshot.connectionState == ConnectionState.waiting){
                                                return SizedBox(height: 0.0, width: 0.0,);
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
                                    },
                                  ));
                            })
                      ],
                    );
                  }
                },
              );
            }));
  }
}
