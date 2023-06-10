import 'package:flutter/cupertino.dart';

import 'desktopView/dAddServiceScreen.dart';
import 'mobileView/mAddServiceScreen.dart';

class addServiceScreen extends StatelessWidget{
  bool edit = false;
  String id = '';
  String title = '';
  String imageUrl = '';
  String hospital = '';
  String fee = '';
  String facilities = '';


  addServiceScreen({super.key});
  addServiceScreen.edit({super.key, required this.edit,  required this.id,
    required this.title,  required this.imageUrl,  required this.hospital,  required this.fee,  required this.facilities});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? mAddServiceScreen.edit(edit: edit, id: id, title: title, imageUrl: imageUrl, hospital: hospital, fee: fee, facilities: facilities)
            : mAddServiceScreen();
      }
      else{
        return edit? dAddServiceScreen.edit(edit: edit, id: id, title: title, imageUrl: imageUrl, hospital: hospital, fee: fee, facilities: facilities)
        : dAddServiceScreen();
      }
    });
  }

}