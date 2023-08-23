import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/general_search_controller.dart';
import 'package:whc_admin/utils/extensions.dart';

import '../../../utils/custom_widgets.dart';
import '../../detailsScreens/doctor_details_screen.dart';

class DDoctorsScreen extends StatelessWidget {
  final CustomWidgets _widgets = CustomWidgets();

  DDoctorsScreen({super.key});

  final TextEditingController _searchFieldC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgets.pageViewPage(context: context,
          widget: GetBuilder(
            init: GeneralSearchController(),
            builder: (controller) {
              if(controller.searchTrigger == true){
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('doctors').where('isProfileComplete', isEqualTo: true).where(
                        'name', whereIn: [controller.searchText.trim().toUpperCase(),
                      controller.searchText.trim().toLowerCase(), controller.searchText.trim().camelCase,
                      controller.searchText.trim().capitalizeFirst, controller.searchText.trim().capitalizeByWord()])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      else {
                        return Stack(
                          children: [
                            snapshot.data!.size != 0 ? SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 85.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.size,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1.0,
                                      mainAxisSpacing: 24.0, crossAxisSpacing: 24.0),
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
                                  }),
                            )
                          : const Center(child: Text('No record found'),),
                            Align(
                              alignment: FractionalOffset.topCenter,
                              child: _widgets.searchBar(
                                width: 400.0,
                                controller: _searchFieldC,
                                onChanged: (val) {
                                  String txt = val;
                                  if(txt.isEmpty){
                                    controller.searchTrigger = false;
                                    controller.update();
                                  }
                                },
                                onSubmit: (val) {
                                  controller.searchText = val;
                                  controller.searchTrigger = true;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    });
              }
              else{
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('doctors').where('isProfileComplete', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      else {
                        return Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 85.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.size,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: MediaQuery
                                          .of(context)
                                          .size
                                          .width > 1300 ? 6 : MediaQuery
                                          .of(context)
                                          .size
                                          .width < 1300 &&
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width > 1080 ? 5 :
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width < 1080 && MediaQuery
                                          .of(context)
                                          .size
                                          .width > 800 ? 4 : 3,
                                      childAspectRatio: 1.0,
                                      mainAxisSpacing: 24.0, crossAxisSpacing: 24.0),
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
                                  }),
                            ),
                            Align(
                              alignment: FractionalOffset.topCenter,
                              child: _widgets.searchBar(
                                width: 400.0,
                                controller: _searchFieldC,
                                onChanged: (val) {
                                  String txt = val;
                                  if(txt.isEmpty){
                                    controller.searchTrigger = false;
                                    controller.update(['allDataGrid']);
                                  }
                                  else{
                                    controller.update(['allDataGrid']);
                                  }
                                },
                                onSubmit: (val) {
                                  controller.searchText = val;
                                  controller.searchTrigger = true;
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    });
              }

            }
          ),)
    );
  }

}