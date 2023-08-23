import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TrackOrdersController extends GetxController {
  int radioGroupValue = 0;
  String searchText = "";
  bool searchTrigger = false;
  final TextEditingController searchC = TextEditingController();

  final filterText = [
    'All',
    'Pending',
    'Accepted',
    'On the Way',
    'Completed',
  ];

  radioOnChanged(int value) {
    radioGroupValue = value;
  }

  String getDateTime(Timestamp timestamp) {
    final Timestamp ts = timestamp;
    final DateTime dateTime = ts.toDate();
    // final dateString = DateFormat('K:mm:ss').format(dateTime);
    final dateString = dateTime.toString();
    return dateString;
  }

}
