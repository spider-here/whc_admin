import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/utils/extensions.dart';

import '../../../controllers/generalSearchController.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';
import '../../addScreens/addLabScreen.dart';
import '../../addScreens/addLabTestScreen.dart';

class dLabTestsScreen extends StatelessWidget {

  final customWidgets _widgets = customWidgets();
  int _tabCurrentIndex = 0;
  final TextEditingController _searchFieldC = TextEditingController();

  dLabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
        floatingActionButton: Tooltip(
          message: "Add new",
          child: FloatingActionButton(
            onPressed: () {
              if (_tabCurrentIndex == 0) {
                Get.to(() => addLabTestScreen());
              }
              else {
                Get.to(() => addLabScreen());
              }
            },
            child: const Icon(Icons.add),
          ),
        ),
        body: _widgets.pageViewPage(context: context,
          widget: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0),
                elevation: 2.0,
                child: SizedBox(
                  height: 50.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: kPrimarySwatch,
                    unselectedLabelColor: kBlack,
                    labelColor: kPrimarySwatch,
                    onTap: (index) {
                      _tabCurrentIndex = index;
                    },
                    tabs: const [
                      Tab(
                        text: "Lab Tests",
                      ),
                      Tab(
                        text: "Labs",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 60.0,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: TabBarView(
                  children: [
                    GetBuilder(
                        init: generalSearchController(),
                        builder: (controller) {
                          if (controller.searchTrigger == true) {
                            return StreamBuilder<QuerySnapshot<
                                Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('labTests').where(
                                    'name', whereIn: [controller.searchText.trim().toUpperCase(),
                                  controller.searchText.trim().toLowerCase(), controller.searchText.trim().camelCase,
                                controller.searchText.trim().capitalizeFirst,  controller.searchText.trim().capitalizeByWord()])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),);
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
                                      child: Stack(
                                        children: [
                                          snapshot.data!.size != 0
                                              ? GridView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 24.0,
                                                vertical: 85.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data?.size,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width > 1300
                                                      ? 6
                                                      : MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1300 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 1000 ? 5 :
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1000 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 800 ? 4 : 3,
                                                  childAspectRatio: 2 / 1.6,
                                                  mainAxisSpacing: 10.0,
                                                  crossAxisSpacing: 10.0),
                                              itemBuilder: (context, index) {
                                                return _widgets.labTestCard(
                                                  context: context,
                                                  title: snapshot.data!
                                                      .docs[index]
                                                      .get('name')
                                                      .toString(),
                                                  info1: snapshot.data!
                                                      .docs[index].get(
                                                      'sampleType').toString(),
                                                  info2: snapshot.data!
                                                      .docs[index]
                                                      .get('type').toString(),
                                                  info3: snapshot.data!
                                                      .docs[index].get(
                                                      'fee').toString(),
                                                  onPressed: () async {
                                                    final QuerySnapshot result =
                                                    await FirebaseFirestore
                                                        .instance.collection(
                                                        'labTests').doc(snapshot
                                                        .data!.docs[index]
                                                        .get('ltId'))
                                                        .collection('labs')
                                                        .get();
                                                    final List<
                                                        DocumentSnapshot> labsInLabTest = result
                                                        .docs;
                                                    Get.to(() =>
                                                        addLabTestScreen.edit(
                                                          edit: true,
                                                          id: snapshot.data!
                                                              .docs[index]
                                                              .get('ltId')
                                                              .toString(),
                                                          testName: snapshot
                                                              .data!.docs[index]
                                                              .get('name')
                                                              .toString(),
                                                          testType: snapshot
                                                              .data!.docs[index]
                                                              .get('type')
                                                              .toString(),
                                                          sampleType: snapshot
                                                              .data!.docs[index]
                                                              .get('sampleType')
                                                              .toString(),
                                                          testFor: snapshot
                                                              .data!.docs[index]
                                                              .get('testFor')
                                                              .toString(),
                                                          fee: snapshot.data!
                                                              .docs[index]
                                                              .get('fee')
                                                              .toString(),
                                                          labsInLabTest: labsInLabTest,));
                                                  },
                                                );
                                              })
                                              : const Center(
                                            child: Text('No record found'),
                                          ),
                                          Align(alignment: FractionalOffset
                                              .topCenter,
                                            child: _widgets.searchBar(
                                              width: 400.0,
                                              controller: _searchFieldC,
                                              onChanged: (val) {
                                                String txt = val;
                                                if (txt.isEmpty) {
                                                  controller.searchTrigger =
                                                  false;
                                                  controller.update();
                                                }
                                              },
                                              onSubmit: (val) {
                                                controller.searchText = val;
                                                controller.searchTrigger = true;
                                                controller.update();
                                              },
                                            ),),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }
                          else {
                            return StreamBuilder<QuerySnapshot<
                                Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('labTests')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),);
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
                                      child: Stack(
                                        children: [
                                          GridView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 24.0,
                                                vertical: 85.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data?.size,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width > 1300
                                                      ? 6
                                                      : MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1300 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 1000 ? 5 :
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1000 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 800 ? 4 : 3,
                                                  childAspectRatio: 2 / 1.6,
                                                  mainAxisSpacing: 10.0,
                                                  crossAxisSpacing: 10.0),
                                              itemBuilder: (context, index) {
                                                var data = snapshot
                                                    .data!.docs[index]
                                                    .data()
                                                as Map<String, dynamic>;
                                                if (_searchFieldC.text == "") {
                                                  return _widgets.labTestCard(
                                                    context: context,
                                                    title: snapshot.data!
                                                        .docs[index]
                                                        .get('name')
                                                        .toString(),
                                                    info1: snapshot.data!
                                                        .docs[index]
                                                        .get(
                                                        'sampleType')
                                                        .toString(),
                                                    info2: snapshot.data!
                                                        .docs[index]
                                                        .get('type').toString(),
                                                    info3: snapshot.data!
                                                        .docs[index].get(
                                                        'fee').toString(),
                                                    onPressed: () async {
                                                      final QuerySnapshot result =
                                                      await FirebaseFirestore
                                                          .instance.collection(
                                                          'labTests').doc(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .get('ltId'))
                                                          .collection('labs')
                                                          .get();
                                                      final List<
                                                          DocumentSnapshot> labsInLabTest = result
                                                          .docs;
                                                      Get.to(() =>
                                                          addLabTestScreen.edit(
                                                            edit: true,
                                                            id: snapshot.data!
                                                                .docs[index]
                                                                .get('ltId')
                                                                .toString(),
                                                            testName: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('name')
                                                                .toString(),
                                                            testType: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('type')
                                                                .toString(),
                                                            sampleType: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get(
                                                                'sampleType')
                                                                .toString(),
                                                            testFor: snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('testFor')
                                                                .toString(),
                                                            fee: snapshot.data!
                                                                .docs[index]
                                                                .get('fee')
                                                                .toString(),
                                                            labsInLabTest: labsInLabTest,));
                                                    },
                                                  );
                                                }
                                                else if (data['name']
                                                    .toString()
                                                    .toLowerCase()
                                                    .startsWith(
                                                    _searchFieldC.text)) {
                                                  return _widgets.labTestCard(
                                                      context: context,
                                                      title: snapshot.data!
                                                          .docs[index]
                                                          .get('name')
                                                          .toString(),
                                                      info1: snapshot.data!
                                                          .docs[index]
                                                          .get(
                                                          'sampleType')
                                                          .toString(),
                                                      info2: snapshot.data!
                                                          .docs[index]
                                                          .get('type')
                                                          .toString(),
                                                      info3: snapshot.data!
                                                          .docs[index].get(
                                                          'fee').toString(),
                                                      onPressed: () async {
                                                        final QuerySnapshot result =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'labTests').doc(
                                                            snapshot
                                                                .data!
                                                                .docs[index]
                                                                .get('ltId'))
                                                            .collection('labs')
                                                            .get();
                                                        final List<
                                                            DocumentSnapshot> labsInLabTest = result
                                                            .docs;
                                                        Get.to(() =>
                                                            addLabTestScreen
                                                                .edit(
                                                              edit: true,
                                                              id: snapshot.data!
                                                                  .docs[index]
                                                                  .get('ltId')
                                                                  .toString(),
                                                              testName: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get('name')
                                                                  .toString(),
                                                              testType: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get('type')
                                                                  .toString(),
                                                              sampleType: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                  'sampleType')
                                                                  .toString(),
                                                              testFor: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                  'testFor')
                                                                  .toString(),
                                                              fee: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get('fee')
                                                                  .toString(),
                                                              labsInLabTest: labsInLabTest,));
                                                      });
                                                }
                                                return null;
                                              }),
                                          Align(alignment: FractionalOffset
                                              .topCenter,
                                            child: _widgets.searchBar(
                                              width: 400.0,
                                              controller: _searchFieldC,
                                              onChanged: (val) {
                                                String txt = val;
                                                if (txt.isEmpty) {
                                                  controller.searchTrigger =
                                                  false;
                                                  controller.update();
                                                }
                                              },
                                              onSubmit: (val) {
                                                controller.searchText = val;
                                                controller.searchTrigger = true;
                                                controller.update();
                                              },
                                            ),),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }
                        }
                    ),

                    GetBuilder(
                        init: generalSearchController(),
                        builder: (controller) {
                          if (controller.searchTrigger == true) {
                            return StreamBuilder<QuerySnapshot<
                                Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('labs').where(
                                    'name', whereIn: [controller.searchText.trim().toUpperCase(),
                                  controller.searchText.trim().toLowerCase(), controller.searchText.trim().camelCase,
                                  controller.searchText.trim().capitalizeFirst, controller.searchText.trim().capitalizeByWord()])
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),);
                                  }
                                  else {
                                    return SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height - 100.0,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.4,
                                      child: Stack(
                                        children: [
                                          GridView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 24.0,
                                                vertical: 85.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data?.size,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width > 1300
                                                      ? 6
                                                      : MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1300 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 1000 ? 5 :
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1000 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 800 ? 4 : 3,
                                                  childAspectRatio: 2 / 1.6,
                                                  mainAxisSpacing: 10.0,
                                                  crossAxisSpacing: 10.0),
                                              itemBuilder: (context, index) {
                                                return _widgets.labTestCard(
                                                  context: context,
                                                  title: snapshot.data!
                                                      .docs[index]
                                                      .get('name')
                                                      .toString(),
                                                  info1: snapshot.data!
                                                      .docs[index]
                                                      .get(
                                                      'address')
                                                      .toString(),
                                                  info2: "",
                                                  info3: snapshot.data!
                                                      .docs[index]
                                                      .get(
                                                      'phoneNumber')
                                                      .toString(),
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        addLabScreen.edit(
                                                          edit: true,
                                                          id: snapshot.data!
                                                              .docs[index]
                                                              .get('lId')
                                                              .toString(),
                                                          labName: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .get('name')
                                                              .toString(),
                                                          address: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .get(
                                                              'address')
                                                              .toString(),
                                                          phoneNumber: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                              'phoneNumber')
                                                              .toString(),)
                                                    );
                                                  },
                                                );
                                              }),
                                          Align(alignment: FractionalOffset
                                              .topCenter,
                                            child: _widgets.searchBar(
                                              width: 400.0,
                                              controller: _searchFieldC,
                                              onChanged: (val) {
                                                String txt = val;
                                                if (txt.isEmpty) {
                                                  controller.searchTrigger =
                                                  false;
                                                  controller.update();
                                                }
                                              },
                                              onSubmit: (val) {
                                                controller.searchText = val;
                                                controller.searchTrigger = true;
                                                controller.update();
                                              },
                                            ),),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }
                          else {
                            return StreamBuilder<QuerySnapshot<
                                Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection('labs')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),);
                                  }
                                  else {
                                    return SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height - 100.0,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.4,
                                      child: Stack(
                                        children: [
                                          GridView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 24.0,
                                                vertical: 85.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data?.size,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width > 1300
                                                      ? 6
                                                      : MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1300 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 1000 ? 5 :
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width < 1000 &&
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width > 800 ? 4 : 3,
                                                  childAspectRatio: 2 / 1.6,
                                                  mainAxisSpacing: 10.0,
                                                  crossAxisSpacing: 10.0),
                                              itemBuilder: (context, index) {
                                                return _widgets.labTestCard(
                                                  context: context,
                                                  title: snapshot.data!
                                                      .docs[index]
                                                      .get('name')
                                                      .toString(),
                                                  info1: snapshot.data!
                                                      .docs[index]
                                                      .get(
                                                      'address')
                                                      .toString(),
                                                  info2: "",
                                                  info3: snapshot.data!
                                                      .docs[index]
                                                      .get(
                                                      'phoneNumber')
                                                      .toString(),
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        addLabScreen.edit(
                                                          edit: true,
                                                          id: snapshot.data!
                                                              .docs[index]
                                                              .get('lId')
                                                              .toString(),
                                                          labName: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .get('name')
                                                              .toString(),
                                                          address: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .get(
                                                              'address')
                                                              .toString(),
                                                          phoneNumber: snapshot
                                                              .data!.docs[index]
                                                              .get(
                                                              'phoneNumber')
                                                              .toString(),)
                                                    );
                                                  },
                                                );
                                              }),
                                          Align(alignment: FractionalOffset
                                              .topCenter,
                                            child: _widgets.searchBar(
                                              width: 400.0,
                                              controller: _searchFieldC,
                                              onChanged: (val) {
                                                String txt = val;
                                                if (txt.isEmpty) {
                                                  controller.searchTrigger =
                                                  false;
                                                  controller.update();
                                                }
                                              },
                                              onSubmit: (val) {
                                                controller.searchText = val;
                                                controller.searchTrigger = true;
                                                controller.update();
                                              },
                                            ),),
                                        ],
                                      ),
                                    );
                                  }
                                });
                          }
                        }
                    ),
                  ],
                ),
              ),

            ],
          ),)
    ));
  }

}