import 'package:flutter/cupertino.dart';

import 'desktopView/dDashboardScreen.dart';
import 'mobileView/mDashboardScreen.dart';


class dashboardScreen extends StatelessWidget{
  const dashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mDashboardScreen();
      }
      else{
        return dDashboardScreen();
      }
    });
  }

}