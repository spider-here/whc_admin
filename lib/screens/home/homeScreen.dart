import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/homeController.dart';
import 'desktopView/dHomeScreen.dart';
import 'mobileView/mHomeScreen.dart';

class homeScreen extends StatelessWidget{

  final homeController _getC = Get.put(homeController());

  homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mHomeScreen(_getC);
      }
      else{
        return dHomeScreen(_getC);
      }
    });
  }

}