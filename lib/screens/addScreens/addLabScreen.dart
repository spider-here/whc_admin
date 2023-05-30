
import 'package:flutter/material.dart';
import 'package:whc_admin/screens/addScreens/desktopView/dAddLabScreen.dart';
import 'package:whc_admin/screens/addScreens/mobileView/mAddLabScreen.dart';

class addLabScreen extends StatelessWidget {

  bool edit = false;
  String id = "";
  String labName = "";
  String address = "";
  String phoneNumber = "";

  addLabScreen({super.key});
  addLabScreen.edit({super.key, required this.edit, required this.id,  required this.labName,
    required this.address,  required this.phoneNumber,});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? mAddLabScreen.edit(edit: edit, id: id, labName: labName, address: address, phoneNumber: phoneNumber) : mAddLabScreen();
      }
      else{
        return edit? dAddLabScreen.edit(edit: edit, id: id, labName: labName, address: address, phoneNumber: phoneNumber) : dAddLabScreen();
      }
    });
  }
}
