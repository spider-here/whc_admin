import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whc_admin/screens/addScreens/mobileView/mAddLabTestScreen.dart';
import 'desktopView/dAddLabTestScreen.dart';

class addLabTestScreen extends StatelessWidget {
  bool edit = false;
  String id = " ";
  String testName = " ";
  String testType = " ";
  String sampleType = " ";
  String testFor = " ";
  String fee = " ";
  List<DocumentSnapshot> labsInLabTest = [];

  addLabTestScreen({super.key});

  addLabTestScreen.edit(
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
        return edit? mAddLabTestScreen.edit(edit: edit, id: id, testName: testName, testType: testType, sampleType: sampleType, testFor: testFor, fee: fee, labsInLabTest: labsInLabTest) : mAddLabTestScreen();
      }
      else{
        return edit? dAddLabTestScreen.edit(edit: edit, id: id, testName: testName, testType: testType, sampleType: sampleType, testFor: testFor, fee: fee, labsInLabTest: labsInLabTest) : dAddLabTestScreen();
      }
    });
  }
}
