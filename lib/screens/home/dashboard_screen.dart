import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/dashboard/dash_cat_list_item.dart';
import 'package:whc_admin/models/doctors_model.dart';
import '../../custom_widgets/dashboard/dash_item_head.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../database/database.dart';
import '../../utils/constants.dart';
import '../detailsScreens/doctor_details_screen.dart';
import '../detailsScreens/order_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Database db = Database();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
          constraints.maxWidth <= 600.0;
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: isMobile
              ? [
                  Container(
                    width: constraints.maxWidth / 1.15,
                    height: constraints.maxHeight / 2.4,
                    decoration:
                        BoxDecoration(border: Border.all(color: kGreyOutline)),
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        DashItemHead(
                            headingText: "Orders - Medicine",
                            image: Image.asset(
                              "assets/images/Capsule.png",
                              height: 50.0,
                              width: 50.0,
                            )),
                        SizedBox(
                            height: constraints.maxHeight / 3.05,
                            width: constraints.maxWidth / 1.15,
                            child: const PendingOrdersStreamWidget())
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth / 1.15,
                    height: constraints.maxHeight / 2.4,
                    decoration:
                        BoxDecoration(border: Border.all(color: kGreyOutline)),
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        DashItemHead(
                            headingText: "Bookings - Lab Tests",
                            image: Image.asset(
                              "assets/images/labIcon.png",
                              height: 35.0,
                              width: 35.0,
                            )),
                        SizedBox(
                            height: constraints.maxHeight / 3.05,
                            width: constraints.maxWidth / 1.15,
                            child: const PendingLabTestsStreamWidget())
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth / 1.15,
                    height: constraints.maxHeight / 2.4,
                    decoration:
                        BoxDecoration(border: Border.all(color: kGreyOutline)),
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        DashItemHead(
                            headingText: "Bookings - Home Services",
                            image: Image.asset(
                              "assets/images/homeService.png",
                              height: 35.0,
                              width: 35.0,
                            )),
                        SizedBox(
                            height: constraints.maxHeight / 3.05,
                            width: constraints.maxWidth / 1.15,
                            child: const PendingHomeServicesStreamWidget())
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth / 1.15,
                    height: constraints.maxHeight / 2.4,
                    decoration:
                        BoxDecoration(border: Border.all(color: kGreyOutline)),
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        DashItemHead(
                            headingText: "Pending Approvals - Doctors",
                            image: Image.asset(
                              "assets/images/maleDoctor.png",
                              height: 35.0,
                              width: 35.0,
                            )),
                        SizedBox(
                            height: constraints.maxHeight / 3.05,
                            width: constraints.maxWidth / 1.15,
                            child: const PendingDoctorsStreamWidget())
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40.0))
                ]
              : [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 60.0, 60.0, 20.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            height: constraints.maxHeight / 1.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreyOutline)),
                            child: Column(
                              children: [
                                DashItemHead(
                                    headingText: "Orders - Medicine",
                                    image: Image.asset(
                                      "assets/images/Capsule.png",
                                      height: 35.0,
                                      width: 35.0,
                                    )),
                                SizedBox(
                                    height: constraints.maxHeight / 2.1,
                                    child: const PendingOrdersStreamWidget())
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 35.0),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: constraints.maxHeight / 1.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreyOutline)),
                            child: Column(
                              children: [
                                DashItemHead(
                                    headingText: "Pending Approvals - Doctors",
                                    image: Image.asset(
                                      "assets/images/maleDoctor.png",
                                      height: 35.0,
                                      width: 35.0,
                                    )),
                                SizedBox(
                                    height: constraints.maxHeight / 2.1,
                                    child: const PendingDoctorsStreamWidget())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 20.0, 60.0, 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            // width: constraints.maxWidth / 2.5,
                            height: constraints.maxHeight / 1.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreyOutline)),
                            child: Column(
                              children: [
                                DashItemHead(
                                    headingText: "Bookings - Lab Tests",
                                    image: Image.asset(
                                      "assets/images/labIcon.png",
                                      height: 35.0,
                                      width: 35.0,
                                    )),
                                SizedBox(
                                    height: constraints.maxHeight / 2.1,
                                    child: const PendingLabTestsStreamWidget())
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 35.0),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            // width: constraints.maxWidth / 2.5,
                            height: constraints.maxHeight / 1.8,
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreyOutline)),
                            child: Column(
                              children: [
                                DashItemHead(
                                    headingText: "Bookings - Home Services",
                                    image: Image.asset(
                                      "assets/images/homeService.png",
                                      height: 35.0,
                                      width: 35.0,
                                    )),
                                SizedBox(
                                    height: constraints.maxHeight / 2.1,
                                    child:
                                        const PendingHomeServicesStreamWidget())
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
        ),
      );
    });
  }
}

