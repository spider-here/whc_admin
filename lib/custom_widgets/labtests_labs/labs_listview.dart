import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/labs_model.dart';
import '../../screens/addScreens/add_lab.dart';
import '../labtest_card.dart';

class LabsListView extends StatelessWidget{
  final List<LabsModel> labsList;

  const LabsListView({required this.labsList, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: labsList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
            vertical: 80.0, horizontal: 20.0),
        itemBuilder: (context, index) {
          return LabTestCard(
            index: index,
            title: labsList[index].labName,
            info1: labsList[index].address,
            info2: labsList[index]
                .phoneNumber
                .toString(),
            fee: 0,
            isLab: true,
            onPress: () {
              Get.to(() => AddLab.edit(
                id: labsList[index].id,
                labName:
                labsList[index].labName,
                address:
                labsList[index].address,
                phoneNumber: labsList[index]
                    .phoneNumber
                    .toString(),
              ));
            },
          );
        });
  }

}