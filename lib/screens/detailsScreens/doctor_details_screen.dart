import 'package:flutter/cupertino.dart';

import 'desktopView/d_doctor_details_screen.dart';
import 'mobileView/m_doctor_details_screen.dart';

class DoctorDetailsScreen extends StatelessWidget{
  final String doctorID;

  const DoctorDetailsScreen({super.key, required this.doctorID});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MDoctorDetailsScreen(doctorID: doctorID,);
      }
      else{
        return DDoctorDetailsScreen(doctorID: doctorID,);
      }
    });
  }
}