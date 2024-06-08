
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../database/database.dart';
import '../utils/constants.dart';

class AddServiceController extends GetxController{
  RxBool addServiceButtonVisibility = true.obs;
  RxBool progressVisibility = false.obs;
  final Database _db = Database();
  
  final TextEditingController titleC = TextEditingController();
  final TextEditingController hospitalC = TextEditingController();
  final TextEditingController facilitiesC = TextEditingController();
  final TextEditingController feeC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  RxList files = <File>[].obs;
  Rx<Uint8List?> capturedImage = Rx<Uint8List?>(Uint8List(0));

  void viewImageFromDevice(){
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      files.assignAll(uploadInput.files!);
      if (files.length == 1) {
        final file = files[0];
        FileReader reader =
        FileReader();
        reader.onLoadEnd.listen((e) {
          capturedImage.value = reader
              .result as Uint8List?;
        });

        reader.onError
            .listen((fileEvent) {
          const Text(
              "Some Error occured while reading the file");
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
    try {
      if (titleC.text.isNotEmpty &&
          hospitalC.text.isNotEmpty &&
          facilitiesC.text.isNotEmpty &&
          feeC.text.isNotEmpty &&
          capturedImage.value != null &&
          capturedImage.value!.isNotEmpty) {
        int fee = int.parse(feeC.text);
        String title = titleC.text;
        String hospital = titleC.text;
        String facilities = titleC.text;

        var mime = lookupMimeType('', headerBytes: capturedImage.value!);
        if (mime == null) {
          throw Exception("MIME type is null");
        }
        var extension = extensionFromMime(mime);
        if (extension == 'jpe' || extension == 'jpg' || extension == 'png') {
          addServiceButtonVisibility.value = false;
          progressVisibility.value = true;

          try {
            String imageUrl = await _db.uploadImageFile(
                image: capturedImage.value!,
                imageTitle: titleC.text,
                path: 'nursing'
            );

            if(imageUrl.isNotEmpty){
              await _db.addHomeService(
                imageUrl: imageUrl,
                title: title,
                hospital: hospital,
                fee: fee,
                facilities: facilities,
              ).then((value){
                titleC.clear();
                hospitalC.clear();
                feeC.clear();
                facilitiesC.clear();
                files.value = [];
                capturedImage.value = null;
              });
            }
            else{
              Get.snackbar(
                  "Error", "Image URL is empty.",
                  backgroundColor: kWhite
              );
            }

            addServiceButtonVisibility.value = true;
            progressVisibility.value = false;
          } catch (e) {
            addServiceButtonVisibility.value = true;
            progressVisibility.value = false;
            Get.snackbar(
                "Error", "Problem adding data: ${e.toString()}",
                backgroundColor: kWhite
            );
          }

        } else {
          Get.snackbar(
              "Error", "Only images with \".jpeg\" and \".png\" formats can be added.",
              backgroundColor: kWhite
          );
        }
      } else if (capturedImage.value == null || capturedImage.value!.isEmpty) {
        Get.snackbar("Error", "Add Image",
            backgroundColor: kWhite
        );
      } else {
        Get.snackbar(
            "Error", "Please fill all fields",
            backgroundColor: kWhite
        );
      }
    } catch (e) {
      addServiceButtonVisibility.value = true;
      progressVisibility.value = false;
      Get.snackbar(
          "Error", "An unexpected error occurred: ${e.toString()}",
          backgroundColor: kWhite
      );
    }
  }


  Future<void> updateData({required String id, required String imageUrl}) async {
    if(titleC.text.isNotEmpty &&
        hospitalC.text.isNotEmpty &&
        facilitiesC.text.isNotEmpty &&
        feeC.text.isNotEmpty) {
      addServiceButtonVisibility.value = false;
      progressVisibility.value = true;
      if (capturedImage.value!.isNotEmpty) {
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
    addServiceButtonVisibility.value = true;
    progressVisibility.value = false;
  }

  Future<void> updateWithImage({required String id, required String imageUrl}) async {
    var mime = lookupMimeType('', headerBytes: capturedImage.value);
    var extension = extensionFromMime(mime!);
    if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
      await _db
          .uploadImageFile(
          image: capturedImage.value!, imageTitle: titleC.text, path: 'medicines')
          .then((value) async => await _db
          .updateHomeServiceAndImage(
        id: id, imageUrl: value, title: titleC.text, hospital: hospitalC.text, fee: int.parse(feeC.text), facilities: facilitiesC.text
      ).then((value) async => await _db.deleteImage(imageUrl: imageUrl))
          .then((_) {
        Get.back();
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
    addServiceButtonVisibility.value = true;
    progressVisibility .value= false;
  }
}