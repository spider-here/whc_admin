import 'package:flutter/cupertino.dart';

import 'desktopView/d_lab_tests_screen.dart';
import 'mobileView/m_lab_tests_screen.dart';

class LabTestsScreen extends StatelessWidget{
  const LabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MLabTestsScreen();
      }
      else{
        return DLabTestsScreen();
      }
    });
  }

}