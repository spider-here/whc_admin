import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../../../controllers/addMedicineController.dart';
import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';


class mAddMedicineScreen extends StatelessWidget{

  final customWidgets _widgets = customWidgets();
  final database _db = database();

  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _typeC = TextEditingController();
  final TextEditingController _strengthC = TextEditingController();
  final TextEditingController _descriptionC = TextEditingController();
  final TextEditingController _priceC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  late var files = [];
  Uint8List? uploadedImage;

  mAddMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medicine"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 2.0,
            child: GetBuilder(
                init:  addMedicineController(),
                builder: (getC) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 1.5,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 2.0,
                            child: files.length == 1
                                ? Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      image: MemoryImage(uploadedImage!),
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
                                        uploadInput.click();
                                        uploadInput.onChange.listen((e) {
                                          // read file content as dataURL
                                          files = uploadInput.files!;
                                          if (files.length == 1) {
                                            final file = files[0];
                                            FileReader reader = FileReader();
                                            reader.onLoadEnd.listen((e) {
                                              uploadedImage =
                                              reader.result as Uint8List?;
                                              getC.update();
                                            });

                                            reader.onError
                                                .listen((fileEvent) {
                                              const Text(
                                                  "Some Error occured while reading the file");
                                              getC.update();
                                            });

                                            reader.readAsArrayBuffer(file);
                                          }
                                        });
                                      },
                                    )),
                              ),
                            )
                                : Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                // image: DecorationImage(
                                //     image: NetworkImage(
                                //         "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg"),
                                //     fit: BoxFit.contain)
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
                                        uploadInput.click();
                                        uploadInput.onChange.listen((e) {
                                          // read file content as dataURL
                                          files = uploadInput.files!;
                                          if (files.length == 1) {
                                            final file = files[0];
                                            FileReader reader = FileReader();
                                            reader.onLoadEnd.listen((e) {
                                              uploadedImage =
                                              reader.result as Uint8List?;
                                              getC.update();
                                            });
                                            reader.onError
                                                .listen((fileEvent) {
                                              const Text(
                                                  "Some Error occured while reading the file");
                                              getC.update();
                                            });
                                            reader.readAsArrayBuffer(file);
                                          }
                                        });
                                      },
                                    )),
                              ),
                            )),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        _widgets.addProductTextField(
                          controller: _nameC, label: "Name",),
                        _widgets.addProductTextField(
                          controller: _typeC, label: "Type",),
                        _widgets.addProductTextField(
                          controller: _strengthC, label: "Strength",),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kGrey,
                              ),
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _descriptionC,
                            maxLines: 6,
                            maxLength: 100,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                labelText: "Description", border: InputBorder.none),
                          ),
                        ),
                        _widgets.addProductNumberField(
                          controller: _priceC, label: "Price",),
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
                                if (_nameC.text.length != 0 &&
                                    _typeC.text.length != 0 &&
                                    _strengthC.text.length != 0 &&
                                    _priceC.text.length != 0 &&
                                    _descriptionC.text.length != 0 &&
                                    uploadedImage!.isNotEmpty) {
                                  var mime = lookupMimeType('', headerBytes: uploadedImage);
                                  var extension = extensionFromMime(mime!);
                                  if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
                                    getC.addServiceButtonVisibility = false;
                                    getC.progressVisibility = true;
                                    getC.update();
                                    await _db
                                        .uploadImageFile(
                                        image: uploadedImage!, imageTitle: _nameC.text)
                                        .then((value) async => await _db
                                        .addMedicine(
                                        imageUrl: value,
                                        name: _nameC.text,
                                        type: _typeC.text,
                                        strength: _strengthC.text,
                                        description: _descriptionC.text,
                                        price: int.parse(_priceC.text),
                                        soldOut: !getC.medicineInStock
                                    )
                                        .then((_) {
                                      _nameC.clear();
                                      _typeC.clear();
                                      _strengthC.clear();
                                      _descriptionC.clear();
                                      _priceC.clear();
                                      getC.medicineInStock = true;
                                      getC.addServiceButtonVisibility =
                                      true;
                                      getC.progressVisibility = false;
                                      uploadedImage?.remove;
                                      getC.update();
                                    }).onError((_, __) {
                                      getC.addServiceButtonVisibility =
                                      true;
                                      getC.progressVisibility = false;
                                      getC.update();
                                      Get.snackbar(
                                          "Error", "Problem adding data.",
                                          backgroundColor: kWhite);
                                    }))
                                        .onError((_, __) {
                                      getC.addServiceButtonVisibility = true;
                                      getC.progressVisibility = false;
                                      getC.update();
                                      Get.snackbar(
                                          "Error", "Problem adding image.",
                                          backgroundColor: kWhite);
                                    });
                                  }
                                  else{
                                    Get.snackbar(
                                        "Error", "Only images with \".jpeg\" and \".png\" formats can be added.",
                                        backgroundColor: kWhite);
                                  }
                                } else if (uploadedImage!.isEmpty) {
                                  Get.snackbar("Error", "Add Image",
                                      backgroundColor: kWhite);
                                } else {
                                  Get.snackbar(
                                      "Error", "Please fill all fields",
                                      backgroundColor: kWhite);
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
                }),
          )),
    );
  }

}