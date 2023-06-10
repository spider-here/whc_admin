import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';
import '../../detailsScreens/doctorDetailsScreen.dart';
import '../../detailsScreens/orderDetailsScreen.dart';

class dDashboardScreen extends StatelessWidget{

  final customWidgets _widgets = customWidgets();
  final database db = database();

  dDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.4,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/1.8,
                      child: Column(
                        children: [
                          _widgets.dashItemHead(headingText: "Orders - Medicine", image: Image.asset("assets/images/Capsule.png", height: 35.0, width: 35.0,)),
                          Container(
                            height: MediaQuery.of(context).size.height/2.1,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                            ),
                            child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                              stream: FirebaseFirestore.instance.collection('orders').where("type", isEqualTo: "medicine").snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                                    elevation: 2.0,
                                                    child: ListTile(
                                                      leading: Tooltip(
                                                        message: "Order Number",
                                                          child: Text(snapshot.data!.docs[index].get('orderNumber').toString())),
                                                      title: Text(snapshot.data!.docs[index].get('title'),style: const TextStyle(fontSize: 16.0),),
                                                      subtitle: Text(snapshot.data!.docs[index].get('address'),style: const TextStyle(fontSize: 14.0),),
                                                      trailing: Text(snapshot.data!.docs[index].get('status'),
                                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimarySwatch),),
                                                      dense: true,
                                                      onTap: (){Get.to(()=>orderDetailsScreen(orderID: snapshot.data!.docs[index].id,));},
                                                    ),
                                                  );
                                    },
                                  );
                                }
                                else if(snapshot.data?.size == 0){
                                  return const Center(
                                    child: Text("No new orders.", style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: kGrey),),
                                  );
                                }
                                else if (snapshot.hasError) {
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
                    width: MediaQuery.of(context).size.width/3.3,
                    height: MediaQuery.of(context).size.height/1.8,
                      child: Column(
                        children: [
                          _widgets.dashItemHead(headingText: "Pending Approvals - Doctors", image: Image.asset("assets/images/maleDoctor.png", height: 35.0, width: 35.0,)),
                          Container(
                            height: MediaQuery.of(context).size.height/2.1,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                            ),
                            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                              stream: FirebaseFirestore.instance.collection('doctors').where("isApproved", isEqualTo: false).snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
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
                                          onTap: (){Get.to(()=>doctorDetailsScreen(doctorID: snapshot.data!.docs[index].id,));},
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

                ],
              ),
              Row(
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
                      width: MediaQuery.of(context).size.width/2.5,
                      height: MediaQuery.of(context).size.height/1.8,
                      child: Column(
                        children: [
                          _widgets.dashItemHead(headingText: "Bookings - Lab Tests", image: Image.asset("assets/images/labIcon.png", height: 35.0, width: 35.0,)),
                          Container(
                            height: MediaQuery.of(context).size.height/2.1,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                            ),
                            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                              stream: FirebaseFirestore.instance.collection('orders').where("type", isEqualTo: "labTest").snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 2.0,
                                        child: ListTile(
                                          leading: Tooltip(
                                              message: "Order Number",
                                              child: Text(snapshot.data!.docs[index].get('orderNumber').toString())),
                                          title: Text(snapshot.data!.docs[index].get('title'),style: const TextStyle(fontSize: 16.0),),
                                          subtitle: Text(snapshot.data!.docs[index].get('address'),style: const TextStyle(fontSize: 14.0),),
                                          trailing: Text(snapshot.data!.docs[index].get('status'),
                                            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kPrimarySwatch),),
                                          dense: true,
                                          onTap: (){Get.to(()=>orderDetailsScreen(orderID: snapshot.data!.docs[index].id,));},
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
                      width: MediaQuery.of(context).size.width/2.5,
                      height: MediaQuery.of(context).size.height/1.8,
                      child: Column(
                        children: [
                          _widgets.dashItemHead(headingText: "Bookings - Home Services", image: Image.asset("assets/images/homeService.png", height: 35.0, width: 35.0,)),
                          Container(
                            height: MediaQuery.of(context).size.height/2.1,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0),)
                            ),
                            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
                              stream: FirebaseFirestore.instance.collection('orders').where("type", isEqualTo: "homeService").where("status", isNotEqualTo: 'Completed').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null && snapshot.data?.size != 0) {
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
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
                                          onTap: (){Get.to(()=>orderDetailsScreen(orderID: snapshot.data!.docs[index].id,));},
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

            ],
          ),
        ),
      ),
    );
  }

}