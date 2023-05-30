import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/screens/addScreens/addMedicineScreen.dart';

import '../../../controllers/generalSearchController.dart';
import '../../../utils/customWidgets.dart';

class dMedicinesScreen extends StatelessWidget {
  final customWidgets _widgets = customWidgets();

  dMedicinesScreen({super.key});

  final TextEditingController _searchFieldC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Tooltip(
          message: "Add new",
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const addMedicineScreen());
            },
            child: const Icon(Icons.add),
          ),
        ),
        body: _widgets.pageViewPage(
            context: context,
            widget: GetBuilder(
                init: generalSearchController(),
                builder: (controller) {
                  if (controller.searchTrigger == true) {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('medicines').where(
                            'name', isEqualTo: controller.searchText)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
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
                                        primary: true,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 85.0,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data!.size,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1.0,
                                            mainAxisSpacing: 18.0,
                                            crossAxisSpacing: 18.0),
                                        itemBuilder: (context, index) {
                                          return _widgets
                                                .productCardMobile(
                                                context: context,
                                                title: snapshot.data!
                                                    .docs[index]
                                                    .get('name')
                                                    .toString(),
                                                info1: snapshot.data!
                                                    .docs[index]
                                                    .get('strength')
                                                    .toString(),
                                                imageUrl: snapshot.data!
                                                    .docs[index]
                                                    .get('image')
                                                    .toString(),
                                                info2: snapshot.data!
                                                    .docs[index]
                                                    .get('soldOut') ==
                                                    true
                                                    ? 'Out of Stock'
                                                    : '',
                                                info3:
                                                'Rs.${snapshot.data!
                                                    .docs[index].get(
                                                    'pricePerPack')}',
                                                onPressed: () {},
                                                isDoctor: false);
                                        })
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
                  else {
                    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('medicines')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
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
                                    child: GetBuilder(
                                      id: 'allDataGrid',
                                      init: generalSearchController(),
                                      builder: (controller) {
                                        return GridView.builder(
                                            shrinkWrap: true,
                                            primary: true,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                              vertical: 85.0,
                                            ),
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data!.size,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width >
                                                    1300
                                                    ? 6
                                                    : MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width <
                                                    1300 &&
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width >
                                                        1050
                                                    ? 5
                                                    : MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width <
                                                    1050 &&
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width >
                                                        800
                                                    ? 4
                                                    : 3,
                                                childAspectRatio: 1.0,
                                                mainAxisSpacing: 18.0,
                                                crossAxisSpacing: 18.0),
                                            itemBuilder: (context, index) {
                                              var data = snapshot.data!
                                                  .docs[index].data()
                                              as Map<String, dynamic>;
                                              if (_searchFieldC.text == "") {
                                                // controller.gridItemCount = snapshot.data!.size;
                                                // controller.update(['dataList']);
                                                return _widgets
                                                    .productCardMobile(
                                                    context: context,
                                                    title: snapshot.data!
                                                        .docs[index]
                                                        .get('name')
                                                        .toString(),
                                                    info1: snapshot.data!
                                                        .docs[index]
                                                        .get('strength')
                                                        .toString(),
                                                    imageUrl: snapshot.data!
                                                        .docs[index]
                                                        .get('image')
                                                        .toString(),
                                                    info2: snapshot.data!
                                                        .docs[index]
                                                        .get('soldOut') ==
                                                        true
                                                        ? 'Out of Stock'
                                                        : '',
                                                    info3:
                                                    'Rs.${snapshot.data!
                                                        .docs[index].get(
                                                        'pricePerPack')}',
                                                    onPressed: () {},
                                                    isDoctor: false);
                                              } else if (data['name']
                                                  .toString()
                                                  .toLowerCase()
                                                  .startsWith(
                                                  _searchFieldC.text)) {
                                                // controller.gridItemCount = 0;
                                                // controller.gridItemCount++;
                                                // // controller.update(['dataList']);
                                                return _widgets
                                                    .productCardMobile(
                                                    context: context,
                                                    title: snapshot.data!
                                                        .docs[index]
                                                        .get('name')
                                                        .toString(),
                                                    info1: snapshot.data!
                                                        .docs[index]
                                                        .get('strength')
                                                        .toString(),
                                                    imageUrl: snapshot.data!
                                                        .docs[index]
                                                        .get('image')
                                                        .toString(),
                                                    info2: snapshot.data!
                                                        .docs[index]
                                                        .get('soldOut') ==
                                                        true
                                                        ? 'Out of Stock'
                                                        : '',
                                                    info3:
                                                    'Rs.${snapshot.data!
                                                        .docs[index].get(
                                                        'pricePerPack')}',
                                                    onPressed: () {},
                                                    isDoctor: false);
                                              }
                                              else {
                                                return null;
                                              }
                                            });
                                      }
                                    )
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
                })

        ));
  }
}
