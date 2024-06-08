import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../custom_widgets/general/app_text_field.dart';

class AddLab extends StatelessWidget {
  final bool edit;
  final String id;
  final String labName;
  final String address;
  final String phoneNumber;

  const AddLab({super.key}) : edit = false, id = "",
  labName = "",
  address = "",
  phoneNumber = "";

  const AddLab.edit({
    super.key,
    required this.id,
    required this.labName,
    required this.address,
    required this.phoneNumber,
  }) : edit = true;

  @override
  Widget build(BuildContext context) {
    RxBool addLabButtonVisibility = true.obs;
    RxBool progressVisibility = false.obs;
    final Database db = Database();
    final TextEditingController labNameC = TextEditingController();
    final TextEditingController addressC = TextEditingController();
    final TextEditingController phoneNumberC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: edit ? const Text("Edit Lab") : const Text("Add Lab"),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(10.0),
          child: Obx(()=> Visibility(
              visible: progressVisibility.isTrue,
              child: const LinearProgressIndicator(color: kPrimaryColor,),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: edit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Widget cancelButton = TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(kGrey)
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Cancel"),
                      );
                      Widget continueButton = TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(kRed)
                        ),
                        child: const Text("Delete"),
                        onPressed: () async {
                          db
                              .deleteLab(labID: id)
                              .then((value) => Get.back())
                              .onError((error, stackTrace) =>
                                  Get.snackbar("Error", "Data not deleted."));
                          Get.back();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        backgroundColor: kWhite,
                        surfaceTintColor: kWhite,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero
                        ),
                        title: const Text("Confirm"),
                        content: const Text(
                            "Are you sure you want to delete this lab?"),
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
                    child: const Text("Delete Lab"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0;
        return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              padding: isMobile? const EdgeInsets.all(20.0) : const EdgeInsets.all(100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  edit
                      ? isMobile
                      ? AppTextField(
                      controller: labNameC..text = labName,
                      label: "Lab Name")
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: labNameC..text = labName,
                        label: "Lab Name"),
                  )
                      : isMobile
                      ? AppTextField(
                      controller: labNameC, label: "Lab Name")
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: labNameC,
                        label: "Lab Name"),
                  ),
                  edit
                      ? isMobile
                      ? AppTextField(
                      controller: addressC..text = address,
                      label: "Address")
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: addressC..text = address,
                        label: "Address"),
                  )
                      : isMobile
                      ? AppTextField(
                      controller: addressC, label: "Address")
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: addressC,
                        label: "Address"),
                  ),

                  edit
                      ? isMobile
                      ? AppTextField(
                      controller: phoneNumberC..text = phoneNumber,
                      label: "Phone Number", isNumber: true,)
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: phoneNumberC..text = phoneNumber,
                        label: "Phone Number", isNumber: true,),
                  )
                      : isMobile
                      ? AppTextField(
                      controller: phoneNumberC,
                      label: "Phone Number", isNumber: true,)
                      : SizedBox(
                    width: constraints.maxWidth / 2,
                    child: AppTextField(
                        controller: phoneNumberC,
                        label: "Phone Number", isNumber: true,),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20.0)),
                  SizedBox(
                    width: isMobile? double.maxFinite : constraints.maxWidth/2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          ()=> Visibility(
                            visible: addLabButtonVisibility.isTrue,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (labNameC.text.isNotEmpty &&
                                      addressC.text.isNotEmpty &&
                                      phoneNumberC.text.isNotEmpty) {
                                    addLabButtonVisibility.value = false;
                                    progressVisibility.value = true;
                                    if (edit) {
                                      db
                                          .updateLab(
                                          labID: id,
                                          labName: labNameC.text,
                                          address: addressC.text,
                                          phoneNumber:
                                          int.parse(phoneNumberC.text))
                                          .then((value) {
                                        Get.back();
                                      }).onError((_, __) {
                                        addLabButtonVisibility.value = true;
                                        progressVisibility.value = false;
                                        Get.snackbar(
                                            "Error", "Problem adding data.",
                                            backgroundColor: kWhite);
                                      });
                                    } else {
                                      db
                                          .addLab(
                                          labName: labNameC.text,
                                          address: addressC.text,
                                          phoneNumber:
                                          int.parse(phoneNumberC.text))
                                          .then((value) {
                                        Get.back();
                                      }).onError((_, __) {
                                        addLabButtonVisibility.value = true;
                                        progressVisibility.value = false;
                                        Get.snackbar(
                                            "Error", "Problem adding data.",
                                            backgroundColor: kWhite);
                                      });
                                    }
                                  } else {
                                    Get.snackbar(
                                        "Error", "Please fill all fields",
                                        backgroundColor: kWhite);
                                  }
                                },
                                child: edit
                                    ? const Text("Save")
                                    : const Text("Add Lab")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
