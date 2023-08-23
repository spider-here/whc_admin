import 'package:flutter/cupertino.dart';

import 'desktopView/d_doctors_screen.dart';
import 'mobileView/m_doctors_screen.dart';

class DoctorsScreen extends StatelessWidget{
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MDoctorsScreen();
      }
      else{
        return DDoctorsScreen();
      }
    });
  }

}