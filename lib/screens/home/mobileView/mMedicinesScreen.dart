import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/customWidgets.dart';
import '../../addScreens/addMedicineScreen.dart';


class mMedicinesScreen extends StatelessWidget{

  final customWidgets _widgets = customWidgets();

  mMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: "Add new medicine",
        child: FloatingActionButton(
          onPressed: () {Get.to(()=>const addMedicineScreen()); },
          child: const Icon(Icons.add),
        ),
      ),
      body: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('medicines')
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
                      .height/1.1,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.size,
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 60.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        return _widgets.productCardMobile(
                            context: context,
                            title: snapshot.data!.docs[index]
                                .get('name')
                                .toString(),
                            info1: snapshot.data!.docs[index].get(
                                'strength').toString(),
                            imageUrl: snapshot.data!.docs[index].get(
                                'image').toString(),
                            info2: snapshot.data!.docs[index]
                                .get('soldOut') == true ? 'Out of Stock' : '',
                            info3: 'Rs.${snapshot.data!.docs[index].get(
                                'pricePerPack')}',
                            onPressed: () {},
                            isDoctor: false
                        );
                      }
                      ),
                );
              }
            }),
      ),
    );
  }
}
