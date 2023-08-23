import 'package:flutter/cupertino.dart';

import 'desktopView/d_track_order_screen.dart';
import 'mobileView/m_track_order_screen.dart';

class TrackOrderScreen extends StatelessWidget{
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return const MTrackOrderScreen();
      }
      else{
        return DTrackOrderScreen();
      }
    });
  }
}