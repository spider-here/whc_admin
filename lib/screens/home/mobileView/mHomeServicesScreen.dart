import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/customWidgets.dart';
import '../../addScreens/addServiceScreen.dart';

class mHomeServicessScreen extends StatelessWidget{

  final customWidgets _widgets = customWidgets();

  mHomeServicessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: "Add new home service",
        child: FloatingActionButton(
          onPressed: () { Get.to(()=>addServiceScreen()); },
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
                .collection('nursing')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              }
              else {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 50.0,),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0),
                            itemBuilder: (context, index) {
                              return _widgets.productCardMobile(
                                  title: snapshot.data!.docs[index]
                                      .get('title')
                                      .toString(),
                                  info1: snapshot.data!.docs[index].get(
                                      'hospital').toString(),
                                  imageUrl: snapshot.data!.docs[index].get(
                                      'image').toString(),
                                  info2: "",
                                  info3: snapshot.data!.docs[index]
                                      .get('fee')
                                      .toString(),
                                  context: context,
                                  onPressed: () {
                                    Get.to(()=>addServiceScreen.edit(edit: true,
                                        id: snapshot.data!.docs[index]
                                            .get('nId')
                                            .toString(), title: snapshot.data!.docs[index]
                                            .get('title')
                                            .toString(), imageUrl: snapshot.data!.docs[index]
                                        .get('image')
                                        .toString(),
                                        hospital: snapshot.data!.docs[index]
                                            .get('hospital')
                                            .toString(), fee: snapshot.data!.docs[index]
                                            .get('fee')
                                            .toString(), facilities: snapshot.data!.docs[index]
                                          .get('facilities')
                                          .toString()));
                                  },
                                  isDoctor: false);
                            }),
                      )
                    ]
                );
              }
            }),
      ),
    );
  }

}