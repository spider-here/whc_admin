import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whc_admin/screens/addScreens/mobileView/m_add_lab_test_screen.dart';
import 'desktopView/d_add_lab_test_screen.dart';

class AddLabTestScreen extends StatelessWidget {
  bool edit = false;
  String id = " ";
  String testName = " ";
  String testType = " ";
  String sampleType = " ";
  String testFor = " ";
  String fee = " ";
  List<DocumentSnapshot> labsInLabTest = [];

  AddLabTestScreen({super.key});

  AddLabTestScreen.edit(
      {super.key,
      required this.edit,
      required this.id,
      required this.testName,
      required this.testType,
      required this.sampleType,
      required this.testFor,
      required this.fee,
      required this.labsInLabTest});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      if(constraints.maxWidth <= constraints.maxHeight || constraints.maxWidth <= 600.0){
        return edit? MAddLabTestScreen.edit(edit: edit, id: id, testName: testName, testType: testType, sampleType: sampleType, testFor: testFor, fee: fee, labsInLabTest: labsInLabTest) : MAddLabTestScreen();
      }
      else{
        return edit? dAddLabTestScreen.edit(edit: edit, id: id, testName: testName, testType: testType, sampleType: sampleType, testFor: testFor, fee: fee, labsInLabTest: labsInLabTest) : dAddLabTestScreen();
      }
    });
  }
}
