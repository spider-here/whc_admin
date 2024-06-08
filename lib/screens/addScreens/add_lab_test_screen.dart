import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/progress_bar.dart';
import '../../controllers/add_lab_test_controller.dart';
import '../../custom_widgets/app_chip.dart';
import '../../custom_widgets/general/app_text_field.dart';
import '../../custom_widgets/tags_textfield.dart';
import '../../database/database.dart';
import '../../models/lab_test_types_model.dart';
import '../../utils/constants.dart';

class AddLabTestScreen extends StatelessWidget {
  final bool edit;
  final String id;
  final String testName;
  final String testType;
  final String sampleType;
  final String testFor;
  final String fee;
  final List<DocumentSnapshot> labsInLabTest;

  AddLabTestScreen({super.key}) : edit = false,
  id = " ",
  testName = " ",
  testType = " ",
  sampleType = " ",
  testFor = " ",
  fee = " ",
  labsInLabTest = [];

  const AddLabTestScreen.edit(
      {super.key,
      required this.id,
      required this.testName,
      required this.testType,
      required this.sampleType,
      required this.testFor,
      required this.fee,
      required this.labsInLabTest}) : edit = true;

  @override
  Widget build(BuildContext context) {
    final Database db = Database();
    AddLabTestController getC = Get.put(AddLabTestController());
    if(edit){
      getC.selectedLabTestType = labTestTypes.firstWhere(
            (element) => element.title.toLowerCase() == testType.toLowerCase(),
      );
      getC.dropDownValGender.value = getC.testForGender.indexWhere((element) => element == testFor);
    }
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      bool isMobile = constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0;
      return Scaffold(
        appBar: AppBar(
          title: edit ? const Text("Edit Lab Test") : const Text("Add Lab Test"),
          bottom: PreferredSize(preferredSize: const Size.fromHeight(4.0), child: Obx(
                ()=> Visibility(
              visible: getC.progressVisibility.value,
              child: const ProgressBar(),
              ),
            ),
          ),
          actions: [
            Visibility(
              visible: edit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
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
                          db
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
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(kRed)
                    ),
                    child: const Text("Delete Lab Test"),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
            child: isMobile ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Test Type: "),
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: EdgeInsets.zero,
                      elevation: 1.0,
                      child: DropdownButtonHideUnderline(
                        child: GetBuilder<AddLabTestController>(
                            id: 'testType',
                            builder: (context) {
                              return SizedBox(
                                height: 40.0,
                                child: DropdownButton<LabTestType>(
                                  value: getC.selectedLabTestType,
                                  hint: Text(getC.selectedLabTestType?.title ?? 'Select'),
                                  onChanged: (LabTestType? newValue) {
                                    getC.selectedLabTestType = newValue;
                                    getC.update(['testType']);
                                  },
                                  elevation: 1,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  items: labTestTypes.map((LabTestType labTestType) {
                                    return DropdownMenuItem<LabTestType>(
                                      value: labTestType,
                                      child: Text(labTestType.title),
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20.0)),
                    const Text("Test For: "),
                    Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: EdgeInsets.zero,
                      elevation: 1.0,
                      child: DropdownButtonHideUnderline(
                        child: GetBuilder<AddLabTestController>(
                            id: 'testFor',
                            builder: (context) {
                              return SizedBox(
                                height: 40.0,
                                child: DropdownButton(
                                    value: edit? getC.testForGender.indexOf(testFor):getC.dropDownValGender.value,
                                    elevation: 1,
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
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                    onChanged: (val) {
                                      getC.dropDownValGender.value = val as int;
                                      getC.update(['testFor']);
                                    }),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                edit
                    ? AppTextField(
                      controller: getC.testNameC..text = testName,
                      label: "Test Name")
                    : AppTextField(
                          controller: getC.testNameC, label: "Test Name"),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                edit
                    ? AppTextField(
                          controller: getC.sampleTypeC..text = sampleType,
                          label: "Sample Type")
                    : AppTextField(
                          controller: getC.sampleTypeC,
                          label: "Sample Type"),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                edit
                    ? AppTextField(
                        controller: getC.feeC..text = fee, label: "Fee", isNumber: true,)
                    : AppTextField(
                        controller: getC.feeC, label: "Fee", isNumber: true,),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Visibility(
                  visible: edit,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kGrey, width: 0.5),
                        color: kGreyOutline),
                    padding: const EdgeInsets.all(10.0),
                    height: 175.0,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Labs Set:",
                        ),
                        const Divider(),
                        StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection("labTests")
                                .doc(id)
                                .collection("labs")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const ProgressBar(full: true,);
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Text('Labs not found');
                              } else {
                                return Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: List.generate(snapshot.data?.size ?? 0, (index) {
                                    return AppChip(
                                      text: snapshot.data?.docs[index].get('name'),
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('labTests')
                                            .doc(id)
                                            .collection('labs')
                                            .doc(snapshot.data?.docs[index].get('lId'))
                                            .delete()
                                            .then((value) => getC.update())
                                            .onError((error, stackTrace) => Get.snackbar(
                                          "Error",
                                          "Problem deleting data.",
                                          backgroundColor: kWhite,
                                        ));
                                      },
                                    );
                                  }),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                TagsTextField(
                    controller: getC.labsController,
                    distanceToField: constraints.maxWidth,
                    dataList: getC.labNames,
                    hintText: edit? "New Labs" : "Labs",
                    helperText:
                    "Enter Labs where this test is available.",
                  ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Obx(
                      ()=> Visibility(
                    visible: getC.addLabButtonVisibility.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
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
                                : const Text("Add Lab Test")),
                      ],
                    ),
                  ),
                ),
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Test Type: "),
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          margin: EdgeInsets.zero,
                          elevation: 1.0,
                          child: DropdownButtonHideUnderline(
                            child: GetBuilder<AddLabTestController>(
                                id: 'testType',
                                builder: (context) {
                                  return SizedBox(
                                    height: 40.0,
                                    child: DropdownButton<LabTestType>(
                                      value: getC.selectedLabTestType,
                                      elevation: 1,
                                      hint: Text(getC.selectedLabTestType?.title ?? 'Select'),
                                      onChanged: (LabTestType? newValue) {
                                        getC.selectedLabTestType = newValue;
                                        getC.update(['testType']);
                                      },
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                      items: labTestTypes.map((LabTestType labTestType) {
                                        return DropdownMenuItem<LabTestType>(
                                          value: labTestType,
                                          child: Text(labTestType.title),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 30.0)),
                        const Text("Test For: "),
                        Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          margin: EdgeInsets.zero,
                          elevation: 1.0,
                          child: DropdownButtonHideUnderline(
                            child: GetBuilder<AddLabTestController>(
                                id: 'testFor',
                                builder: (context) {
                                  return SizedBox(
                                    height: 40.0,
                                    child: DropdownButton(
                                        elevation: 1,
                                        value: edit? getC.testForGender.indexOf(testFor):getC.dropDownValGender.value,
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
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                        onChanged: (val) {
                                          getC.dropDownValGender.value = val as int;
                                          getC.update(['testFor']);
                                        }),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      width: constraints.maxWidth / 2.2,
                      child:edit
                          ? AppTextField(
                          controller: getC.testNameC..text = testName,
                          label: "Test Name")
                          : AppTextField(
                          controller: getC.testNameC, label: "Test Name"),),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      width: constraints.maxWidth / 2.2,
                      child:edit
                          ? AppTextField(
                          controller: getC.sampleTypeC..text = sampleType,
                          label: "Sample Type")
                          : AppTextField(
                          controller: getC.sampleTypeC,
                          label: "Sample Type"),),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      width: constraints.maxWidth / 2.2,
                      child:edit
                          ? AppTextField(
                        controller: getC.feeC..text = fee, label: "Fee", isNumber: true,)
                          : AppTextField(
                        controller: getC.feeC, label: "Fee", isNumber: true,),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 48.0)),
                    Visibility(
                      visible: edit,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kGrey, width: 0.5),
                            color: kGreyOutline),
                        padding: const EdgeInsets.all(10.0),
                        height: 175.0,
                        width: constraints.maxWidth/2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Current Labs Set:",
                            ),
                            const Divider(),
                            StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("labTests")
                                    .doc(id)
                                    .collection("labs")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const ProgressBar(full: true,);
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return const Text('Labs not found');
                                  } else {
                                    return Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: List.generate(snapshot.data?.size ?? 0, (index) {
                                        return AppChip(
                                          text: snapshot.data?.docs[index].get('name'),
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('labTests')
                                                .doc(id)
                                                .collection('labs')
                                                .doc(snapshot.data?.docs[index].get('lId'))
                                                .delete()
                                                .then((value) => getC.update())
                                                .onError((error, stackTrace) => Get.snackbar(
                                              "Error",
                                              "Problem deleting data.",
                                              backgroundColor: kWhite,
                                            ));
                                          },
                                        );
                                      }),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10.0)),
                    SizedBox(
                      width: constraints.maxWidth/2.2,
                      child: TagsTextField(
                        controller: getC.labsController,
                        distanceToField: constraints.maxWidth,
                        dataList: getC.labNames,
                        hintText: edit? "New Labs" : "Labs",
                        helperText:
                        "Enter Labs where this test is available.",
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    Obx(
                          ()=> Visibility(
                        visible: getC.addLabButtonVisibility.value,
                        child: SizedBox(
                          width: constraints.maxWidth/2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ElevatedButton(
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
                                      : const Text("Add Lab Test")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      );
    });
  }
}
