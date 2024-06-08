import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/app_search_controller.dart';

import '../screens/home/dashboard_screen.dart';
import '../screens/home/doctors_screen.dart';
import '../screens/home/home_services_screen.dart';
import '../screens/home/lab_tests_screen.dart';
import '../screens/home/medicines_screen.dart';
import '../screens/home/track_order_screen.dart';

class HomeController extends GetxController{

  RxInt drawerSelectedIndex = 0.obs;
  PageController pageController = PageController();
  SideMenuController sideMenuController = SideMenuController();
  AppSearchController searchC = Get.put(AppSearchController());

  List<String> drawerItems = [
    "Dashboard",
    "Doctors",
    "Medicines",
    "Lab Tests",
    "Home Services",
    "Track Orders"
  ];

  final List<Widget> pages = [
    DashboardScreen(),
    const DoctorsScreen(),
    const MedicinesScreen(),
    const LabTestsScreen(),
    const HomeServicesScreen(),
    const TrackOrderScreen()
  ];

  void updateDrawer({required int index, required bool isMobile}){
    searchC.clearSearch();
    drawerSelectedIndex.value = index;
    sideMenuController.changePage(index);
    pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    if(isMobile){
      Get.back();
    }
    update();
  }
}