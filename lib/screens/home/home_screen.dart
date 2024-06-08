import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/confirmation_dialog.dart';
import 'package:whc_admin/database/authentication.dart';
import '../../controllers/home_controller.dart';
import '../../utils/constants.dart';


class HomeScreen extends StatelessWidget{
  final Authentication _auth = Authentication();
  final HomeController _getC = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        bool isMobile = constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0;
      if(isMobile){
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
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _getC.pageController,
              children: _getC.pages,
            ));
      }
      else{
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
                          height: constraints.maxHeight/1.6,
                          width: constraints.maxWidth >= 1000.0 ? constraints.maxWidth/7.6 : 50.0,
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
                                openSideMenuWidth: constraints.maxWidth/7.6,
                                compactSideMenuWidth: 50.0,
                                selectedColor: kPrimaryColor,
                                selectedTitleTextStyle: const TextStyle(color: kWhite, fontSize: 16.0),
                                unselectedTitleTextStyle: const TextStyle(color: kBlack, fontSize: 14.0),
                                selectedIconColor: kWhite,
                                unselectedIconColor: kBlack,
                              itemBorderRadius: BorderRadius.zero
                            ),
                          ),

                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _getC.pageController,
                        children: _getC.pages
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: FractionalOffset.topRight,
                  child: Card(
                    elevation: 1.0,
                    surfaceTintColor: kWhite,
                    margin: const EdgeInsets.only(right: 20.0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero
                    ),
                    color: kWhite,
                    child: InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (_){
                          return ConfirmationDialog(message: 'Are you sure you want to logout?', onConfirm: (){
                            _auth.signOutUser();
                          });
                        });},
                      child: Container(
                          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                          height: 30.0,
                          width: 100.0,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, size: 18.0, color: kRed,),
                              Padding(padding: EdgeInsets.only(left: 5.0)),
                              Text("Logout", style: TextStyle(fontSize: 14.0, color: kRed),),
                            ],
                          )
                      ),
                    ),
                  ),
                )]
          ),
        );
      }
    });
  }
}