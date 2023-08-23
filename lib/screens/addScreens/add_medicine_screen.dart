import 'package:flutter/cupertino.dart';
import 'package:whc_admin/screens/addScreens/mobileView/m_add_medicine_screen.dart';

import 'desktopView/d_add_medicine_screen.dart';

class AddMedicineScreen extends StatelessWidget{
  bool edit = false;
  String id = '';
  String name = '';
  String type = '';
  String strength = '';
  String description = '';
  String price = '';
  String imageUrl = '';
  bool inStock = false;

  AddMedicineScreen({super.key});
  AddMedicineScreen.edit({super.key, required this.id, required this.edit, required this.name, required this.type,
    required this.strength, required this.description, required this.price, required this.imageUrl, required this.inStock});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? MAddMedicineScreen.edit(edit: edit, id: id, name: name, type: type, strength: strength,
            description: description, price: price, imageUrl: imageUrl, inStock: inStock,)
        : MAddMedicineScreen();
      }
      else{
        return edit? DAddMedicineScreen.edit(edit: edit, id: id, name: name, type: type, strength: strength,
            description: description, price: price, imageUrl: imageUrl, inStock: inStock,)
        :DAddMedicineScreen();
      }
    });
  }

}