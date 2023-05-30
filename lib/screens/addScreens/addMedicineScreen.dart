import 'package:flutter/cupertino.dart';
import 'package:whc_admin/screens/addScreens/mobileView/mAddMedicineScreen.dart';

import 'desktopView/dAddMedicineScreen.dart';

class addMedicineScreen extends StatelessWidget{
  const addMedicineScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mAddMedicineScreen();
      }
      else{
        return dAddMedicineScreen();
      }
    });
  }

}