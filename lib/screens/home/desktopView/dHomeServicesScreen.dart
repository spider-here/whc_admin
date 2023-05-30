import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/customWidgets.dart';
import '../../addScreens/addServiceScreen.dart';

class dHomeServicesScreen extends StatelessWidget {

  final customWidgets _widgets = customWidgets();

  dHomeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Tooltip(
          message: "Add new",
          child: FloatingActionButton(
            onPressed: () {Get.to(()=>const addServiceScreen());},
            child: const Icon(Icons.add),
          ),
        ),
      body: _widgets.pageViewPage(context: context,
          widget: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('nursing')
                  .snapshots(),
              builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator(),);
    }
    else {
      return SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.4,
        child: GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.size,
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0, vertical: 50.0,),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width>1050 ? 5
                    : MediaQuery.of(context).size.width>800 && MediaQuery.of(context).size.width<1050 ? 4 : 3,
                childAspectRatio: 1,
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 24.0),
            itemBuilder: (context, index) {
              return _widgets.productCardMobile(
                  context: context,
                  title: snapshot.data!.docs[index]
                      .get('title')
                      .toString(),
                  info1: snapshot.data!.docs[index]
                      .get('hospital')
                      .toString(),
                  imageUrl: snapshot.data!.docs[index]
                      .get('image')
                      .toString(),
                  info2: snapshot.data!.docs[index]
                      .get('facilities')
                      .toString(),
                  info3: snapshot.data!.docs[index].get('fee').toString(),
                  onPressed: () { }, isDoctor: false,
              );
            }),
      );
    }
              }),)
    );
  }

}