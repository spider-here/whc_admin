import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/lab_tests_model.dart';
import '../../screens/addScreens/add_lab_test_screen.dart';
import '../labtest_card.dart';

class LabTestsListView extends StatelessWidget{
  final List<LabTestsModel> labTestsList;
  final bool isMobile;


  const LabTestsListView({required this.labTestsList, super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: labTestsList.length,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            vertical: isMobile? 20 : 80.0, horizontal: 20.0),
        itemBuilder: (context, index) {
          return LabTestCard(
            index: index,
            title: labTestsList[index].testName,
            info2: labTestsList[index].sampleType,
            info1: labTestsList[index].testType,
            fee: labTestsList[index].fee,
            onPress: () async {
              final QuerySnapshot result =
              await FirebaseFirestore.instance
                  .collection('labTests')
                  .doc(labTestsList[index].id)
                  .collection('labs')
                  .get();
              final List<DocumentSnapshot>
              labsInLabTest = result.docs;
              Get.to(() => AddLabTestScreen.edit(
                id: labTestsList[index].id,
                testName: labTestsList[index]
                    .testName,
                testType: labTestsList[index]
                    .testType,
                sampleType: labTestsList[index]
                    .sampleType,
                testFor:
                labTestsList[index].testFor,
                fee:
                '${labTestsList[index].fee}',
                labsInLabTest: labsInLabTest,
              ));
            },
          );
        });
  }

}