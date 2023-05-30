import 'package:flutter/cupertino.dart';

import 'desktopView/dMedicinesScreen.dart';
import 'mobileView/mMedicinesScreen.dart';

class medicinesScreen extends StatelessWidget{
  const medicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mMedicinesScreen();
      }
      else{
        return dMedicinesScreen();
      }
    });
  }

}