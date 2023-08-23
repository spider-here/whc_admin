import 'package:flutter/cupertino.dart';

import 'desktopView/d_dashboard_screen.dart';
import 'mobileView/m_dashboard_screen.dart';


class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MDashboardScreen();
      }
      else{
        return DDashboardScreen();
      }
    });
  }

}