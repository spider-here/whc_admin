import 'package:flutter/cupertino.dart';

import 'desktopView/dDoctorsScreen.dart';
import 'mobileView/mDoctorsScreen.dart';

class doctorsScreen extends StatelessWidget{
  const doctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mDoctorsScreen();
      }
      else{
        return dDoctorsScreen();
      }
    });
  }

}