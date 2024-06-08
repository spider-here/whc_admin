import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/progress_bar.dart';
import 'package:whc_admin/models/doctors_model.dart';
import '../../custom_widgets/general/order_detail_cell.dart';
import '../../database/database.dart';
import '../../utils/constants.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorsModel doctor;

  String getDateTime(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return dateTime.toString();
  }

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final Database db = Database();
    final RxBool doctorApproved = doctor.isApproved.obs;
    final RxBool doctorPopular = doctor.isPopular.obs;
    final RxBool updateButtonVisibility = true.obs;
    final RxBool progressVisibility = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Obx(
            () => Visibility(
              visible: progressVisibility.value,
              child: const ProgressBar(),
            ),
          ),
        ),
        actions: [
          Obx(() => Visibility(
                visible: updateButtonVisibility.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Widget cancelButton = TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(kGrey)
                          ),
                          child: const Text("Cancel"),
                        );
                        Widget continueButton = TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('doctors')
                                .doc(doctor.id)
                                .delete()
                                .then((value) {
                              Get.back();
                            });
                            Get.back();
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(kRed)),
                          child: const Text("Remove"),
                        );

                        AlertDialog alert = AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: kWhite,
                          surfaceTintColor: kWhite,
                          title: const Text("Confirm"),
                          content: Text(
                              "Are you sure you want to remove ${doctor.name}?"),
                          actions: [cancelButton, continueButton],
                        );

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      child: const Text('Remove Doctor'),
                    ),
                  ],
                ),
              )),
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMobile
                  ? Container(
                      height: 200.0,
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(doctor.image),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 200.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(doctor.image),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  border: TableBorder.all(
                                      color: Colors.grey, width: 0.5),
                                  children: [
                                    TableRow(children: [
                                      OrderDetailCell(
                                          info: "Doctor ID", value: doctor.id),
                                      OrderDetailCell(
                                          info: "Name", value: doctor.name),
                                    ]),
                                    TableRow(children: [
                                      OrderDetailCell(
                                          info: "Qualification",
                                          value: doctor.qualification),
                                      OrderDetailCell(
                                          info: "Speciality",
                                          value: doctor.speciality),
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              const SizedBox(height: 10.0),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: Colors.grey, width: 0.5),
                children: isMobile
                    ? [
                        TableRow(children: [
                          OrderDetailCell(info: "Doctor ID", value: doctor.id),
                          OrderDetailCell(info: "Name", value: doctor.name),
                        ]),
                        TableRow(children: [
                          OrderDetailCell(
                              info: "Qualification",
                              value: doctor.qualification),
                          OrderDetailCell(
                              info: "Speciality", value: doctor.speciality),
                        ]),
                        TableRow(children: [
                          OrderDetailCell(info: "Email", value: doctor.email),
                          OrderDetailCell(
                              info: "Phone Number",
                              value: doctor.phoneNumber.toString()),
                        ]),
                        TableRow(children: [
                          OrderDetailCell(
                              info: "Gender",
                              value: doctor.isMale ? 'Male' : 'Female'),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Rating',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SelectableText(doctor.rating.toString(),
                                        style: const TextStyle(fontSize: 16.0)),
                                    const Icon(Icons.star,
                                        color: Colors.yellowAccent, size: 18.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ]
                    : [
                        TableRow(children: [
                          OrderDetailCell(
                              info: "Gender",
                              value: doctor.isMale ? 'Male' : 'Female'),
                          OrderDetailCell(info: "Email", value: doctor.email),
                          OrderDetailCell(
                              info: "Phone Number",
                              value: doctor.phoneNumber.toString()),
                        ]),
                        TableRow(children: [
                          OrderDetailCell(
                              info: "Description", value: doctor.description),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Rating',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                                const SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SelectableText(doctor.rating.toString(),
                                        style: const TextStyle(fontSize: 16.0)),
                                    const Icon(Icons.star,
                                        color: Colors.yellowAccent, size: 18.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          OrderDetailCell(
                              info: "Timestamp",
                              value: getDateTime(doctor.timestamp)),
                        ])
                      ],
              ),
              const SizedBox(height: 10.0),
              Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.grey, width: 0.5),
                  children: isMobile
                      ? [
                          TableRow(children: [
                            OrderDetailCell(
                                info: "Description", value: doctor.description),
                          ]),
                          TableRow(children: [
                            OrderDetailCell(
                                info: "Timestamp",
                                value: getDateTime(doctor.timestamp)),
                          ]),
                        ]
                      : []),
              const SizedBox(height: 10.0),
              isMobile
                  ? Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(color: Colors.grey, width: 0.5),
                      children: [
                        TableRow(children: [
                          Obx(() => CheckboxListTile(
                                title: Text(
                                  doctorApproved.value
                                      ? 'Approved'
                                      : 'Mark doctor as approved?',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                value: doctorApproved.value,
                                dense: true,
                                onChanged: (newValue) {
                                  doctorApproved.value = newValue!;
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              )),
                          Obx(() => CheckboxListTile(
                                title: Text(
                                  doctorPopular.value
                                      ? 'Popular'
                                      : 'Mark doctor as popular?',
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                value: doctorPopular.value,
                                dense: true,
                                onChanged: (newValue) {
                                  doctorPopular.value = newValue!;
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              )),
                        ]),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: kGrey, width: 0.5)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() => SizedBox(
                                    width: 300.0,
                                    child: CheckboxListTile(
                                      title: Text(
                                        doctorApproved.value
                                            ? 'Approved'
                                            : 'Mark doctor as approved?',
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      value: doctorApproved.value,
                                      dense: true,
                                      onChanged: (newValue) {
                                        doctorApproved.value = newValue!;
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  )),
                              Obx(() => SizedBox(
                                    width: 300.0,
                                    child: CheckboxListTile(
                                      title: Text(
                                        doctorPopular.value
                                            ? 'Popular'
                                            : 'Mark doctor as popular?',
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      value: doctorPopular.value,
                                      dense: true,
                                      onChanged: (newValue) {
                                        doctorPopular.value = newValue!;
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 20.0),
              Obx(
                () => Visibility(
                  visible: updateButtonVisibility.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          updateButtonVisibility.value = false;
                          progressVisibility.value = true;
                          db
                              .updateDoctor(
                            doctorID: doctor.id,
                            isApproved: doctorApproved.value,
                            isPopular: doctorPopular.value,
                          )
                              .then((value) {
                            updateButtonVisibility.value = true;
                            progressVisibility.value = false;
                          }).onError((error, stackTrace) {
                            updateButtonVisibility.value = true;
                            progressVisibility.value = false;
                            Get.snackbar("Error", "Problem updating data.");
                          });
                        },
                        child: const Text("Update"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        );
      }),
    );
  }
}
