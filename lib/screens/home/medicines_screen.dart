import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/custom_widgets/general/add_floating_button.dart';
import 'package:whc_admin/models/medicines_model.dart';

import '../../controllers/app_search_controller.dart';
import '../../custom_widgets/general/app_search_bar.dart';
import '../../custom_widgets/general/page_view_page.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../custom_widgets/product_card.dart';
import '../addScreens/add_medicine_screen.dart';

class MedicinesScreen extends StatelessWidget {
  const MedicinesScreen({super.key});

  Stream<List<MedicinesModel>> getMedicines() {
    Query<Map<String, dynamic>> medicinesQuery =
        FirebaseFirestore.instance.collection('medicines');
    return medicinesQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        return MedicinesModel.fromMap(doc.id, data);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddFloatingButton(
        onPress: () {
          Get.to(() => const AddMedicineScreen());
        },
        tooltipMessage: 'Add new medicine',
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
            constraints.maxWidth <= 600.0;
        if (isMobile) {
          return StreamBuilder<List<MedicinesModel>>(
              stream: getMedicines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ProgressBar(
                    full: true,
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No medicines found'));
                } else {
                  List<MedicinesModel> medicinesList = snapshot.data!;
                  return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: medicinesList.length,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 60.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0),
                      itemBuilder: (context, index) {
                        MedicinesModel medicine = medicinesList[index];
                        return ProductCard(
                            title: medicine.name,
                            info1: medicine.strength,
                            imageUrl: medicine.imageUrl,
                            info2:
                                medicine.inStock ? '' : 'Out of Stock',
                            info3: 'Rs.${medicine.price}',
                            onPressed: () {
                              Get.to(() => AddMedicineScreen.edit(
                                    id: medicine.id,
                                    name: medicine.name,
                                    type: medicine.type,
                                    strength: medicine.strength,
                                    description: medicine.description,
                                    price: medicine.price.toString(),
                                    imageUrl: medicine.imageUrl,
                                    inStock: medicine.inStock,
                                  ));
                            },
                            isDoctor: false);
                      });
                }
              });
        } else {
          final AppSearchController searchC = Get.put(AppSearchController());
          final ScrollController scrollC = ScrollController();
          return PageViewPage(
              width: constraints.maxWidth,
              child: Stack(children: [
                Align(
                  alignment: FractionalOffset.topCenter,
                  child: StreamBuilder<List<MedicinesModel>>(
                      stream: getMedicines(),
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
                          return const Center(
                              child: Text('No medicines found'));
                        } else {
                          List<MedicinesModel> medicinesList = snapshot.data!;
                          RxInt maxRange = 20.obs;
                          RxList<MedicinesModel> medicinesLazyList = <MedicinesModel>[].obs;
                          if(medicinesList.length>20){
                            medicinesLazyList =
                                medicinesList.getRange(0, maxRange.value).toList().obs;
                          }
                          else{
                            medicinesLazyList.value = medicinesList;
                          }

                          void loadMore() {
                            int newMaxRange = maxRange.value + 20;
                            if (newMaxRange > medicinesList.length) {
                              newMaxRange = medicinesList.length;
                            }
                            maxRange.value = newMaxRange;
                            medicinesLazyList.value = medicinesList.getRange(0, maxRange.value).toList();
                          }
                          scrollC.addListener((){
                            if (scrollC.position.pixels == scrollC.position.maxScrollExtent) {
                              if (maxRange.value < medicinesList.length) {
                                loadMore();
                              }
                            }
                          });

                          return ListView(
                            controller: scrollC,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
                            children: [
                              Obx(() {
                                if (searchC.searchTrigger.isTrue) {
                                  List<MedicinesModel> filteredMedicines = medicinesList
                                      .where((i) => i.name
                                      .toLowerCase()
                                      .startsWith(searchC.searchText.value))
                                      .toList();
                                  return Wrap(
                                    spacing: 20.0,
                                    runSpacing: 20.0,
                                    children: filteredMedicines.map((medicine) {
                                      return SizedBox(
                                        height: 215.0,
                                        width: 172.0,
                                        child: ProductCard(
                                          title: medicine.name,
                                          info1: medicine.strength,
                                          imageUrl: medicine.imageUrl,
                                          info2: medicine.inStock ? '' : 'Out of Stock',
                                          info3: 'Rs.${medicine.price}',
                                          onPressed: () {
                                            Get.to(() => AddMedicineScreen.edit(
                                              id: medicine.id,
                                              name: medicine.name,
                                              type: medicine.type,
                                              strength: medicine.strength,
                                              description: medicine.description,
                                              price: medicine.price.toString(),
                                              imageUrl: medicine.imageUrl,
                                              inStock: medicine.inStock,
                                            ));
                                          },
                                          isDoctor: false,
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Obx(
                                        () => Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: medicinesLazyList.map((medicine) {
                                        return SizedBox(
                                          height: 215.0,
                                          width: 172.0,
                                          child: ProductCard(
                                            title: medicine.name,
                                            info1: medicine.strength,
                                            imageUrl: medicine.imageUrl,
                                            info2: medicine.inStock ? '' : 'Out of Stock',
                                            info3: 'Rs.${medicine.price}',
                                            onPressed: () {
                                              Get.to(() => AddMedicineScreen.edit(
                                                id: medicine.id,
                                                name: medicine.name,
                                                type: medicine.type,
                                                strength: medicine.strength,
                                                description: medicine.description,
                                                price: medicine.price.toString(),
                                                imageUrl: medicine.imageUrl,
                                                inStock: medicine.inStock,
                                              ));
                                            },
                                            isDoctor: false,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                              }),
                            ],
                          );
                        }
                      }),
                ),
                const Align(
                  alignment: FractionalOffset.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: AppSearchBar(),
                  ),
                )
              ]));
        }
      }),
    );
  }
}
