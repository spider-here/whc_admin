import 'package:flutter/cupertino.dart';

import 'desktopView/dHomeServicesScreen.dart';
import 'mobileView/mHomeServicesScreen.dart';

class homeServicesScreen extends StatelessWidget{
  const homeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mHomeServicessScreen();
      }
      else{
        return dHomeServicesScreen();
      }
    });
  }

}