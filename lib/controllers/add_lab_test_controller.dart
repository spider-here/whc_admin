import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../database/database.dart';
import '../models/lab_test_types_model.dart';
import '../utils/constants.dart';

class AddLabTestController extends GetxController{
  RxBool addLabButtonVisibility = true.obs;
  RxBool progressVisibility = false.obs;
  RxInt dropDownValGender = 0.obs;
  LabTestType? selectedLabTestType;

  final TextEditingController testNameC = TextEditingController();
  final TextEditingController testTypeC = TextEditingController();
  final TextEditingController sampleTypeC = TextEditingController();
  final TextEditingController feeC = TextEditingController();
  final TextfieldTagsController labsController = TextfieldTagsController();

  final Database _db = Database();


  List<int> selectedLabNamesIndexes = [];
  List<String> labNames = [];
  List<String> labIDs = [];
  final testForGender = [
    'Both Genders',
    'Male',
    'Female'
  ];

  AddLabTestController();

  @override
  void onInit() {
    super.onInit();
    getLabs(view: true);
  }

  getLabs({required bool view}) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('labs').get();
    final List<DocumentSnapshot> documents = result.docs;

    for (var snapshot in documents) {
      labNames.add(snapshot.get('name'));
      labIDs.add(snapshot.get('lId'));
    }
     if(view){
       return labNames;
     }
     else{
       return labIDs;
     }
  }

  List<String> getLabsFromLabTest(List<DocumentSnapshot> documents) {

    List<String> labsInLabtestNames = [];

    for(var snapshot in documents){
        labsInLabtestNames.add(snapshot.get('name'));
    }

    return labsInLabtestNames;
  }

  onSubmitAdd() async {
    if (testNameC.text.isNotEmpty &&
        sampleTypeC.text.isNotEmpty &&
        feeC.text.isNotEmpty &&
        labsController.getTags!.isNotEmpty
        && selectedLabTestType != null) {
      final DocumentReference<Map<String, dynamic>> labTestRef =
      FirebaseFirestore.instance.collection('labTests').doc();
      addLabButtonVisibility.value = false;
      progressVisibility.value = true;
      update();
      await _db
          .addLabTest(
          labTestRef: labTestRef,
          testName: testNameC.text,
          sampleType: sampleTypeC.text,
          type: selectedLabTestType!.type,
          testFor: dropDownValGender.value == 1
              ? testForGender[1]
              : dropDownValGender.value == 2
              ? testForGender[2]
              : testForGender[0],
          fee: int.parse(feeC.text))
          .then((value) async {
        labsController.getTags!
            .asMap()
            .forEach((index, element) {
          if (labNames.contains(element)) {
            selectedLabNamesIndexes.add(
                labNames.indexWhere((item) =>
                    item.contains(element)));
          }
        });
        for (var element in selectedLabNamesIndexes) {
          final QuerySnapshot result = await FirebaseFirestore.instance
              .collection('labs')
              .where('lId', isEqualTo: labIDs[element])
              .get();

          final List<DocumentSnapshot> documents = result.docs;

          for (var snapshot in documents) {
            await FirebaseFirestore.instance
                .collection('labTests')
                .doc(labTestRef.id)
                .collection('labs')
                .doc(snapshot.id)
                .set({
              'lId': snapshot.id,
              'name': snapshot.get('name'),
              'address': snapshot.get('address'),
              'phoneNumber': snapshot.get('phoneNumber'),
            }).onError((error, stackTrace) =>
                Get.snackbar("Error", "Problem adding data.", backgroundColor: kWhite)
            );
          }
        }
        addLabButtonVisibility.value = true;
        progressVisibility.value = false;
        update();
        Get.back();
      }).onError((_, __) {
        addLabButtonVisibility.value = true;
        progressVisibility.value = false;
        update();
        Get.snackbar(
            "Error", "Problem adding data.",
            backgroundColor: kWhite);
      });
    } else {
      Get.snackbar(
          "Error", "Please fill all fields",
          backgroundColor: kWhite);
    }
  }

  onSubmitEdit({required String id}) async {
    if (testNameC.text.isNotEmpty &&
        sampleTypeC.text.isNotEmpty &&
        feeC.text.isNotEmpty && selectedLabTestType != null) {
      addLabButtonVisibility.value = false;
      progressVisibility.value = true;
      update();
      await _db
          .updateLabTest(
        id: id,
          testName: testNameC.text,
          sampleType: sampleTypeC.text,
          type: selectedLabTestType!.type,
          testFor: dropDownValGender.value == 1
              ? testForGender[1]
              : dropDownValGender.value == 2
              ? testForGender[2]
              : testForGender[0],
          fee: int.parse(feeC.text))
          .then((value) async {
            if(labsController.getTags!.isNotEmpty){
              labsController.getTags!
                  .asMap()
                  .forEach((index, element) {
                if (labNames.contains(element)) {
                  selectedLabNamesIndexes.add(
                      labNames.indexWhere((item) =>
                          item.contains(element)));
                }
              });
              for (int element in selectedLabNamesIndexes) {
                final QuerySnapshot result = await FirebaseFirestore.instance
                    .collection('labs')
                    .where('lId', isEqualTo: labIDs[element])
                    .get();
                final List<DocumentSnapshot> documents = result.docs;

                for (DocumentSnapshot snapshot in documents) {
                  try {
                    await FirebaseFirestore.instance
                        .collection('labTests')
                        .doc(id)
                        .collection('labs')
                        .doc(snapshot.id)
                        .set({
                      'lId': snapshot.id,
                      'name': snapshot.get('name'),
                      'address': snapshot.get('address'),
                      'phoneNumber': snapshot.get('phoneNumber'),
                    });
                  } catch (error) {
                    Get.snackbar("Error", "Problem adding data.", backgroundColor: kWhite);
                  }
                }
              }
            }
        addLabButtonVisibility.value = true;
        progressVisibility.value = false;
        update();
        Get.back();
      }).onError((_, __) {
        addLabButtonVisibility.value = true;
        progressVisibility.value = false;
        update();
        Get.snackbar(
            "Error", "Problem adding data.",
            backgroundColor: kWhite);
      });
    } else {
      Get.snackbar(
          "Error", "Please fill all fields",
          backgroundColor: kWhite);
    }
  }

}