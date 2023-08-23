import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../database/database.dart';
import '../utils/constants.dart';

class AddMedicineController extends GetxController{
  bool medicineInStock = true;
  bool addServiceButtonVisibility = true;
  bool progressVisibility = false;

  final Database _db = Database();

  final TextEditingController nameC = TextEditingController();
  final TextEditingController typeC = TextEditingController();
  final TextEditingController strengthC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  late var files = [];
  Uint8List? capturedImage;

  Future<void> addData() async {
    if (nameC.text.length != 0 &&
        typeC.text.length != 0 &&
        strengthC.text.length != 0 &&
        priceC.text.length != 0 &&
        descriptionC.text.length != 0 &&
        capturedImage!.isNotEmpty) {
      var mime = lookupMimeType('', headerBytes: capturedImage);
      var extension = extensionFromMime(mime!);
      if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
        addServiceButtonVisibility = false;
        progressVisibility = true;
        update();
        await _db
            .uploadImageFile(
            image: capturedImage!, imageTitle: nameC.text, path: 'medicine')
            .then((value) async => await _db
            .addMedicine(
            imageUrl: value,
            name: nameC.text,
            type: typeC.text,
            strength: strengthC.text,
            description: descriptionC.text,
            price: int.parse(priceC.text),
            soldOut: !medicineInStock
        )
            .then((_) {
          nameC.clear();
          typeC.clear();
          strengthC.clear();
          descriptionC.clear();
          priceC.clear();
          medicineInStock = true;
          addServiceButtonVisibility =
          true;
          progressVisibility = false;
          capturedImage?.remove;
          update();
        }).onError((_, __) {
          addServiceButtonVisibility =
          true;
          progressVisibility = false;
          update();
          Get.snackbar(
              "Error", "Problem adding data.",
              backgroundColor: kWhite);
        }))
            .onError((_, __) {
          addServiceButtonVisibility = true;
          progressVisibility = false;
          update();
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
    } else if (capturedImage!.isEmpty) {
      Get.snackbar("Error", "Add Image",
          backgroundColor: kWhite);
    } else {
      Get.snackbar(
          "Error", "Please fill all fields",
          backgroundColor: kWhite);
    }
  }

  Future<void> updateData({required String id, required String imageUrl}) async {
    if(nameC.text.isNotEmpty &&
        typeC.text.isNotEmpty &&
        strengthC.text.isNotEmpty &&
        priceC.text.isNotEmpty &&
        descriptionC.text.isNotEmpty) {
    addServiceButtonVisibility = false;
    progressVisibility = true;
    update();
    if (capturedImage != null) {
      await updateWithImage(id: id, imageUrl: imageUrl).then((value) => Get.back()).onError((_, __) {
        Get.snackbar(
            "Error", "Problem adding data.",
            backgroundColor: kWhite);
      });
    }
    else {
      await updateWithoutImage(id: id).then((value) => Get.back()).onError((_, __) {
        Get.snackbar(
            "Error", "Problem adding data.",
            backgroundColor: kWhite);
      });
    }
  }
    else{
    Get.snackbar(
    "Error", "Please fill all fields",
    backgroundColor: kWhite);
    }
    addServiceButtonVisibility = true;
    progressVisibility = false;
    update();
  }

  void viewImageFromDevice(){
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      files = uploadInput.files!;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =
        FileReader();
        reader.onLoadEnd.listen((e) {
          capturedImage = reader
              .result as Uint8List?;
          update();
        });

        reader.onError
            .listen((fileEvent) {
          const Text(
              "Some Error occured while reading the file");
          update();
        });

        reader
            .readAsArrayBuffer(file);
      }
    });
  }

  Future<void> deleteMedicine({required String id, required String imageUrl}) async {
    await _db.deleteMedicine(id: id, imageUrl: imageUrl).then((value){
      Get.back();
    });
  }

  Future<void> updateWithImage({required String id, required String imageUrl}) async {
      var mime = lookupMimeType('', headerBytes: capturedImage);
      var extension = extensionFromMime(mime!);
      if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
        await _db
            .uploadImageFile(
            image: capturedImage!, imageTitle: nameC.text, path: 'medicines')
            .then((value) async => await _db
            .updateMedicineAndImage(
          id: id,
          imageUrl: value,
          name: nameC.text,
          type: typeC.text,
          strength: strengthC.text,
          description: descriptionC.text,
          price: int.parse(priceC.text),
          soldOut: !medicineInStock,
        ).then((value) async => await _db.deleteImage(imageUrl: imageUrl))
            .then((_) {
          Get.back();
          update();
        }).onError((_, __) {
          Get.snackbar(
              "Error", "Problem adding data.",
              backgroundColor: kWhite);
        }))
            .onError((_, __) {
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
  }

  Future<void> updateWithoutImage({required String id}) async {
      await _db
          .updateMedicineDetailsOnly(
          id: id,
          name: nameC.text,
          type: typeC.text,
          strength: strengthC.text,
          description: descriptionC.text,
          price: int.parse(priceC.text),
          soldOut: !medicineInStock
      );
      addServiceButtonVisibility = true;
      progressVisibility = false;
      update();
    }
  }