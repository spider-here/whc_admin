
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:whc_admin/controllers/home_controller.dart';

import '../../../database/authentication.dart';
import '../../../utils/constants.dart';
import '../dashboard_screen.dart';
import '../doctors_screen.dart';
import '../home_services_screen.dart';
import '../lab_tests_screen.dart';
import '../medicines_screen.dart';
import '../track_order_screen.dart';

class DHomeScreen extends StatelessWidget{

  final HomeController _getC;

  DHomeScreen(this._getC, {super.key});

  final Authentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: FractionalOffset.topLeft,
            child: Container(
              height: 200.0,
              width: 220.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logoFull.png",),
                  fit: BoxFit.fitWidth
                )
              ),
            )
          ),
          Row(
            children: [
              Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.6,
                    width: MediaQuery.of(context).size.width >= 1000.0 ? MediaQuery.of(context).size.width/7.6 : 50.0,
                    child:
                    SideMenu(
                      items: [
                      SideMenuItem(priority: 0,
                        title: _getC.drawerItems[0],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        icon: const Icon(Icons.dashboard, color: kPrimarySwatch,),),
                      SideMenuItem(priority: 1,
                        title: _getC.drawerItems[1],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        iconWidget: Image.asset("assets/images/maleDoctor.png", width: 24.0, height: 24.0,),),
                      SideMenuItem(priority: 2,
                        title: _getC.drawerItems[2],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        iconWidget: Image.asset("assets/images/Capsule.png", width: 24.0, height: 24.0,),),
                      SideMenuItem(priority: 3,
                        title: _getC.drawerItems[3],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        iconWidget: Image.asset("assets/images/labIcon.png", width: 24.0, height: 24.0,),),
                      SideMenuItem(priority: 4,
                        title: _getC.drawerItems[4],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        iconWidget: Image.asset("assets/images/homeService.png", width: 24.0, height: 24.0,),),
                      SideMenuItem(priority: 5,
                        title: _getC.drawerItems[5],
                        onTap: (page, _){
                          _getC.updateDrawer(index: page, isMobile: false);
                        },
                        icon: const Icon(Icons.search, color: kPrimarySwatch,),),
                    ],
                      controller: _getC.sideMenuController, collapseWidth: 1000,
                      style: SideMenuStyle(
                        displayMode: SideMenuDisplayMode.auto,
                        openSideMenuWidth: MediaQuery.of(context).size.width/7.6,
                        compactSideMenuWidth: 50.0,
                        selectedColor: kPrimaryColor,
                        selectedTitleTextStyle: const TextStyle(color: kWhite, fontSize: 16.0),
                        unselectedTitleTextStyle: const TextStyle(color: kBlack, fontSize: 14.0),
                        selectedIconColor: kWhite,
                        unselectedIconColor: kBlack
                      ),
                    ),

                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _getC.pageController,
                  children: const [
                    DashboardScreen(),
                    DoctorsScreen(),
                    MedicinesScreen(),
                    LabTestsScreen(),
                    HomeServicesScreen(),
                    TrackOrderScreen()
                  ],
                ),
              )
            ],
        ),
        Align(
          alignment: FractionalOffset.topRight,
          child: Card(
              elevation: 2.0,
              margin: const EdgeInsets.only(right: 20.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0))
              ),
              color: kCanvasColor,
              child: InkWell(
                onTap: () {
                  _auth.signOutUser();},
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
                  ),
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  height: 30.0,
                  width: 100.0,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 18.0,),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text("Logout", style: TextStyle(fontSize: 16.0),),
                    ],
                  )
              ),
            ),
          ),
        )]
      ),
    );
  }

}



