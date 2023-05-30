import 'package:flutter/cupertino.dart';

import 'desktopView/dLogin.dart';
import 'mobileView/mLogin.dart';

class landing extends StatelessWidget{
  const landing({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mLogin();
      }
      else{
        return dLogin();
      }
    });
  }
  
}