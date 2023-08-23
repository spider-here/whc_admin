
import 'package:flutter/material.dart';
import 'package:whc_admin/screens/addScreens/desktopView/d_add_lab_screen.dart';
import 'package:whc_admin/screens/addScreens/mobileView/m_add_lab_screen.dart';

class AddLabScreen extends StatelessWidget {

  bool edit = false;
  String id = "";
  String labName = "";
  String address = "";
  String phoneNumber = "";

  AddLabScreen({super.key});
  AddLabScreen.edit({super.key, required this.edit, required this.id,  required this.labName,
    required this.address,  required this.phoneNumber,});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? MAddLabScreen.edit(edit: edit, id: id, labName: labName, address: address, phoneNumber: phoneNumber) : MAddLabScreen();
      }
      else{
        return edit? DAddLabScreen.edit(edit: edit, id: id, labName: labName, address: address, phoneNumber: phoneNumber) : DAddLabScreen();
      }
    });
  }
}
