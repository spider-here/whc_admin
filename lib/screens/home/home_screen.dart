import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'desktopView/d_home_screen.dart';
import 'mobileView/m_home_screen.dart';

class HomeScreen extends StatelessWidget{

  final HomeController _getC = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MHomeScreen(_getC);
      }
      else{
        return DHomeScreen(_getC);
      }
    });
  }

}