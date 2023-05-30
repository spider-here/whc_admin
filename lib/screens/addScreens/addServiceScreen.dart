import 'package:flutter/cupertino.dart';

import 'desktopView/dAddServiceScreen.dart';
import 'mobileView/mAddServiceScreen.dart';

class addServiceScreen extends StatelessWidget{
  const addServiceScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mAddServiceScreen();
      }
      else{
        return dAddServiceScreen();
      }
    });
  }

}