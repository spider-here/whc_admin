import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/app_search_controller.dart';
import '../../custom_widgets/general/app_search_bar.dart';
import '../../custom_widgets/general/page_view_page.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../custom_widgets/product_card.dart';
import '../../models/doctors_model.dart';
import '../../utils/constants.dart';
import '../detailsScreens/doctor_details_screen.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  Stream<List<DoctorsModel>> getDoctors() {
    Query<Map<String, dynamic>> doctorsQuery = FirebaseFirestore.instance
        .collection('doctors')
        .where('isProfileComplete', isEqualTo: true);
    return doctorsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return DoctorsModel.fromMap(doc.id, data);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppSearchController searchC = Get.put(AppSearchController());
    final ScrollController scrollC = ScrollController();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
          constraints.maxWidth <= 600.0;
      return Scaffold(
        backgroundColor: isMobile ? Colors.transparent : kWhite,
        body: isMobile
            ? StreamBuilder<List<DoctorsModel>>(
                stream: getDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ProgressBar(
                      full: true,
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No doctors found'));
                  } else {
                    List<DoctorsModel> doctorsList = snapshot.data!;
                    return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 60.0),
                        scrollDirection: Axis.vertical,
                        itemCount: doctorsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0),
                        itemBuilder: (context, index) {
                          DoctorsModel doctor = doctorsList[index];
                          return ProductCard(
                            title: doctor.name,
                            info1: doctor.speciality,
                            imageUrl: doctor.image,
                            info2: 'Rs.${doctor.fee}',
                            info3: doctor.rating.toString(),
                            onPressed: () {
                              Get.to(() =>
                                  DoctorDetailsScreen(doctor: doctorsList[index]));
                            },
                            isDoctor: true,
                          );
                        });
                  }
                })
            : PageViewPage(
                width: constraints.maxWidth,
                child: Stack(children: [
                  StreamBuilder<List<DoctorsModel>>(
                      stream: getDoctors(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ProgressBar(
                            full: true,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No doctors found'));
                        } else {
                          List<DoctorsModel> doctorsList = snapshot.data!;
                          RxInt maxRange = 20.obs;
                          RxList<DoctorsModel> doctorsLazyList = <DoctorsModel>[].obs;
                          if(doctorsList.length>20){
                            doctorsLazyList =
                                doctorsList.getRange(0, maxRange.value).toList().obs;
                          }
                          else{
                            doctorsLazyList.value = doctorsList;
                          }

                          void loadMore() {
                            int newMaxRange = maxRange.value + 20;
                            if (newMaxRange > doctorsList.length) {
                              newMaxRange = doctorsList.length;
                            }
                            maxRange.value = newMaxRange;
                            doctorsLazyList.value = doctorsList.getRange(0, maxRange.value).toList();
                          }
                          scrollC.addListener((){
                            if (scrollC.position.pixels == scrollC.position.maxScrollExtent) {
                              if (maxRange.value < doctorsList.length) {
                                loadMore();
                              }
                            }
                          });
                          return ListView(
                            controller: scrollC,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 100.0),
                              children: [Obx((){
                                if(searchC.searchTrigger.isTrue){
                                  List<DoctorsModel> filteredDoctors = doctorsList.where((i) => i.name.toLowerCase().startsWith(searchC.searchText.value)).toList();
                                  return Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: filteredDoctors.map((doctor) {
                                        return SizedBox(
                                          height: 215.0,
                                          width: 172.0,
                                          child: ProductCard(
                                            title: doctor.name,
                                            info1: doctor.speciality,
                                            imageUrl: doctor.image,
                                            info2: 'Rs.${doctor.fee}',
                                            info3: doctor.rating.toString(),
                                            onPressed: () {
                                              Get.to(() => DoctorDetailsScreen(
                                                  doctor: doctor));
                                            },
                                            isDoctor: true,
                                          ),
                                        );
                                      }).toList());
                                }
                                else{
                                  return Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: doctorsLazyList.map((doctor) {
                                        return SizedBox(
                                          height: 215.0,
                                          width: 172.0,
                                          child: ProductCard(
                                            title: doctor.name,
                                            info1: doctor.speciality,
                                            imageUrl: doctor.image,
                                            info2: 'Rs.${doctor.fee}',
                                            info3: doctor.rating.toString(),
                                            onPressed: () {
                                              Get.to(() => DoctorDetailsScreen(
                                                  doctor: doctor));
                                            },
                                            isDoctor: true,
                                          ),
                                        );
                                      }).toList());
                                }
                              })]);
                        }
                      }),
                  const Align(
                    alignment: FractionalOffset.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: AppSearchBar(),
                    ),
                  )
                ])
                ),
      );
    });
  }
}
