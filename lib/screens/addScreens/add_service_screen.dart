import 'package:flutter/cupertino.dart';

import 'desktopView/d_add_service_screen.dart';
import 'mobileView/m_add_service_screen.dart';

class AddServiceScreen extends StatelessWidget{
  bool edit = false;
  String id = '';
  String title = '';
  String imageUrl = '';
  String hospital = '';
  String fee = '';
  String facilities = '';


  AddServiceScreen({super.key});
  AddServiceScreen.edit({super.key, required this.edit,  required this.id,
    required this.title,  required this.imageUrl,  required this.hospital,  required this.fee,  required this.facilities});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? AAddServiceScreen.edit(edit: edit, id: id, title: title, imageUrl: imageUrl, hospital: hospital, fee: fee, facilities: facilities)
            : AAddServiceScreen();
      }
      else{
        return edit? DAddServiceScreen.edit(edit: edit, id: id, title: title, imageUrl: imageUrl, hospital: hospital, fee: fee, facilities: facilities)
        : DAddServiceScreen();
      }
    });
  }

}