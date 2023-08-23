import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorDetailsController extends GetxController{
  RxBool doctorApproved = true.obs;
  RxBool doctorPopular = true.obs;
  RxBool updateButtonVisibility = true.obs;
  RxBool progressVisibility = false.obs;

  String getDateTime(Timestamp timestamp) {
    final Timestamp ts = timestamp;
    final DateTime dateTime = ts.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    final dateString = dateTime.toString();
    return dateString;
  }
}