class PendingOrdersStreamWidget extends StatelessWidget {
  const PendingOrdersStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where("type", isEqualTo: "medicine")
          .where('status', isNotEqualTo: 'completed')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data?.size != 0) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String orderNumber =
                  snapshot.data?.docs[index].get('orderNumber').toString() ??
                      '';
              String name = snapshot.data?.docs[index].get('name') ?? '';
              String addressDescription =
                  snapshot.data?.docs[index].get('addressDescription') ?? '';
              String status = snapshot.data?.docs[index].get('status') ?? '';
              return DashCatListItem(
                  leadingWidget: Tooltip(
                      message: "Order Number", child: Text(orderNumber)),
                  titleText: name,
                  subTitleText: addressDescription,
                  trailingWidget: Text(
                    status,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimarySwatch),
                  ),
                  onClick: () {
                    Get.to(() => OrderDetailsScreen(
                        orderID: snapshot.data!.docs[index].id,
                        orderType: snapshot.data!.docs[index].get('type')));
                  });
            },
          );
        } else if (snapshot.data?.size == 0) {
          return const Center(
            child: Text(
              "No new orders.",
              style: TextStyle(
                  fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return const ProgressBar(full: true,);
        }
      },
    );
  }
}

class PendingLabTestsStreamWidget extends StatelessWidget {
  const PendingLabTestsStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where("type", isEqualTo: "labTest")
          .where('status', isNotEqualTo: 'completed')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressBar(full: true,);
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.hasData && snapshot.data != null) {
          final orders = snapshot.data!.docs;
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No new bookings.",
                style: TextStyle(
                    fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),
              ),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final QueryDocumentSnapshot<Map<String, dynamic>> order =
                  orders[index];
              final String labType = order.get('labType') ?? '';
              final String name = order.get('name') ?? 'Name not mentioned.';
              final String status = order.get('status') ?? '';
              final String type = order.get('type') ?? '';
              final String orderNumber = order.get('orderNumber').toString();

              if (labType == 'inLab') {
                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('labs')
                      .doc(order.get('lId'))
                      .get(),
                  builder: (context, labSnapshot) {
                    if (labSnapshot.hasError) {
                      return DashCatListItem(
                          leadingWidget: const SizedBox(),
                          titleText: 'Error',
                          subTitleText: 'Data not found.',
                          trailingWidget: const SizedBox(),
                          onClick: () {});
                    } else if (labSnapshot.hasData) {
                      final String labName = labSnapshot.data?.get('name') ??
                          'Lab name not found.';
                      return DashCatListItem(
                          leadingWidget: Tooltip(
                            message: "Order Number",
                            child: Text(orderNumber),
                          ),
                          titleText: name,
                          subTitleText: labName.toString(),
                          trailingWidget: Text(
                            status,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimarySwatch),
                          ),
                          onClick: () {
                            Get.to(() => OrderDetailsScreen(
                                orderID: order.id, orderType: type));
                          });
                    } else {
                      return DashCatListItem(
                          leadingWidget: Tooltip(
                            message: "Order Number",
                            child: Text(orderNumber),
                          ),
                          titleText: name,
                          subTitleText: 'Lab name not found.',
                          trailingWidget: Text(
                            status,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimarySwatch),
                          ),
                          onClick: () {
                            Get.to(() => OrderDetailsScreen(
                                orderID: order.id, orderType: status));
                          });
                    }
                  },
                );
              } else {
                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(order.get('uid'))
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasError) {
                      return DashCatListItem(
                          leadingWidget: const SizedBox(),
                          titleText: 'Error',
                          subTitleText: 'Data not found.',
                          trailingWidget: const SizedBox(),
                          onClick: () {});
                    } else if (userSnapshot.hasData) {
                      final address = userSnapshot.data
                              ?.get('lastDeliveryAddressDescription') ??
                          'Address description not found.';
                      return DashCatListItem(
                          leadingWidget: Tooltip(
                            message: "Order Number",
                            child: Text(orderNumber),
                          ),
                          titleText: name,
                          subTitleText: address,
                          trailingWidget: Text(
                            status,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimarySwatch),
                          ),
                          onClick: () {
                            Get.to(() => OrderDetailsScreen(
                                orderID: order.id, orderType: type));
                          });
                    } else {
                      return DashCatListItem(
                          leadingWidget: Tooltip(
                            message: "Order Number",
                            child: Text(orderNumber),
                          ),
                          titleText: name,
                          subTitleText: 'Address not found.',
                          trailingWidget: Text(
                            status,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: kPrimarySwatch),
                          ),
                          onClick: () {
                            Get.to(() => OrderDetailsScreen(
                                orderID: order.id, orderType: type));
                          });
                    }
                  },
                );
              }
            },
          );
        } else {
          return const ProgressBar(full: true,);
        }
      },
    );
  }
}

