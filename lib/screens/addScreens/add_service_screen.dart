import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/confirmation_dialog.dart';

import '../../controllers/add_service_controller.dart';
import '../../custom_widgets/general/app_text_field.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../utils/constants.dart';

class AddServiceScreen extends StatelessWidget {
  final bool edit;
  final String id;
  final String title;
  final String imageUrl;
  final String hospital;
  final String fee;
  final String facilities;

  const AddServiceScreen({super.key}) : edit = false,
   id = '',
   title = '',
   imageUrl = '',
   hospital = '',
   fee = '',
   facilities = '';

  const AddServiceScreen.edit(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.hospital,
      required this.fee,
      required this.facilities}) : edit = true;

  @override
  Widget build(BuildContext context) {
    AddServiceController getC = Get.put(AddServiceController());
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
          constraints.maxWidth <= 600.0;
      return Scaffold(
        appBar: AppBar(
          title: edit
              ? const Text("Edit Home Service")
              : const Text("Add Home Service"),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Obx(
              () => Visibility(
                visible: getC.progressVisibility.value,
                child: const ProgressBar(),
              ),
            ),
          ),
          actions: edit
              ? [
                  Obx(() => Visibility(
                        visible: getC.addServiceButtonVisibility.value,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmationDialog.delete(
                                    message:
                                        "Are you sure you want to delete $title?",
                                    onConfirm: () async {
                                      getC.progressVisibility.value = true;
                                      getC.addServiceButtonVisibility.value =
                                          false;
                                      getC
                                          .deleteService(
                                              id: id, imageUrl: imageUrl)
                                          .then((value) {
                                        Get.back();
                                      }).onError((error, stackTrace) {
                                        getC.progressVisibility.value = false;
                                        getC.addServiceButtonVisibility.value =
                                            true;
                                        Get.back();
                                        Get.snackbar("Error",
                                            "Cannot delete at this moment.");
                                      });
                                    }, confirmButtonLabel: 'Delete',);
                              },
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                          child: const Text('Delete Service'),
                        ),
                      ))
                ]
              : [],
        ),
        body: SingleChildScrollView(
            padding:
                EdgeInsets.fromLTRB(isMobile ? 20.0 : 100.0, 20.0, 20.0, 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isMobile
                  ? [
                      Obx(
                        () => getC.files.length == 1
                            ? Container(
                                height: 200.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kGrey),
                                    image: DecorationImage(
                                        image: MemoryImage(
                                            getC.capturedImage.value!),
                                        fit: BoxFit.contain)),
                                child: Center(
                                  child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      elevation: 1.0,
                                      child: TextButton(
                                        child: const Text("Add Image"),
                                        onPressed: () {
                                          getC.viewImageFromDevice();
                                        },
                                      )),
                                ),
                              )
                            : Container(
                                height: 200.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kGrey),
                                    image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.contain)),
                                child: Center(
                                  child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      elevation: 1.0,
                                      child: TextButton(
                                        child: const Text("Add Image"),
                                        onPressed: () {
                                          getC.viewImageFromDevice();
                                        },
                                      )),
                                ),
                              ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20.0)),
                      Obx(
                        () => AppTextField(
                          readOnly: getC.progressVisibility.value,
                          controller: !edit ? getC.titleC : getC.titleC
                            ..text = title,
                          label: "Service title",
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Obx(
                        () => AppTextField(
                          readOnly: getC.progressVisibility.value,
                          controller: !edit ? getC.hospitalC : getC.hospitalC
                            ..text = hospital,
                          label: "Hospital",
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Obx(
                        () => AppTextField(
                          readOnly: !edit
                              ? getC.progressVisibility.value
                              : getC.progressVisibility.value,
                          controller: getC.feeC..text = fee,
                          label: "Fee",
                          isNumber: true,
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Obx(
                        () => TextField(
                          controller:
                              !edit ? getC.facilitiesC : getC.facilitiesC
                                ..text = facilities,
                          maxLines: 6,
                          maxLength: 100,
                          readOnly: getC.progressVisibility.value,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            labelText: "Facilities",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: kPrimaryColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: kGrey)),
                          ),
                        ),
                      ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                      Obx(
                        () => Visibility(
                          visible: getC.addServiceButtonVisibility.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    if (edit) {
                                      await getC.updateData(
                                          id: id, imageUrl: imageUrl);
                                    } else {
                                      await getC.addData();
                                    }
                                  },
                                  child: Text(edit ? "Save" : "Add Service")),
                            ],
                          ),
                        ),
                      ),
                    ]
                  : [
                      Row(
                        children: [
                          Obx(
                            () => getC.files.length == 1
                                ? Container(
                                    height: 200.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kGrey),
                                        image: DecorationImage(
                                            image: MemoryImage(
                                                getC.capturedImage.value!),
                                            fit: BoxFit.contain)),
                                    child: Center(
                                      child: Card(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          elevation: 1.0,
                                          child: TextButton(
                                            child: const Text("Add Image"),
                                            onPressed: () {
                                              getC.viewImageFromDevice();
                                            },
                                          )),
                                    ),
                                  )
                                : Container(
                                    height: 200.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: kGrey),
                                        image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.contain)),
                                    child: Center(
                                      child: Card(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero,
                                          ),
                                          elevation: 1.0,
                                          child: TextButton(
                                            child: const Text("Add Image"),
                                            onPressed: () {
                                              getC.viewImageFromDevice();
                                            },
                                          )),
                                    ),
                                  ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20.0)),
                          SizedBox(
                            width: 600.0,
                            height: 200.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => AppTextField(
                                    readOnly: getC.progressVisibility.value,
                                    controller:
                                        !edit ? getC.titleC : getC.titleC
                                          ..text = title,
                                    label: "Service title",
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 12.0)),
                                Obx(
                                  () => AppTextField(
                                    readOnly: getC.progressVisibility.value,
                                    controller:
                                        !edit ? getC.hospitalC : getC.hospitalC
                                          ..text = hospital,
                                    label: "Hospital",
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 12.0)),
                                Obx(
                                  () => AppTextField(
                                    readOnly: !edit
                                        ? getC.progressVisibility.value
                                        : getC.progressVisibility.value,
                                    controller: getC.feeC..text = fee,
                                    label: "Fee",
                                    isNumber: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12.0)),
                      SizedBox(
                        width: 780.0,
                        child: Obx(
                          () => TextField(
                            controller:
                                !edit ? getC.facilitiesC : getC.facilitiesC
                                  ..text = facilities,
                            maxLines: 6,
                            maxLength: 100,
                            readOnly: getC.progressVisibility.value,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              labelText: "Facilities",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: kPrimaryColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(color: kGrey)),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30.0)),
                      Obx(
                        () => Visibility(
                          visible: getC.addServiceButtonVisibility.value,
                          child: SizedBox(
                            width: 780.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      if (edit) {
                                        await getC.updateData(
                                            id: id, imageUrl: imageUrl);
                                      } else {
                                        await getC.addData();
                                      }
                                    },
                                    child: Text(edit ? "Save" : "Add Service")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
            )),
      );
    });
  }
}
