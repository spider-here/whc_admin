
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/addMedicineController.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';


class mAddMedicineScreen extends StatelessWidget{

  bool edit = false;
  String id = '';
  String name = '';
  String type = '';
  String strength = '';
  String description = '';
  String price = '';
  String imageUrl = '';
  bool inStock = false;

  mAddMedicineScreen({super.key});
  mAddMedicineScreen.edit({super.key, required this.id, required this.edit, required this.name, required this.type,
    required this.strength, required this.description, required this.price, required this.imageUrl, required this.inStock});

  final customWidgets _widgets = customWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: edit? const Text("Edit Medicine") : const Text("Add Medicine"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: GetBuilder(
              init:  addMedicineController(),
              builder: (getC) {
                if(edit){
                  getC.medicineInStock = inStock;
                }
                return Container(
                  height: MediaQuery.of(context).size.height * 1.5,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(25.0),
                  child: edit? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: getC.addServiceButtonVisibility,
                        child: TextButton(
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
                                getC.deleteMedicine(id: id, imageUrl: imageUrl).then((value) => Get.back())
                                    .onError((error, stackTrace) => Get.snackbar("Error", "Cannot delete at this moment."));
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
                          child: const Text("Delete Medicine"),
                        ),
                      ),
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 2.0,
                          child: getC.files.length == 1
                              ? Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(getC.capturedImage!),
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
                                      getC.viewImageFromDevice();
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
                                      getC.viewImageFromDevice();
                                    },
                                  )),
                            ),
                          )),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.nameC..text = name, label: "Name",),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.typeC..text = type, label: "Type",),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.strengthC..text = strength, label: "Strength",),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kGrey,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: getC.descriptionC..text = description,
                          maxLines: 6,
                          maxLength: 100,
                          keyboardType: TextInputType.multiline,
                          readOnly: getC.progressVisibility,
                          decoration: const InputDecoration(
                              labelText: "Description", border: InputBorder.none),
                        ),
                      ),
                      _widgets.addProductNumberField(
                        readOnly: getC.progressVisibility,
                        controller: getC.priceC..text = price, label: "Price",),
                      Container(
                        height: 40.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey)
                        ),
                        child: Center(
                          child: CheckboxListTile(
                            title: const Text("In Stock", style: TextStyle(fontSize: 16.0),),
                            value: getC.medicineInStock,
                            dense: true,
                            onChanged: (newValue) {
                              getC.medicineInStock = newValue!;
                              getC.update();
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ),
                      const Divider(),
                      Visibility(
                        visible: getC.addServiceButtonVisibility,
                        child: ElevatedButton(
                            onPressed: () async {
                              if(edit){
                                await getC.updateData(id: id, imageUrl: imageUrl);
                              }
                              else{
                                await getC.addData();
                              }
                            },
                            child: edit? const Text("Save") : const Text("Add Medicine")),
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
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 2.0,
                          child: getC.files.length == 1
                              ? Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(getC.capturedImage!),
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
                                      getC.viewImageFromDevice();
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
                                      getC.viewImageFromDevice();
                                    },
                                  )),
                            ),
                          )),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.nameC, label: "Name",),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.typeC, label: "Type",),
                      _widgets.addProductTextField(
                        readOnly: getC.progressVisibility,
                        controller: getC.strengthC, label: "Strength",),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kGrey,
                            ),
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: getC.descriptionC,
                          maxLines: 6,
                          maxLength: 100,
                          keyboardType: TextInputType.multiline,
                          readOnly: getC.progressVisibility,
                          decoration: const InputDecoration(
                              labelText: "Description", border: InputBorder.none),
                        ),
                      ),
                      _widgets.addProductNumberField(
                        readOnly: getC.progressVisibility,
                        controller: getC.priceC, label: "Price",),
                      Container(
                        height: 40.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: kGrey)
                        ),
                        child: Center(
                          child: CheckboxListTile(
                            title: const Text("In Stock", style: TextStyle(fontSize: 16.0),),
                            value: getC.medicineInStock,
                            dense: true,
                            onChanged: (newValue) {
                              getC.medicineInStock = newValue!;
                              getC.update();
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ),
                      const Divider(),
                      Visibility(
                        visible: getC.addServiceButtonVisibility,
                        child: ElevatedButton(
                            onPressed: () async {
                              if(edit){
                                await getC.updateData(id: id, imageUrl: imageUrl);
                              }
                              else{
                                await getC.addData();
                              }
                            },
                            child: const Text("Add Medicine")),
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
                );
              })),
    );
  }

}