class PendingHomeServicesStreamWidget extends StatelessWidget {
  const PendingHomeServicesStreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where("type", isEqualTo: "homeService")
          .where("status", isNotEqualTo: 'completed')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data?.size != 0) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final String addressDescription = snapshot.data?.docs[index].get('addressDescription') ?? '';
              final String status = snapshot.data?.docs[index].get('status') ?? '';
              final String title = snapshot.data?.docs[index].get('title') ?? 'Title not found.';
              final String type = snapshot.data?.docs[index].get('type') ?? '';
              final String id =  snapshot.data!.docs[index].id;
              final String orderNumber = snapshot.data?.docs[index].get('orderNumber').toString() ?? 'null';
              return Card(
                color: kWhite,
                surfaceTintColor: kWhite,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                elevation: 1.0,
                child: ListTile(
                  leading: Tooltip(
                      message: "Order Number",
                      child: Text(
                        orderNumber,
                      )),
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  subtitle: Text(
                    addressDescription,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  trailing: Text(
                    status,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: kPrimarySwatch),
                  ),
                  dense: true,
                  onTap: () {
                    Get.to(() => OrderDetailsScreen(
                        orderID: id,
                        orderType: type));
                  },
                ),
              );
            },
          );
        } else if (snapshot.data?.size == 0) {
          return const Center(
            child: Text(
              "No new bookings.",
              style: TextStyle(
                  fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return const ProgressBar(full: true,);
        }
      },
    );
  }
}

class PendingDoctorsStreamWidget extends StatelessWidget {
  const PendingDoctorsStreamWidget({super.key});

  Stream<List<DoctorsModel>> getUnApprovedDoctors(){
    Query<Map<String, dynamic>> doctorsQuery = FirebaseFirestore.instance
        .collection('doctors').where('isApproved', isNotEqualTo: true);
    return doctorsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return DoctorsModel.fromMap(doc.id, data);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorsModel>>(
      stream: getUnApprovedDoctors(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          List<DoctorsModel> doctorsList = snapshot.data!;
          return ListView.builder(
            itemCount: doctorsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DoctorsModel doctor = doctorsList[index];
              return DashCatListItem(
                  leadingWidget: CircleAvatar(
                      foregroundImage: NetworkImage(
                          doctor.image)),
                  titleText: doctor.name,
                  subTitleText:
                  doctor.speciality,
                  trailingWidget:
                  doctor.isMale == true
                          ? const Icon(
                              Icons.male,
                              color: Colors.blue,
                            )
                          : const Icon(
                              Icons.female,
                              color: Colors.pinkAccent,
                            ),
                  onClick: () {
                    Get.to(() => DoctorDetailsScreen(
                          doctor: doctor,
                        ));
                  });
            },
          );
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No pending approvals.",
              style: TextStyle(
                  fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return const ProgressBar(full: true,);
        }
      },
    );
  }
}
