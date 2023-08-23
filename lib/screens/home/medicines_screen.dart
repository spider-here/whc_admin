import 'package:flutter/cupertino.dart';

import 'desktopView/d_medicines_screen.dart';
import 'mobileView/m_medicines_screen.dart';

class MedicinesScreen extends StatelessWidget{
  const MedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return MMedicinesScreen();
      }
      else{
        return DMedicinesScreen();
      }
    });
  }

}