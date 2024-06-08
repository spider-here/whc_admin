import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';

import '../database/database.dart';
import '../utils/constants.dart';

class AddMedicineController extends GetxController{
  RxBool medicineInStock = true.obs;
  RxBool addServiceButtonVisibility = true.obs;
  RxBool progressVisibility = false.obs;

  final Database _db = Database();

  final TextEditingController nameC = TextEditingController();
  final TextEditingController typeC = TextEditingController();
  final TextEditingController strengthC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  FileUploadInputElement uploadInput = FileUploadInputElement();

  RxList files = <File>[].obs;
  Rx<Uint8List?> capturedImage = Rx<Uint8List?>(Uint8List(0));

  Future<void> addData() async {
    try {
      if (nameC.text.isNotEmpty &&
          typeC.text.isNotEmpty &&
          strengthC.text.isNotEmpty &&
          priceC.text.isNotEmpty &&
          descriptionC.text.isNotEmpty &&
          capturedImage.value != null &&
          capturedImage.value!.isNotEmpty) {

        String name = nameC.text;
        String type = typeC.text;
        String strength = strengthC.text;
        String description = descriptionC.text;
        int price = int.parse(priceC.text);

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
              imageTitle: nameC.text,
              path: 'medicine',
            );

            if (imageUrl.isNotEmpty) {
              await _db.addMedicine(
                imageUrl: imageUrl,
                name: name,
                type: type,
                strength: strength,
                description: description,
                price: price,
                soldOut: !medicineInStock.value,
              ).then((_) {
                nameC.clear();
                typeC.clear();
                strengthC.clear();
                descriptionC.clear();
                priceC.clear();
                medicineInStock.value = true;
                capturedImage.value = null;
              }).onError((_, __) {
                addServiceButtonVisibility.value = true;
                progressVisibility.value = false;
                Get.snackbar(
                  "Error", "Problem adding data.",
                  backgroundColor: kWhite,
                );
              });
            } else {
              Get.snackbar(
                "Error", "Image URL is empty.",
                backgroundColor: kWhite,
              );
            }

            addServiceButtonVisibility.value = true;
            progressVisibility.value = false;
          } catch (e) {
            addServiceButtonVisibility.value = true;
            progressVisibility.value = false;
            Get.snackbar(
              "Error", "Problem adding data: ${e.toString()}",
              backgroundColor: kWhite,
            );
          }

        } else {
          Get.snackbar(
            "Error", "Only images with \".jpeg\" and \".png\" formats can be added.",
            backgroundColor: kWhite,
          );
        }
      } else if (capturedImage.value == null || capturedImage.value!.isEmpty) {
        Get.snackbar("Error", "Add Image",
          backgroundColor: kWhite,
        );
      } else {
        Get.snackbar(
          "Error", "Please fill all fields",
          backgroundColor: kWhite,
        );
      }
    } catch (e) {
      addServiceButtonVisibility.value = true;
      progressVisibility.value = false;
      Get.snackbar(
        "Error", "An unexpected error occurred: ${e.toString()}",
        backgroundColor: kWhite,
      );
    }
  }


  Future<void> updateData({required String id, required String imageUrl}) async {
    if(nameC.text.isNotEmpty &&
        typeC.text.isNotEmpty &&
        strengthC.text.isNotEmpty &&
        priceC.text.isNotEmpty &&
        descriptionC.text.isNotEmpty) {
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
          capturedImage.value = (reader
              .result as Uint8List?)!;
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

  Future<void> deleteMedicine({required String id, required String imageUrl}) async {
    await _db.deleteMedicine(id: id, imageUrl: imageUrl).then((value){
      Get.back();
    });
  }

  Future<void> updateWithImage({required String id, required String imageUrl}) async {
      var mime = lookupMimeType('', headerBytes: capturedImage.value);
      var extension = extensionFromMime(mime!);
      if(extension == 'jpe' || extension == 'jpg' || extension == 'png'){
        await _db
            .uploadImageFile(
            image: capturedImage.value!, imageTitle: nameC.text, path: 'medicines')
            .then((value) async => await _db
            .updateMedicineAndImage(
          id: id,
          imageUrl: value,
          name: nameC.text,
          type: typeC.text,
          strength: strengthC.text,
          description: descriptionC.text,
          price: int.parse(priceC.text),
          soldOut: !medicineInStock.value,
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
          .updateMedicineDetailsOnly(
          id: id,
          name: nameC.text,
          type: typeC.text,
          strength: strengthC.text,
          description: descriptionC.text,
          price: int.parse(priceC.text),
          soldOut: !medicineInStock.value
      );
      addServiceButtonVisibility.value = true;
      progressVisibility.value = false;
    }
  }