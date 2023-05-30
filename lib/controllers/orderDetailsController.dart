import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../database/database.dart';

class orderDetailsController extends GetxController{

  final statusText = [
    'Pending',
    'Accepted',
    'On the Way',
    'Completed',
  ];

  final database _db = database();
  RxBool updateButtonVisibility = false.obs;
  RxBool updateStatusVisibility = false.obs;
  RxInt dropDownMenuValue = 0.obs;

  String getDateTime(Timestamp timestamp) {
    final Timestamp ts = timestamp;
    final DateTime dateTime = ts.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    final dateString = dateTime.toString();
    return dateString;
  }

  int getOrderStatusIndex(String snapshot) {
    if (snapshot == "Accepted") {
      dropDownMenuValue.value = 1;
      return 1;
    } else if (snapshot == "On the Way") {
      dropDownMenuValue.value = 2;
      return 2;
    } else if (snapshot == "Completed") {
      dropDownMenuValue.value = 3;
      return 3;
    } else {
      dropDownMenuValue.value = 0;
      return 0;
    }
  }

  updateOrderStatus({required String orderID, required String status}){
    updateButtonVisibility.value = false;
    _db.updateOrderStatus(orderID: orderID, status: status).then((value){
      updateButtonVisibility.value = false;
    }).catchError((){
      Get.snackbar("Error", "Problem: Status not updated.");
      updateButtonVisibility.value = true;
    });
  }

}
