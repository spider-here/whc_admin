
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppSearchController extends GetxController{
  RxString searchText = ''.obs;
  RxBool searchTrigger = false.obs;
  final TextEditingController searchTextC = TextEditingController();

  clearSearch(){
    searchText.value = '';
    searchTextC.text = '';
    searchTrigger.value = false;
  }

}