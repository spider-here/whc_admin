import 'package:flutter/cupertino.dart';
import 'package:whc_admin/screens/addScreens/mobileView/mAddMedicineScreen.dart';

import 'desktopView/dAddMedicineScreen.dart';

class addMedicineScreen extends StatelessWidget{
  bool edit = false;
  String id = '';
  String name = '';
  String type = '';
  String strength = '';
  String description = '';
  String price = '';
  String imageUrl = '';
  bool inStock = false;

  addMedicineScreen({super.key});
  addMedicineScreen.edit({super.key, required this.id, required this.edit, required this.name, required this.type,
    required this.strength, required this.description, required this.price, required this.imageUrl, required this.inStock});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? mAddMedicineScreen.edit(edit: edit, id: id, name: name, type: type, strength: strength,
            description: description, price: price, imageUrl: imageUrl, inStock: inStock,)
        : mAddMedicineScreen();
      }
      else{
        return edit? dAddMedicineScreen.edit(edit: edit, id: id, name: name, type: type, strength: strength,
            description: description, price: price, imageUrl: imageUrl, inStock: inStock,)
        :dAddMedicineScreen();
      }
    });
  }

}