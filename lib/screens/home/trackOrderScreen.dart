import 'package:flutter/cupertino.dart';

import 'desktopView/dTrackOrderScreen.dart';
import 'mobileView/mTrackOrderScreen.dart';

class trackOrderScreen extends StatelessWidget{
  const trackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return mTrackOrderScreen();
      }
      else{
        return dTrackOrderScreen();
      }
    });
  }
}