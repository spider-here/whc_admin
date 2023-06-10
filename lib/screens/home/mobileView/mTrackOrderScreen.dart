import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/trackOrdersController.dart';
import '../../../utils/constants.dart';
import '../../detailsScreens/orderDetailsScreen.dart';

class mTrackOrderScreen extends StatelessWidget {

  const mTrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: trackOrdersController(),
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
                            init: trackOrdersController(),
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
                                                  snapshot.data!.docs[index]
                                                      .get('orderNumber')
                                                      .toString(),
                                                )),
                                            title: Text(
                                              snapshot.data!.docs[index]
                                                  .get('name'),
                                              style: const TextStyle(fontSize: 16.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                                snapshot.data!.docs[index]
                                                    .get('title'),
                                                style:
                                                    const TextStyle(fontSize: 14.0),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            trailing: Text(
                                                getC.radioGroupValue == 0
                                                    ? snapshot.data!.docs[index]
                                                        .get('status')
                                                    : snapshot.data!.docs[index]
                                                        .get('totalAmount')
                                                        .toString(),
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimarySwatch),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            dense: true,
                                            onTap: () {
                                              Get.to(() => orderDetailsScreen(
                                                    orderID: snapshot
                                                        .data!.docs[index].id,
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
