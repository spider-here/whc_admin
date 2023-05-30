import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';
import '../../addScreens/addLabScreen.dart';
import '../../addScreens/addLabTestScreen.dart';

class mLabTestsScreen extends StatelessWidget{

  final customWidgets _widgets = customWidgets();
  int _tabCurrentIndex = 0;

  mLabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
        floatingActionButton: Tooltip(
          message: "Add new",
          child: FloatingActionButton(
            onPressed: () {
              if(_tabCurrentIndex == 0){
                Get.to(()=>addLabTestScreen());
              }
              else{
                Get.to(()=>addLabScreen());
              }
            },
            child: const Icon(Icons.add),
          ),
        ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            elevation: 2.0,
            child: SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: kPrimarySwatch,
                unselectedLabelColor: kBlack,
                labelColor: kPrimarySwatch,
                onTap: (index){
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
            height: MediaQuery.of(context).size.height - 118.0,
            width:  MediaQuery.of(context).size.width,
            child: TabBarView(children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('labTests')
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
                                  .height - 100.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  primary: true,
                                  padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 50.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.size,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2/1.6,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0),
                                  itemBuilder: (context, index) {
                                    return _widgets.labTestCard(
                                      context: context,
                                      title: snapshot.data!.docs[index]
                                          .get('name')
                                          .toString(),
                                      info1: snapshot.data!.docs[index].get(
                                          'sampleType').toString(),
                                      info2: snapshot.data!.docs[index]
                                          .get('type').toString(),
                                      info3: snapshot.data!.docs[index].get(
                                          'fee').toString(),
                                      onPressed: () async {
                                        final QuerySnapshot result =
                                        await FirebaseFirestore.instance.collection('labTests').doc(snapshot.data!.docs[index]
                                            .get('ltId'))
                                            .collection('labs').get();
                                        final List<DocumentSnapshot> labsInLabTest = result.docs;
                                        Get.to(()=>addLabTestScreen.edit(edit: true, id: snapshot.data!.docs[index]
                                            .get('ltId').toString(), testName: snapshot.data!.docs[index]
                                            .get('name').toString(), testType: snapshot.data!.docs[index]
                                            .get('type').toString(), sampleType: snapshot.data!.docs[index]
                                            .get('sampleType').toString(), testFor: snapshot.data!.docs[index]
                                            .get('testFor').toString(), fee: snapshot.data!.docs[index]
                                            .get('fee').toString(),
                                          labsInLabTest: labsInLabTest,));
                                      },
                                    );
                                  }),
                            );
                    }
                  }),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('labs')
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
                                  .height - 100.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  primary: true,
                                  padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 50.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data?.size,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2/1.6,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0),
                                  itemBuilder: (context, index) {
                                    return _widgets.labTestCard(
                                      context: context,
                                      title: snapshot.data!.docs[index]
                                          .get('name')
                                          .toString(),
                                      info1: snapshot.data!.docs[index].get(
                                          'address').toString(),
                                      info2: "",
                                      info3: snapshot.data!.docs[index].get(
                                          'phoneNumber').toString(),
                                      onPressed: () {
                                        Get.to(()=>addLabScreen.edit(edit: true, id: snapshot.data!.docs[index]
                                            .get('lId').toString(),
                                          labName: snapshot.data!.docs[index]
                                              .get('name')
                                              .toString(),
                                          address: snapshot.data!.docs[index].get(
                                              'address').toString(),
                                          phoneNumber: snapshot.data!.docs[index].get(
                                              'phoneNumber').toString(),)
                                        );
                                      },
                                    );
                                  }),
                      );
                    }
                  }),
            ],),
          ),
        ],
      )
    ));
  }

}