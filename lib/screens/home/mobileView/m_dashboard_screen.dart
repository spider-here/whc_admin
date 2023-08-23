import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/constants.dart';
import '../../../utils/custom_widgets.dart';
import '../../detailsScreens/doctor_details_screen.dart';
import '../../detailsScreens/order_details_screen.dart';

class MDashboardScreen extends StatelessWidget{

  final CustomWidgets _widgets = CustomWidgets();

  MDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: MediaQuery.of(context).size.width/1.15,
                  height: MediaQuery.of(context).size.height/2.4,
                  child: Column(
                    children: [
                      _widgets.dashItemHead(headingText: "Orders - Medicine", image: Image.asset("assets/images/Capsule.png", height: 50.0, width: 50.0,)),
                      Container(
                        height: MediaQuery.of(context).size.height/3.05,
                        width: MediaQuery.of(context).size.width/1.15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                        ),
                        child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                          stream: FirebaseFirestore.instance.collection('orders').where('type', isEqualTo: 'medicine')
                              .where('status', isNotEqualTo: 'completed').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                              return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2.0,
                                    child: ListTile(
                                      leading: Tooltip(
                                          message: "Order Number",
                                          child: Text(snapshot.data!.docs[index].get('orderNumber').toString())),
                                      title: Text(snapshot.data!.docs[index].get('name'),style: const TextStyle(fontSize: 16.0),),
                                      subtitle: Text(snapshot.data!.docs[index].get('addressDescription') ,style: const TextStyle(fontSize: 14.0),),
                                      trailing: Text(snapshot.data!.docs[index].get('status'),
                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimarySwatch),),
                                      dense: true,
                                      onTap: (){Get.to(()=>OrderDetailsScreen(orderID: snapshot.data!.docs[index].id, orderType: snapshot.data!.docs[index].get('type')));},
                                    ),
                                  );
                                },
                              );
                            }else if(snapshot.data?.size == 0){
                              return const Center(
                                child: Text("No new orders.", style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),),
                              );
                            }else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),),
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: MediaQuery.of(context).size.width/1.15,
                  height: MediaQuery.of(context).size.height/2.4,
                  child: Column(
                    children: [
                      _widgets.dashItemHead(headingText: "Pending Approvals - Doctors", image: Image.asset("assets/images/maleDoctor.png", height: 35.0, width: 35.0,)),
                      Container(
                        height: MediaQuery.of(context).size.height/3.05,
                        width: MediaQuery.of(context).size.width/1.15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                        ),
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                          stream: FirebaseFirestore.instance.collection('doctors').where("isApproved", isEqualTo: false).snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                              return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2.0,
                                    child: ListTile(
                                      leading: CircleAvatar(foregroundImage: NetworkImage(snapshot.data!.docs[index].get('image').toString())),
                                      title: Text(snapshot.data!.docs[index].get('name').toString(),style: const TextStyle(fontSize: 16.0),),
                                      subtitle: Text(snapshot.data!.docs[index].get('speciality').toString(),style: const TextStyle(fontSize: 14.0),),
                                      trailing: snapshot.data!.docs[index].get('isMale') == true?
                                      const Icon(Icons.male, color: Colors.blue,) : const Icon(Icons.female, color: Colors.pinkAccent,),
                                      dense: true,
                                      onTap: (){Get.to(()=>DoctorDetailsScreen(doctorID: snapshot.data!.docs[index].id,));},
                                    ),
                                  );
                                },
                              );
                            }else if(snapshot.data?.size == 0){
                              return const Center(
                                child: Text("No pending approvals.", style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),),
                              );
                            }else if (snapshot.hasError) {
                              return const Text('Error');
                            }
                            else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),),
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: MediaQuery.of(context).size.width/1.15,
                  height: MediaQuery.of(context).size.height/2.4,
                  child: Column(
                    children: [
                      _widgets.dashItemHead(headingText: "Bookings - Lab Tests", image: Image.asset("assets/images/labIcon.png", height: 35.0, width: 35.0,)),
                      Container(
                        height: MediaQuery.of(context).size.height/3.05,
                        width: MediaQuery.of(context).size.width/1.15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                        ),
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance.collection('orders')
                              .where("type", isEqualTo: "labTest")
                              .where('status', isNotEqualTo: 'completed')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData && snapshot.data != null) {
                              final orders = snapshot.data!.docs;
                              if (orders.isEmpty) {
                                return const Center(
                                  child: Text("No new bookings.",
                                    style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemCount: orders.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final order = orders[index];
                                  final labType = order.get('labType');

                                  return Card(
                                    elevation: 2.0,
                                    child: ListTile(
                                      leading: Tooltip(
                                        message: "Order Number",
                                        child: Text(order.get('orderNumber').toString()),
                                      ),
                                      title: Text(order.get('name'), style: const TextStyle(fontSize: 16.0)),
                                      subtitle: labType == 'inLab'
                                          ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                        future: FirebaseFirestore.instance.collection('labs').doc(order.get('lId')).get(),
                                        builder: (context, labSnapshot) {
                                          if (labSnapshot.hasError) {
                                            return const Text('Error');
                                          } else if (labSnapshot.hasData) {
                                            final labName = labSnapshot.data!.get('name');
                                            return Text(labName.toString(), style: const TextStyle(fontSize: 14.0));
                                          } else {
                                            return const Text('Lab not found');
                                          }
                                        },
                                      )
                                          : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                        future: FirebaseFirestore.instance.collection('users').doc(order.get('uid')).get(),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.hasError) {
                                            return const Text('Error');
                                          } else if (userSnapshot.hasData) {
                                            final address = userSnapshot.data!.get('lastDeliveryAddressDescription');
                                            return Text(address, style: const TextStyle(fontSize: 14.0));
                                          } else {
                                            return const Text('Address not found');
                                          }
                                        },
                                      ),
                                      trailing: Text(order.get('status'),
                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimarySwatch),
                                      ),
                                      dense: true,
                                      onTap: () {
                                        Get.to(() => OrderDetailsScreen(orderID: order.id, orderType: order.get('type')));
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),

                      )
                    ],
                  ),
                ),),
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: MediaQuery.of(context).size.width/1.15,
                  height: MediaQuery.of(context).size.height/2.4,
                  child: Column(
                    children: [
                      _widgets.dashItemHead(headingText: "Bookings - Home Services", image: Image.asset("assets/images/homeService.png", height: 35.0, width: 35.0,)),
                      Container(
                        height: MediaQuery.of(context).size.height/3.05,
                        width: MediaQuery.of(context).size.width/1.15,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                        ),
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                          stream: FirebaseFirestore.instance.collection('orders').where("type", isEqualTo: "homeService")
                              .where('status', isNotEqualTo: 'completed').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                              return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 2.0,
                                    child: ListTile(
                                      leading: Tooltip(
                                          message: "Order Number",
                                          child: Text(snapshot.data!.docs[index].get('orderNumber').toString(),)),
                                      title: Text(snapshot.data!.docs[index].get('title'),style: const TextStyle(fontSize: 16.0),),
                                      subtitle: Text(snapshot.data!.docs[index].get('addressDescription'),style: const TextStyle(fontSize: 14.0),),
                                      trailing: Text(snapshot.data!.docs[index].get('status'),
                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimarySwatch),),
                                      dense: true,
                                      onTap: (){Get.to(()=>OrderDetailsScreen(orderID: snapshot.data!.docs[index].id, orderType: snapshot.data!.docs[index].get('type')));},
                                    ),
                                  );
                                },
                              );
                            }else if(snapshot.data?.size == 0){
                              return const Center(
                                child: Text("No new bookings.", style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),),
                              );
                            }else if (snapshot.hasError) {
                              return const Text('Error');
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),),
            ],
          ),
        ),
      ),
    );
  }

}