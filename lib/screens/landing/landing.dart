import 'package:flutter/cupertino.dart';

import 'desktopView/d_login.dart';
import 'mobileView/m_login.dart';

class Landing extends StatelessWidget{
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MLogin();
      }
      else{
        return DLogin();
      }
    });
  }
  
}