import 'package:flutter/cupertino.dart';

import 'desktopView/d_home_services_screen.dart';
import 'mobileView/m_home_services_screen.dart';

class HomeServicesScreen extends StatelessWidget{
  const HomeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MHomeServicessScreen();
      }
      else{
        return DHomeServicesScreen();
      }
    });
  }

}