import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_lab_test_controller.dart';
import '../../../database/database.dart';
import '../../../models/lab_tests_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets.dart';

class MAddLabTestScreen extends StatelessWidget {
  bool edit = false;
  String id = " ";
  String testName = " ";
  String testType = " ";
  String sampleType = " ";
  String testFor = " ";
  String fee = " ";
  List<DocumentSnapshot> labsInLabTest = [];

  final CustomWidgets _widgets = CustomWidgets();
  final Database _db = Database();

  MAddLabTestScreen({super.key});

  MAddLabTestScreen.edit(
      {super.key,
        required this.edit,
        required this.id,
        required this.testName,
        required this.testType,
        required this.sampleType,
        required this.testFor,
        required this.fee,
        required this.labsInLabTest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: edit ? const Text("Edit Lab Test") : const Text("Add Lab Test"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: edit,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 24.0),
                      child: OutlinedButton(
                        onPressed: () {
                          Widget cancelButton = TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Get.back();
                            },
                          );
                          Widget continueButton = ElevatedButton(
                            child: const Text("Delete"),
                            onPressed: () async {
                              _db
                                  .deleteLabTest(id: id)
                                  .then((value) => Get.back())
                                  .onError((error, stackTrace) =>
                                  Get.snackbar("Error", "Data not deleted."));
                              Get.back();
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                                "Are you sure you want to delete this lab test?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: const Text("Delete Lab Test"),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder(
                  init: AddLabTestController(),
                  builder: (getC) {
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1.2,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            edit
                                ? _widgets.addProductTextField(
                                controller: getC.testNameC..text = testName,
                                label: "Test Name")
                                : _widgets.addProductTextField(
                                controller: getC.testNameC, label: "Test Name"),
                            SizedBox(
                              height: 50.0,
                              child: Row(
                                children: [
                                  const Text("Test Type: "),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton<LabTestType>(
                                      value: getC.selectedLabTestType,
                                      onChanged: (LabTestType? newValue) {
                                        getC.selectedLabTestType = newValue;
                                        getC.update();
                                      },
                                      items: labTestTypes.map((LabTestType labTestType) {
                                        return DropdownMenuItem<LabTestType>(
                                          value: labTestType,
                                          child: Text(labTestType.title),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            edit
                                ? _widgets.addProductTextField(
                                controller: getC.sampleTypeC..text = sampleType,
                                label: "Sample Type")
                                : _widgets.addProductTextField(
                                controller: getC.sampleTypeC,
                                label: "Sample Type"),
                            SizedBox(
                              height: 50.0,
                              child: Row(
                                children: [
                                  const Text("Test For: "),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: edit? getC.testForGender.indexOf(testFor):getC.dropDownValGender,
                                        items: [
                                          DropdownMenuItem(
                                            value: 0,
                                            child: Text(getC.testForGender[0]),
                                          ),
                                          DropdownMenuItem(
                                            value: 1,
                                            child: Text(getC.testForGender[1]),
                                          ),
                                          DropdownMenuItem(
                                            value: 2,
                                            child: Text(getC.testForGender[2]),
                                          ),
                                        ],
                                        onChanged: (val) {
                                          getC.dropDownValGender = val!;
                                          getC.update();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            edit
                                ? _widgets.addProductNumberField(
                                controller: getC.feeC..text = fee, label: "Fee")
                                : _widgets.addProductNumberField(
                                controller: getC.feeC, label: "Fee"),
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            Visibility(
                              visible: edit,
                                child: const Text(
                                  "Current Labs Set:",
                                ),),
                            Visibility(
                              visible: edit,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: kGreyOutline),
                                height: 175.0,
                                width: double.maxFinite,
                                child: StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("labTests")
                                        .doc(id)
                                        .collection("labs")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return GridView.builder(
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width <=
                                                    900 &&
                                                    MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width >=
                                                        700
                                                    ? 3
                                                    : MediaQuery.of(context)
                                                    .size
                                                    .width <
                                                    700
                                                    ? 2
                                                    : 4,
                                                childAspectRatio: 6 / 1),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data?.size,
                                            padding: const EdgeInsets.all(10.0),
                                            itemBuilder: (context, index) {
                                              return _widgets.chip(
                                                  text: snapshot
                                                      .data?.docs[index]
                                                      .get('name'),
                                                  onTap: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('labTests')
                                                        .doc(id)
                                                        .collection('labs')
                                                        .doc(snapshot
                                                        .data?.docs[index]
                                                        .get('lId'))
                                                        .delete()
                                                        .then((value) =>
                                                        getC.update())
                                                        .onError((error,
                                                        stackTrace) =>
                                                        Get.snackbar(
                                                            "Error",
                                                            "Problem deleting data.",
                                                            backgroundColor:
                                                            kWhite));
                                                  });
                                            });
                                      }
                                    }),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10.0)),
                            _widgets.tagsTextField(
                              controller: getC.labsController,
                              distanceToField: MediaQuery.of(context).size.width,
                              dataList: getC.labNames,
                              hintText: edit? "New Labs": "Labs",
                              helperText:
                              "Enter Labs where this test is available.",
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            Visibility(
                              visible: getC.addLabButtonVisibility,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if(edit){
                                      getC.onSubmitEdit(id: id);
                                    }
                                    else{
                                      getC.onSubmitAdd();
                                    }
                                  },
                                  child: edit
                                      ? const Text("Save")
                                      : const Text("Add Lab")),
                            ),
                            Visibility(
                              visible: getC.progressVisibility,
                              child: const SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
