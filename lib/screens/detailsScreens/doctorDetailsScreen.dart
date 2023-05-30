import 'package:flutter/cupertino.dart';

import 'desktopView/dDoctorDetailsScreen.dart';
import 'mobileView/mDoctorDetailsScreen.dart';

class doctorDetailsScreen extends StatelessWidget{
  String doctorID;

  doctorDetailsScreen({super.key, required this.doctorID});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mDoctorDetailsScreen(doctorID: doctorID,);
      }
      else{
        return dDoctorDetailsScreen(doctorID: doctorID,);
      }
    });
  }
}