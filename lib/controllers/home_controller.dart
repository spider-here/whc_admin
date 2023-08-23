import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxInt drawerSelectedIndex = 0.obs;
  PageController pageController = PageController();
  SideMenuController sideMenuController = SideMenuController();

  List<String> drawerItems = [
    "Dashboard",
    "Doctors",
    "Medicines",
    "Lab Tests",
    "Home Services",
    "Track Orders"
  ];

  void updateDrawer({required int index, required bool isMobile}){

    if(isMobile && index!=drawerSelectedIndex){
      drawerSelectedIndex.value = index;
      pageController.jumpToPage(index);
      Get.back();
      update();
    }
    else{
      drawerSelectedIndex.value = index;
      sideMenuController.changePage(index);
      pageController.jumpToPage(index);
      update();
    }
  }
}