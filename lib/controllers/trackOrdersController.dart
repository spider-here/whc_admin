import 'package:get/get.dart';

class trackOrdersController extends GetxController {
  int radioGroupValue = 0;
  String searchText = "";

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



}
