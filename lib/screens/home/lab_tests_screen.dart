import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/add_floating_button.dart';
import 'package:whc_admin/custom_widgets/labtests_labs/labs_listview.dart';
import 'package:whc_admin/custom_widgets/labtests_labs/labtests_listview.dart';

import '../../../controllers/app_search_controller.dart';
import '../../custom_widgets/general/page_view_page.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../custom_widgets/labtests_labs/labtests_labs_tablayout.dart';
import '../../models/lab_tests_model.dart';
import '../../models/labs_model.dart';
import '../addScreens/add_lab.dart';
import '../addScreens/add_lab_test_screen.dart';

class LabTestsScreen extends StatelessWidget {

  const LabTestsScreen({super.key});

  Stream<List<LabTestsModel>> getLabTests() {
    Query<Map<String, dynamic>> labTestsQuery =
        FirebaseFirestore.instance.collection('labTests');
    return labTestsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return LabTestsModel.fromMap(doc.id, data);
      }).toList();
    });
  }

  Stream<List<LabsModel>> getLabs() {
    Query<Map<String, dynamic>> labsQuery =
        FirebaseFirestore.instance.collection('labs');
    return labsQuery.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          var data = doc.data();
          return LabsModel.fromMap(doc.id, data);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    RxInt tabCurrentIndex = 0.obs;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: Obx(
          () => AddFloatingButton(
            onPress: () {
              tabCurrentIndex.value == 0 ? Get.to(()=>AddLabTestScreen()) : Get.to(()=>const AddLab());
            },
            tooltipMessage:
                tabCurrentIndex.value == 0 ? 'Add New Lab Test' : 'Add New Lab',
          ),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
              constraints.maxWidth <= 600.0;
          if (isMobile) {
            return LabTestsLabsTabLayout(
              tabViews: [
                StreamBuilder<List<LabTestsModel>>(
                    stream: getLabTests(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ProgressBar(
                          full: true,
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No lab tests found'));
                      } else {
                        List<LabTestsModel> labTestsList = snapshot.data!;
                        return LabTestsListView(labTestsList: labTestsList);
                      }
                    }),
                StreamBuilder<List<LabsModel>>(
                    stream: getLabs(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const ProgressBar(
                          full: true,
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No labs found'));
                      } else {
                        List<LabsModel> labsList = snapshot.data!;
                        return LabsListView(labsList: labsList);
                      }
                    }),
              ],
              onPress: (index) {
                tabCurrentIndex.value = index;
              },
              isMobile: true,
            );
          } else {
            final AppSearchController searchC = Get.put(AppSearchController());
            return PageViewPage(
                width: constraints.maxWidth,
                child: LabTestsLabsTabLayout(
                  tabViews: [
                    StreamBuilder<List<LabTestsModel>>(
                        stream: getLabTests(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ProgressBar(
                              full: true,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No lab tests found'));
                          } else {
                            List<LabTestsModel> labTestsList = snapshot.data!;
                            return Obx(() {
                              if (searchC.searchTrigger.isTrue) {
                                List<LabTestsModel> filteredLabTests =
                                    labTestsList
                                        .where((i) => i.testName
                                            .toLowerCase()
                                            .startsWith(
                                                searchC.searchText.value))
                                        .toList();
                                return LabTestsListView(labTestsList: filteredLabTests);
                              } else {
                                return LabTestsListView(labTestsList: labTestsList);
                              }
                            });
                          }
                        }),
                    StreamBuilder<List<LabsModel>>(
                        stream: getLabs(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ProgressBar(
                              full: true,
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No lab tests found'));
                          } else {
                            List<LabsModel> labsList = snapshot.data!;
                            return Obx(() {
                              if (searchC.searchTrigger.isTrue) {
                                List<LabsModel> filteredLabs = labsList
                                    .where((i) => i.labName
                                        .toLowerCase()
                                        .startsWith(searchC.searchText.value))
                                    .toList();
                                return LabsListView(labsList: filteredLabs);
                              } else {
                                return LabsListView(labsList: labsList);
                              }
                            });
                          }
                        }),
                  ],
                  onPress: (index) {
                    tabCurrentIndex.value = index;
                  },
                ));
          }
        }),
      ),
    );
  }
}
