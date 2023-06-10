

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/addServiceController.dart';

import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';

class dAddServiceScreen extends StatelessWidget {
  bool edit = false;
  String id = '';
  String title = '';
  String imageUrl = '';
  String hospital = '';
  String fee = '';
  String facilities = '';

  final customWidgets _widgets = customWidgets();

  dAddServiceScreen({super.key});
  dAddServiceScreen.edit({super.key, required this.edit,  required this.id,
    required this.title,  required this.imageUrl,  required this.hospital,  required this.fee,  required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: edit? const Text("Edit Home Service") : const Text("Add Home Service"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 2.0,
        child: GetBuilder(
            init: addServiceController(),
            builder: (controller) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 2.0,
                            child: controller.files.length == 1
                                ? Container(
                                    height: 200.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: MemoryImage(controller.capturedImage!),
                                            fit: BoxFit.contain)),
                                    child: Center(
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          elevation: 2.0,
                                          child: TextButton(
                                            child: const Text("Add Image"),
                                            onPressed: () {
                                              controller.viewImageFromDevice();
                                            },
                                          )),
                                    ),
                                  )
                                : Container(
                                    height: 200.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                imageUrl),
                                            fit: BoxFit.contain)
                                    ),
                                    child: Center(
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          elevation: 2.0,
                                          child: TextButton(
                                            child: const Text("Add Image"),
                                            onPressed: () {
                                              controller.viewImageFromDevice();
                                            },
                                          )),
                                    ),
                                  )),
                        const Padding(padding: EdgeInsets.only(left: 40.0)),
                        SizedBox(
                          height: 200.0,
                          width: 400.0,
                          child: edit? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _widgets.addProductTextField(
                                readOnly: controller.progressVisibility,
                                  controller: controller.titleC..text = title, label: "Service title",),
                              _widgets.addProductTextField(
                                readOnly: controller.progressVisibility,
                                  controller: controller.hospitalC..text = hospital, label: "Hospital",),
                              _widgets.addProductNumberField(
                                readOnly: controller.progressVisibility,
                                  controller: controller.feeC..text = fee, label: "Fee",),
                            ],
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _widgets.addProductTextField(
                                readOnly: controller.progressVisibility,
                                controller: controller.titleC, label: "Service title",),
                              _widgets.addProductTextField(
                                readOnly: controller.progressVisibility,
                                controller: controller.hospitalC, label: "Hospital",),
                              _widgets.addProductNumberField(
                                readOnly: controller.progressVisibility,
                                controller: controller.feeC, label: "Fee",),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: edit && controller.addServiceButtonVisibility,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
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
                                    controller.deleteService(id: id, imageUrl: imageUrl).then((value) => Get.back())
                                        .onError((error, stackTrace) => Get.snackbar("Error", "Cannot delete at this moment."));
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                      "Are you sure you want to delete this service?"),
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
                              child: const Text("Delete Service"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kGrey,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(20.0),
                      child: edit?TextField(
                        controller: controller.facilitiesC..text = facilities,
                        maxLines: 6,
                        readOnly: controller.progressVisibility,
                        maxLength: 100,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            labelText: "Facilities", border: InputBorder.none),
                      )
                      : TextField(
                        controller: controller.facilitiesC,
                        maxLines: 6,
                        readOnly: controller.progressVisibility,
                        maxLength: 100,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            labelText: "Facilities", border: InputBorder.none),
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: controller.addServiceButtonVisibility,
                          child: ElevatedButton(
                              onPressed: () async {
                                if(edit){
                                  await controller.updateData(id: id, imageUrl: imageUrl);
                                }
                                else{
                                  await controller.addData();
                                }
                              },
                              child: edit? const Text("Save") : const Text("Add Service")),
                        ),
                        Visibility(
                          visible: controller.progressVisibility,
                          child: const SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      )),
    );
  }
}
