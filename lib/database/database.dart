import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {

  Future<void> addLab(
      {required String labName,
      required String address,
      required int phoneNumber}) async {
    final DocumentReference<Map<String, dynamic>> labsRef =
        FirebaseFirestore.instance.collection('labs').doc();
    return await labsRef.set({
      'lId': labsRef.id.trim(),
      'name': labName.trim(),
      'address': address.trim(),
      'phoneNumber': phoneNumber
    });
  }

  Future<void> updateLab(
      {required String labID,
      required String labName,
        required String address,
        required int phoneNumber}) async {
    final CollectionReference labsRef =
    FirebaseFirestore.instance.collection('labs');
    return await labsRef.doc(labID).update({
      'name': labName.trim(),
      'address': address.trim(),
      'phoneNumber': phoneNumber
    });
  }

   Future<void> deleteLab(
      {required String labID}) async {
    final CollectionReference labsRef =
    FirebaseFirestore.instance.collection('labs');
    return await labsRef.doc(labID).delete();
  }

  Future<void> addLabTest(
      {required DocumentReference<Map<String, dynamic>> labTestRef ,
        required String testName,
      required String sampleType,
      required String type,
      required String testFor,
      required int fee}) async {
    return await labTestRef.set({
      'ltId': labTestRef.id.trim(),
      'name': testName.trim(),
      'sampleType': sampleType.trim(),
      'testFor': testFor.trim(),
      'type': type.trim(),
      'fee': fee
    });
  }

  Future<void> updateLabTest(
      {required String id,
        required String testName,
      required String sampleType,
      required String type,
      required String testFor,
      required int fee}) async {
    final CollectionReference labTestRef =
    FirebaseFirestore.instance.collection('labTests');
    return await labTestRef.doc(id).update({
      'name': testName.trim(),
      'sampleType': sampleType.trim(),
      'testFor': testFor.trim(),
      'type': type.trim(),
      'fee': fee
    });
  }

  Future<void> deleteLabTest(
      {required String id}) async {
    final CollectionReference labsRef =
    FirebaseFirestore.instance.collection('labTests');
    return await labsRef.doc(id).delete();
  }

  Future<void> addLabsForLabtest(
      {required String labId,
        required String labTestId,
      required String labName,
        required String address,
        required int phoneNumber}) async {
    final DocumentReference<Map<String, dynamic>> labTestLabsRef =
    FirebaseFirestore.instance.collection('labTests').doc(labTestId).collection('labs').doc(labTestId);
    return await labTestLabsRef.set({
      'ltId': labId.trim(),
      'name': labName.trim(),
      'address': address.trim(),
      'phoneNumber': phoneNumber
    });
  }

  Future<void> updateOrderStatus(
      {required String orderID, required String status}) async {
    final CollectionReference ordersRef =
        FirebaseFirestore.instance.collection('orders');
    return await ordersRef.doc(orderID).update({'status': status.trim()});
  }

  Future<void> addHomeService(
      {required String imageUrl,
      required String title,
      required String hospital,
      required int fee,
      required String facilities}) async {
    final DocumentReference<Map<String, dynamic>> homeServiceRef =
        FirebaseFirestore.instance.collection('nursing').doc();
    return await homeServiceRef.set({
      'nId': homeServiceRef.id.trim(),
      'image': imageUrl.trim(),
      'title': title.trim(),
      'hospital': hospital.trim(),
      'fee': fee,
      'facilities': facilities.trim()
    });
  }

  Future<void> addMedicine(
      {required String imageUrl,
      required String name,
      required String type,
      required String strength,
      required String description,
        required int price,
      required bool soldOut}) async {
    final DocumentReference<Map<String, dynamic>> medicinesRef =
        FirebaseFirestore.instance.collection('medicines').doc();
    return await medicinesRef.set({
      'mId': medicinesRef.id.trim(),
      'image': imageUrl.trim(),
      'name': name.trim(),
      'type': type.trim(),
      'strength': strength.trim(),
      'soldOut': soldOut,
      'pricePerPack': price,
      'description': description.trim()
    });
  }

  Future<void> updateMedicineAndImage(
      {required String id,
        required String imageUrl,
      required String name,
      required String type,
      required String strength,
      required String description,
        required int price,
      required bool soldOut}) async {
    final CollectionReference<Map<String, dynamic>> medicinesRef =
        FirebaseFirestore.instance.collection('medicines');
    return await medicinesRef.doc(id).update({
      'image': imageUrl.trim(),
      'name': name.trim(),
      'type': type.trim(),
      'strength': strength.trim(),
      'soldOut': soldOut,
      'pricePerPack': price,
      'description': description.trim()
    });
  }

  Future<void> updateMedicineDetailsOnly(
      {required String id,
      required String name,
      required String type,
      required String strength,
      required String description,
        required int price,
      required bool soldOut}) async {
    final DocumentReference<Map<String, dynamic>> medicinesRef =
        FirebaseFirestore.instance.collection('medicines').doc(id);
    return await medicinesRef.update({
      'name': name.trim(),
      'type': type.trim(),
      'strength': strength.trim(),
      'soldOut': soldOut,
      'pricePerPack': price,
      'description': description.trim()
    });
  }

  Future<void> updateHomeServiceDetailsOnly({
    required String id,
    required String title,
    required String hospital,
    required String facilities,
    required int fee,
  }) async {
    final DocumentReference<Map<String, dynamic>> servRef =
    FirebaseFirestore.instance.collection('nursing').doc(id);
    await servRef.update({
      'title': title.trim(),
      'hospital': hospital.trim(),
      'fee': fee,
      'facilities': facilities.trim(),
    });
  }

  Future<void> updateHomeServiceAndImage({
    required String id,
    required String imageUrl,
    required String title,
    required String hospital,
    required String facilities,
    required int fee,
  }) async {
    final DocumentReference<Map<String, dynamic>> servRef =
    FirebaseFirestore.instance.collection('nursing').doc(id);
    await servRef.update({
      'image': imageUrl.trim(),
      'title': title.trim(),
      'hospital': hospital.trim(),
      'fee': fee,
      'facilities': facilities.trim(),
    });
  }
  

  Future<void> deleteMedicine({required String id, required String imageUrl}) async {
    final CollectionReference medRef =
    FirebaseFirestore.instance.collection('medicines');
    return await medRef.doc(id).delete().then((value) => deleteImage(imageUrl: imageUrl));
  }
  
  Future<void> deleteHomeService({required String id, required String imageUrl}) async {
    final CollectionReference servRef =
    FirebaseFirestore.instance.collection('nursing');
    return await servRef.doc(id).delete().then((value) => deleteImage(imageUrl: imageUrl));
  }

  Future<void> deleteImage({required String imageUrl}) async {
   await FirebaseStorage.instance.refFromURL(imageUrl).delete();
  }

  Future<void> updateDoctor({required String doctorID, required bool isApproved, required bool isPopular}) async {
    final CollectionReference doctorRef =
    FirebaseFirestore.instance.collection('doctors');
    return await doctorRef.doc(doctorID).update({'isApproved': isApproved, 'isPopular': isPopular});
  }

  Future<String> uploadImageFile(
      {required Uint8List? image, required String imageTitle, required String path}) async {
    final Reference imagesRef =
        FirebaseStorage.instance.ref('$path/$imageTitle');
    TaskSnapshot imageUpload = await imagesRef.putData(
        image!, SettableMetadata(contentType: 'image/jpeg'));

    return imageUpload.ref.getDownloadURL();
  }

}
