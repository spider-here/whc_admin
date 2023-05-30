import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:whc_admin/controllers/addServiceController.dart';

import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';

class dAddServiceScreen extends StatelessWidget {

  final customWidgets _widgets = customWidgets();
  final database _db = database();

  final addServiceController _getC = Get.put(addServiceController());
  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _hospitalC = TextEditingController();
  final TextEditingController _facilitiesC = TextEditingController();
  final TextEditingController _feeC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  late var files = [];
  Uint8List? uploadedImage;

  dAddServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Home Service"),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 2.0,
                            child: files.length == 1
                                ? Container(
                                    height: 200.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
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
                                                  FileReader reader =
                                                      FileReader();
                                                  reader.onLoadEnd.listen((e) {
                                                    uploadedImage = reader
                                                        .result as Uint8List?;
                                                    controller.update();
                                                  });

                                                  reader.onError
                                                      .listen((fileEvent) {
                                                    const Text(
                                                        "Some Error occured while reading the file");
                                                    controller.update();
                                                  });

                                                  reader
                                                      .readAsArrayBuffer(file);
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
                                                  FileReader reader =
                                                      FileReader();
                                                  reader.onLoadEnd.listen((e) {
                                                    uploadedImage = reader
                                                        .result as Uint8List?;
                                                    controller.update();
                                                  });
                                                  reader.onError
                                                      .listen((fileEvent) {
                                                    const Text(
                                                        "Some Error occured while reading the file");
                                                    controller.update();
                                                  });
                                                  reader
                                                      .readAsArrayBuffer(file);
                                                }
                                              });
                                            },
                                          )),
                                    ),
                                  )),
                        const Padding(padding: EdgeInsets.only(left: 40.0)),
                        SizedBox(
                          height: 200.0,
                          width: 400.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _widgets.addProductTextField(
                                  controller: _titleC, label: "Service title",),
                              _widgets.addProductTextField(
                                  controller: _hospitalC, label: "Hospital",),
                              _widgets.addProductNumberField(
                                  controller: _feeC, label: "Fee",),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kGrey,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _facilitiesC,
                        maxLines: 6,
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
                          visible: _getC.addServiceButtonVisibility,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_titleC.text.length != 0 &&
                                    _hospitalC.text.length != 0 &&
                                    _feeC.text.length != 0 &&
                                    _facilitiesC.text.length != 0 &&
                                    uploadedImage!.isNotEmpty) {
                                  var mime = lookupMimeType('', headerBytes: uploadedImage);
                                  var extension = extensionFromMime(mime!);
                                  if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
                                  _getC.addServiceButtonVisibility = false;
                                  _getC.progressVisibility = true;
                                  _getC.update();
                                  await _db
                                      .uploadImageFile(
                                          image: uploadedImage!, imageTitle: _titleC.text)
                                      .then((value) async => await _db
                                              .addHomeService(
                                                  imageUrl: value,
                                                  title: _titleC.text,
                                                  hospital: _hospitalC.text,
                                                  fee: int.parse(_feeC.text),
                                                  facilities: _facilitiesC.text)
                                              .then((_) {
                                            _titleC.clear();
                                            _hospitalC.clear();
                                            _facilitiesC.clear();
                                            _feeC.clear();
                                            _getC.addServiceButtonVisibility =
                                                true;
                                            _getC.progressVisibility = false;
                                            uploadedImage?.remove;
                                            controller.update();
                                          }).onError((_, __) {
                                            _getC.addServiceButtonVisibility =
                                                true;
                                            _getC.progressVisibility = false;
                                            controller.update();
                                            Get.snackbar(
                                                "Error", "Problem adding data.",
                                                backgroundColor: kWhite);
                                          }))
                                      .onError((_, __) {
                                    _getC.addServiceButtonVisibility = true;
                                    _getC.progressVisibility = false;
                                    controller.update();
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
                              child: const Text("Add Service")),
                        ),
                        Visibility(
                          visible: _getC.progressVisibility,
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
