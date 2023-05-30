import 'package:flutter/cupertino.dart';

import 'desktopView/dLabTestsScreen.dart';
import 'mobileView/mLabTestsScreen.dart';

class labTestsScreen extends StatelessWidget{
  const labTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mLabTestsScreen();
      }
      else{
        return dLabTestsScreen();
      }
    });
  }

}