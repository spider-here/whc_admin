import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/home_controller.dart';

import '../../../database/authentication.dart';
import '../../../utils/constants.dart';
import '../track_order_screen.dart';
import 'm_dashboard_screen.dart';
import 'm_doctors_screen.dart';
import 'm_home_services_screen.dart';
import 'm_lab_tests_screen.dart';
import 'm_medicines_screen.dart';

class MHomeScreen extends StatelessWidget {
  final HomeController _getC;

  MHomeScreen(this._getC, {super.key});

  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(
              () => Text(_getC.drawerItems[_getC.drawerSelectedIndex.value])),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: kWhite,
              onPressed: () {
                _auth.signOutUser();
              },
            ),
          ],
        ),
        drawer: NavigationDrawer(
          backgroundColor: kWhite,
          selectedIndex: _getC.drawerSelectedIndex.value,
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logoFull.png"),
            ),
            Obx(
              () => ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: _getC.drawerItems[_getC.drawerSelectedIndex.value] ==
                          _getC.drawerItems[0]
                      ? kWhite
                      : kPrimarySwatch,
                ),
                title: Text(_getC.drawerItems[0],
                    style: _getC.drawerSelectedIndex.value == 0
                        ? const TextStyle(color: kWhite)
                        : const TextStyle(color: kBlack)),
                tileColor: _getC.drawerSelectedIndex.value == 0
                    ? kPrimarySwatch
                    : Colors.transparent,
                onTap: () => _getC.updateDrawer(index: 0, isMobile: true),
              ),
            ),
            Obx(() => ListTile(
                  leading: Image.asset(
                    "assets/images/maleDoctor.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: Text(_getC.drawerItems[1],
                      style: _getC.drawerSelectedIndex.value == 1
                          ? const TextStyle(color: kWhite)
                          : const TextStyle(color: kBlack)),
                  tileColor: _getC.drawerSelectedIndex.value == 1
                      ? kPrimarySwatch
                      : Colors.transparent,
                  onTap: () => _getC.updateDrawer(index: 1, isMobile: true),
                )),
            Obx(() => ListTile(
                  leading: Image.asset(
                    "assets/images/Capsule.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: Text(_getC.drawerItems[2],
                      style: _getC.drawerSelectedIndex.value == 2
                          ? const TextStyle(color: kWhite)
                          : const TextStyle(color: kBlack)),
                  tileColor: _getC.drawerSelectedIndex.value == 2
                      ? kPrimarySwatch
                      : Colors.transparent,
                  onTap: () => _getC.updateDrawer(index: 2, isMobile: true),
                )),
            Obx(() => ListTile(
                  leading: Image.asset(
                    "assets/images/labIcon.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: Text(_getC.drawerItems[3],
                      style: _getC.drawerSelectedIndex.value == 3
                          ? const TextStyle(color: kWhite)
                          : const TextStyle(color: kBlack)),
                  tileColor: _getC.drawerSelectedIndex.value == 3
                      ? kPrimarySwatch
                      : Colors.transparent,
                  onTap: () => _getC.updateDrawer(index: 3, isMobile: true),
                )),
            Obx(() => ListTile(
                  leading: Image.asset(
                    "assets/images/homeService.png",
                    width: 24.0,
                    height: 24.0,
                  ),
                  title: Text(_getC.drawerItems[4],
                      style: _getC.drawerSelectedIndex.value == 4
                          ? const TextStyle(color: kWhite)
                          : const TextStyle(color: kBlack)),
                  tileColor: _getC.drawerSelectedIndex.value == 4
                      ? kPrimarySwatch
                      : Colors.transparent,
                  onTap: () => _getC.updateDrawer(index: 4, isMobile: true),
                )),
            Obx(() => ListTile(
                  leading: Icon(
                    Icons.search,
                    color: _getC.drawerItems[_getC.drawerSelectedIndex.value] ==
                            _getC.drawerItems[5]
                        ? kWhite
                        : kPrimarySwatch,
                  ),
                  title: Text(_getC.drawerItems[5],
                      style: _getC.drawerSelectedIndex.value == 5
                          ? const TextStyle(color: kWhite)
                          : const TextStyle(color: kBlack)),
                  tileColor: _getC.drawerSelectedIndex.value == 5
                      ? kPrimarySwatch
                      : Colors.transparent,
                  onTap: () => _getC.updateDrawer(index: 5, isMobile: true),
                )),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _getC.pageController,
            children: [
              MDashboardScreen(),
              MDoctorsScreen(),
              MMedicinesScreen(),
              MLabTestsScreen(),
              MHomeServicessScreen(),
              const TrackOrderScreen()
            ],
          ),
        ));
  }
}
