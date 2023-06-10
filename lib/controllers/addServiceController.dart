
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../database/database.dart';
import '../utils/constants.dart';

class addServiceController extends GetxController{
  bool addServiceButtonVisibility = true;
  bool progressVisibility = false;
  final database _db = database();
  
  final TextEditingController titleC = TextEditingController();
  final TextEditingController hospitalC = TextEditingController();
  final TextEditingController facilitiesC = TextEditingController();
  final TextEditingController feeC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  late var files = [];
  Uint8List? capturedImage;

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

  Future<void> deleteService({required String id, required String imageUrl}) async {
    await _db.deleteHomeService(id: id, imageUrl: imageUrl).then((value){
      Get.back();
    });
  }

  Future<void> addData() async {
    if (titleC.text.length != 0 &&
        hospitalC.text.length != 0 &&
        facilitiesC.text.length != 0 &&
        feeC.text.length != 0 &&
        capturedImage!.isNotEmpty) {
      var mime = lookupMimeType('', headerBytes: capturedImage);
      var extension = extensionFromMime(mime!);
      if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
        addServiceButtonVisibility = false;
        progressVisibility = true;
        update();
        await _db
            .uploadImageFile(
            image: capturedImage!, imageTitle: titleC.text, path: 'nursing')
            .then((value) async => await _db
            .addHomeService(
            imageUrl: value, title: titleC.text, hospital: hospitalC.text, fee: int.parse(feeC.text), facilities: facilitiesC.text,
        )
            .then((_) {
          titleC.clear();
          hospitalC.clear();
          feeC.clear();
          facilitiesC.clear();
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
    if(titleC.text.length != 0 &&
        hospitalC.text.length != 0 &&
        facilitiesC.text.length != 0 &&
        feeC.text.length != 0) {
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

  Future<void> updateWithImage({required String id, required String imageUrl}) async {
    var mime = lookupMimeType('', headerBytes: capturedImage);
    var extension = extensionFromMime(mime!);
    if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
      await _db
          .uploadImageFile(
          image: capturedImage!, imageTitle: titleC.text, path: 'medicines')
          .then((value) async => await _db
          .updateHomeServiceAndImage(
        id: id, imageUrl: value, title: titleC.text, hospital: hospitalC.text, fee: int.parse(feeC.text), facilities: facilitiesC.text
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
        .updateHomeServiceDetailsOnly(
        id: id, title: titleC.text, hospital: hospitalC.text, fee: int.parse(feeC.text), facilities: facilitiesC.text
    );
    addServiceButtonVisibility = true;
    progressVisibility = false;
    update();
  }
}