import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:whc_admin/screens/detailsScreens/doctor_details_screen.dart';

import '../../../utils/custom_widgets.dart';

class MDoctorsScreen extends StatelessWidget{
  final CustomWidgets _widgets = CustomWidgets();

  MDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('doctors').where('isProfileComplete', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                else {
                  return GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 60.0),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.size,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        return _widgets.productCardMobile(
                            context: context,
                            title: snapshot.data!.docs[index]
                                .get('name')
                                .toString(),
                            info1: snapshot.data!.docs[index].get(
                                'speciality').toString(),
                            imageUrl: snapshot.data!.docs[index].get(
                                'image').toString(),
                            info2: 'Rs.${snapshot.data!.docs[index]
                                .get('fee')}',
                            info3: snapshot.data!.docs[index].get(
                                'rating').toString(),
                            onPressed: () {
                              Get.to(()=>DoctorDetailsScreen(doctorID: snapshot.data!.docs[index].id));
                            },
                            isDoctor: true
                        );
                      });
                }
              }),
    );
  }

}