import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/doctorDetailsController.dart';
import '../../../database/database.dart';
import '../../../utils/constants.dart';
import '../../../utils/customWidgets.dart';


class dDoctorDetailsScreen extends StatelessWidget {
  String doctorID;

  dDoctorDetailsScreen({super.key, required this.doctorID});

  final doctorDetailsController _getC = Get.put(doctorDetailsController());
  final customWidgets _widgets = customWidgets();
  final database _db = database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .where('dId', isEqualTo: doctorID)
              .snapshots(),
          builder: (context, snapshot) {
            _getC.doctorApproved.value = snapshot.data!.docs[0].get('isApproved');
            _getC.doctorPopular.value = snapshot.data!.docs[0].get('isPopular');
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 2.0,
                        child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data!.docs[0].get('image')),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20.0)),
                        )),
                    const Padding(padding: EdgeInsets.only(left: 10.0)),
                    SizedBox(
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: kGrey)),
                            child: Center(
                              child: Obx(
                                () => CheckboxListTile(
                                  title: Text(
                                    snapshot.data!.docs[0]
                                                .get('isApproved') ==
                                            true
                                        ? 'Approved'
                                        : 'Mark doctor as approved?',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  value: _getC.doctorApproved.value,
                                  dense: true,
                                  onChanged: (newValue) {
                                    _getC.doctorApproved.value = newValue!;
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Container(
                            height: 40.0,
                            width: 300.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: kGrey)),
                            child: Center(
                              child: Obx(
                                () => CheckboxListTile(
                                  title: Text(
                                    snapshot.data!.docs[0].get('isPopular') ==
                                            true
                                        ? 'Popular'
                                        : 'Mark doctor as popular?',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  value: _getC.doctorPopular.value,
                                  dense: true,
                                  onChanged: (newValue) {
                                    _getC.doctorPopular.value = newValue!;
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    TextButton(onPressed: (){

                      Widget cancelButton = TextButton(
                        child: const Text("Cancel"),
                        onPressed:  () {Get.back();},
                      );
                      Widget continueButton = ElevatedButton(
                        child: const Text("Remove"),
                        onPressed:  () async {
                          await FirebaseFirestore.instance
                              .collection('doctors').doc(snapshot.data!.docs[0].get('dId')).delete().then((value) {
                          Get.back();
                              });
                          Get.back();
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text("Confirm"),
                        content: Text("Are you sure you want to remove " + snapshot.data!.docs[0].get('name') + "?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }, child: const Text('Remove Doctor'))
                  ],
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      _widgets.orderDetailCell(
                        info: "Doctor ID",
                        value: doctorID,
                      ),
                      _widgets.orderDetailCell(
                          info: "Email",
                          value:
                              snapshot.data!.docs[0].get('email').toString()),
                      _widgets.orderDetailCell(
                          info: "Phone Number",
                          value:
                              snapshot.data!.docs[0].get('phone').toString()),
                    ]),
                    TableRow(children: [
                      _widgets.orderDetailCell(
                          info: "Name",
                          value:
                              snapshot.data!.docs[0].get('name').toString()),
                      _widgets.orderDetailCell(
                          info: "Qualification",
                          value: snapshot.data!.docs[0]
                              .get('qualification')
                              .toString()),
                      _widgets.orderDetailCell(
                          info: "Speciality",
                          value: snapshot.data!.docs[0]
                              .get('speciality')
                              .toString()),
                    ]),
                    TableRow(children: [
                      _widgets.orderDetailCell(
                          info: "Gender",
                          value: snapshot.data!.docs[0].get('isMale') == true
                              ? 'Male'
                              : 'Female'),
                      Card(
                        margin: const EdgeInsets.all(2.0),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rating',
                                  style:
                                      TextStyle(color: kGrey, fontSize: 12.0),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 5.0)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SelectableText(
                                        snapshot.data!.docs[0]
                                            .get('rating')
                                            .toString(),
                                        style: const TextStyle(fontSize: 16.0)),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                      size: 18.0,
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      _widgets.orderDetailCell(
                          info: "Timestamp",
                          value: _getC.getDateTime(snapshot.data!.docs[0]
                              .get('timestamp'))),
                    ]),
                  ],
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      _widgets.orderDetailCell(
                          info: "Description",
                          value: snapshot.data!.docs[0]
                              .get('description')
                              .toString()),
                    ])
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                              () => Visibility(
                            visible: _getC.updateButtonVisibility.value,
                            child: ElevatedButton(
                                onPressed: () {
                                  _getC.updateButtonVisibility.value = false;
                                  _getC.progressVisibility.value = true;
                                  _db.updateDoctor(doctorID: doctorID, isApproved: _getC.doctorApproved.value,
                                      isPopular: _getC.doctorPopular.value).then((value) {
                                    _getC.updateButtonVisibility.value = true;
                                    _getC.progressVisibility.value = false;
                                  }).onError((error, stackTrace) {
                                    _getC.updateButtonVisibility.value = true;
                                    _getC.progressVisibility.value = false;
                                    Get.snackbar("Error", "Problem updating data.");
                                  });
                                }, child: const Text("Update")),
                          ),
                        ),
                        Obx(
                              () => Visibility(
                              visible: _getC.progressVisibility.value,
                              child: const CircularProgressIndicator()
                          ),
                        ),
                      ]),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
