
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/add_lab_controller.dart';
import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/custom_widgets.dart';

class MAddLabScreen extends StatelessWidget {

  bool edit = false;
  String id = "";
  String labName = "";
  String address = "";
  String phoneNumber = "";

  MAddLabScreen({super.key});
  MAddLabScreen.edit({super.key, required this.edit, required this.id,  required this.labName,
    required this.address,  required this.phoneNumber,});

  final CustomWidgets _widgets = CustomWidgets();
  final Database _db = Database();

  final TextEditingController _labNameC = TextEditingController();
  final TextEditingController _addressC = TextEditingController();
  final TextEditingController _phoneNumberC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: edit?const Text("Edit Lab") : const Text("Add Lab"),
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
                        onPressed: (){
                          Widget cancelButton = TextButton(
                            child: const Text("Cancel"),
                            onPressed:  () {Get.back();},
                          );
                          Widget continueButton = ElevatedButton(
                            child: const Text("Delete"),
                            onPressed:  () async {
                              _db.deleteLab(labID: id).then((value) => Get.back())
                                  .onError((error, stackTrace) => Get.snackbar("Error", "Data not deleted."));
                              Get.back();
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text("Are you sure you want to delete this lab?"),
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
              ),
              GetBuilder(
                  init: AddLabController(),
                  builder: (addC) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.3,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20.0)),
                          edit? _widgets.addProductTextField(
                              controller: _labNameC..text = labName, label: "Lab Name") : _widgets.addProductTextField(
                              controller: _labNameC, label: "Lab Name"),
                          edit? _widgets.addProductTextField(
                              controller: _addressC..text = address, label: "Address") : _widgets.addProductTextField(
                              controller: _addressC, label: "Address"),
                          edit? _widgets.addProductNumberField(
                              controller: _phoneNumberC..text = phoneNumber, label: "Phone Number") : _widgets.addProductNumberField(
                              controller: _phoneNumberC, label: "Phone Number"),
                          const Padding(padding: EdgeInsets.only(top: 20.0)),
                          Visibility(
                            visible: addC.addLabButtonVisibility,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_labNameC.text.length != 0 &&
                                      _addressC.text.length != 0 &&
                                      _phoneNumberC.text.length != 0) {
                                    addC.addLabButtonVisibility = false;
                                    addC.progressVisibility = true;
                                    addC.update();
                                    if(edit){
                                      _db
                                          .updateLab(
                                          labID: id,
                                          labName: _labNameC.text,
                                          address: _addressC.text,
                                          phoneNumber: int.parse(_phoneNumberC.text))
                                          .then((value) {
                                        Get.back();
                                      }).onError((_, __) {
                                        addC.addLabButtonVisibility = true;
                                        addC.progressVisibility = false;
                                        addC.update();
                                        Get.snackbar("Error", "Problem adding data.",
                                            backgroundColor: kWhite);
                                      });
                                    }
                                    else{
                                      _db
                                          .addLab(
                                          labName: _labNameC.text,
                                          address: _addressC.text,
                                          phoneNumber: int.parse(_phoneNumberC.text))
                                          .then((value) {
                                        Get.back();
                                      }).onError((_, __) {
                                        addC.addLabButtonVisibility = true;
                                        addC.progressVisibility = false;
                                        addC.update();
                                        Get.snackbar("Error", "Problem adding data.",
                                            backgroundColor: kWhite);
                                      });
                                    }
                                  } else {
                                    Get.snackbar("Error", "Please fill all fields",
                                        backgroundColor: kWhite);
                                  }
                                },
                                child: edit? const Text("Save") : const Text("Add Lab")),
                          ),
                          Visibility(
                            visible: addC.progressVisibility,
                            child: const SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
