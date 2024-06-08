import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/confirmation_dialog.dart';

import '../../../controllers/add_medicine_controller.dart';
import '../../../custom_widgets/general/app_text_field.dart';
import '../../../utils/constants.dart';
import '../../custom_widgets/general/progress_bar.dart';

class AddMedicineScreen extends StatelessWidget {
  final bool edit;
  final String id;
  final String name;
  final String type;
  final String strength;
  final String description;
  final String price;
  final String imageUrl;
  final bool inStock;

  const AddMedicineScreen({super.key}) : edit = false,
  id = '',
  name = '',
  type = '',
  strength = '',
  description = '',
  price = '',
  imageUrl = '',
  inStock = true;

  const AddMedicineScreen.edit(
      {super.key,
      required this.id,
      required this.name,
      required this.type,
      required this.strength,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.inStock}) : edit = true;

  @override
  Widget build(BuildContext context) {
    final AddMedicineController getC = Get.put(AddMedicineController());
    getC.medicineInStock.value = inStock;
    return Scaffold(
      appBar: AppBar(
        title: edit ? const Text("Edit Medicine") : const Text("Add Medicine"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Obx(
                () => Visibility(
              visible: getC.progressVisibility.value,
              child: const ProgressBar(),
            ),
          ),
        ),
        actions: [
          edit ? Obx(() => Visibility(
            visible: getC.addServiceButtonVisibility.value,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmationDialog.delete(message: "Are you sure you want to delete $name?", onConfirm: () async {
                      getC.progressVisibility.value = true;
                      getC.addServiceButtonVisibility.value = false;
                      getC.deleteMedicine(id: id, imageUrl: imageUrl)
                          .then((value){
                        Get.back();
                      })
                          .onError((error, stackTrace) {
                        getC.progressVisibility.value = false;
                        getC.addServiceButtonVisibility.value = true;
                        Get.back();
                        Get.snackbar("Error",
                            "Cannot delete at this moment.");});
                    }, confirmButtonLabel: 'Delete',);
                  },
                );
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('Delete Medicine'),
            ),
          )) : const SizedBox(),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0;
        return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(isMobile ? 20.0 : 100.0, 20.0, 20.0, 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isMobile? [
                Obx(
                      ()=> getC.files.length == 1
                      ? Container(
                    height: 200.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                            image: MemoryImage(
                                getC.capturedImage.value!),
                            fit: BoxFit.contain)),
                    child: Center(
                      child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.zero,
                          ),
                          elevation: 1.0,
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
                    width: 160.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.zero,
                          ),
                          elevation: 1.0,
                          child: TextButton(
                            child: const Text("Add Image"),
                            onPressed: () {
                              getC.viewImageFromDevice();
                            },
                          )),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Obx(()=> AppTextField(
                  readOnly: getC.progressVisibility.value,
                  controller: !edit? getC.nameC : getC.nameC..text = name, label: "Name",),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Obx(()=> AppTextField(
                  readOnly: getC.progressVisibility.value,
                  controller: !edit? getC.typeC : getC.typeC..text = type, label: "Type",),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Obx(()=> AppTextField(
                  readOnly: getC.progressVisibility.value,
                  controller: !edit? getC.strengthC : getC.strengthC..text = strength, label: "Strength",),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Obx(()=> TextField(
                  controller: !edit? getC.descriptionC : getC.descriptionC..text = description,
                  maxLines: 6,
                  maxLength: 100,
                  keyboardType: TextInputType.multiline,
                  readOnly: getC.progressVisibility.value,
                  decoration: const InputDecoration(
                    labelText: "Description", border: OutlineInputBorder(
                      borderSide: BorderSide(color: kGrey, ),
                      borderRadius: BorderRadius.zero
                  ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor,),
                        borderRadius: BorderRadius.zero
                    ),
                  ),),
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Obx(()=> AppTextField(
                  readOnly: getC.progressVisibility.value,
                  controller: !edit? getC.priceC : getC.priceC..text = price, label: "Price", isNumber: true,),
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: kGrey)),
                      child: Center(
                        child: Obx(()=> CheckboxListTile(
                          title: const Text(
                            "In Stock",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          value: getC.medicineInStock.value,
                          dense: true,
                          onChanged: (newValue) {
                            getC.medicineInStock.value = newValue!;
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 12.0)),
                    Obx(()=> Visibility(
                      visible: getC.addServiceButtonVisibility.value,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (edit) {
                              await getC.updateData(
                                  id: id, imageUrl: imageUrl);
                            } else {
                              await getC.addData();
                            }
                          },
                          child: edit
                              ? const Text("Save")
                              : const Text("Add Medicine")),
                    ),
                    ),
                  ],
                ),
              ]
                  : [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(()=> getC.files.length == 1
                        ? Container(
                      height: 200.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(getC.capturedImage.value!),
                              fit: BoxFit.contain)),
                      child: Center(
                        child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.zero,
                            ),
                            elevation: 1.0,
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
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            elevation: 1.0,
                            child: TextButton(
                              child: const Text("Add Image"),
                              onPressed: () {
                                getC.viewImageFromDevice();
                              },
                            )),
                      ),
                    ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20.0)),
                    SizedBox(
                      width: 400.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(()=> AppTextField(
                            readOnly: getC.progressVisibility.value,
                            controller: !edit? getC.nameC : getC.nameC..text = name, label: "Name",),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12.0)),
                          Obx(()=> AppTextField(
                            readOnly: getC.progressVisibility.value,
                            controller: !edit? getC.typeC : getC.typeC..text = type, label: "Type",),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20.0)),
                    SizedBox(
                      width: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(()=> AppTextField(
                            readOnly: getC.progressVisibility.value,
                            controller: !edit? getC.strengthC : getC.strengthC..text = strength, label: "Strength",),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12.0)),
                          Obx(()=> AppTextField(
                            readOnly: getC.progressVisibility.value,
                            controller: !edit? getC.priceC : getC.priceC..text = price, label: "Price", isNumber: true,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                SizedBox(
                    width: 800.0,
                    child: Obx(()=> TextField(
                      controller: !edit? getC.descriptionC : getC.descriptionC..text = description,
                      maxLines: 6,
                      maxLength: 100,
                      keyboardType: TextInputType.multiline,
                      readOnly: getC.progressVisibility.value,
                      decoration: const InputDecoration(
                        labelText: "Description", border: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey, ),
                          borderRadius: BorderRadius.zero
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor,),
                            borderRadius: BorderRadius.zero
                        ),
                      ),),
                    )
                ),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                SizedBox(
                  width: 800.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: kGrey)
                        ),
                        child: Center(
                          child: Obx(()=> CheckboxListTile(
                            title: const Text("In Stock", style: TextStyle(fontSize: 16.0),),
                            value: getC.medicineInStock.value,
                            dense: true,
                            onChanged: (newValue) {
                              getC.medicineInStock.value = newValue!;
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 20.0)),
                      Obx(()=> Visibility(
                        visible: getC.addServiceButtonVisibility.value,
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
                      ),
                    ],
                  ),
                ),
              ],
            )
          );
      }),
    );
  }
}
