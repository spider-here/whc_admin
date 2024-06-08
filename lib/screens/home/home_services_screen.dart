import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widgets/general/add_floating_button.dart';
import '../../custom_widgets/general/page_view_page.dart';
import '../../custom_widgets/general/progress_bar.dart';
import '../../custom_widgets/product_card.dart';
import '../addScreens/add_service_screen.dart';

class HomeServicesScreen extends StatelessWidget {
  const HomeServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AddFloatingButton(
            onPress: () {
              Get.to(() => const AddServiceScreen());
            },
            tooltipMessage: 'Add new service'),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          bool isMobile = constraints.maxWidth <= constraints.maxHeight ||
              constraints.maxWidth <= 600.0;
          if (isMobile) {
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('nursing')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ProgressBar(
                      full: true,
                    );
                  } else {
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.size,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 50.0,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0),
                        itemBuilder: (context, index) {
                          return ProductCard(
                              title: snapshot.data!.docs[index]
                                  .get('title')
                                  .toString(),
                              info1: snapshot.data!.docs[index]
                                  .get('hospital')
                                  .toString(),
                              imageUrl: snapshot.data!.docs[index]
                                  .get('image')
                                  .toString(),
                              info2: '',
                              info3: 'Rs. ${snapshot.data!.docs[index]
                                  .get('fee')}',
                              onPressed: () {
                                Get.to(() => AddServiceScreen.edit(
                                    id: snapshot.data!.docs[index]
                                        .get('nId')
                                        .toString(),
                                    title: snapshot.data!.docs[index]
                                        .get('title')
                                        .toString(),
                                    imageUrl: snapshot
                                        .data!.docs[index]
                                        .get('image')
                                        .toString(),
                                    hospital: snapshot
                                        .data!.docs[index]
                                        .get('hospital')
                                        .toString(),
                                    fee: snapshot.data!.docs[index]
                                        .get('fee')
                                        .toString(),
                                    facilities: snapshot
                                        .data!.docs[index]
                                        .get('facilities')
                                        .toString()));
                              },
                              isDoctor: false);
                        });
                  }
                });
          } else {
            return PageViewPage(
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('nursing')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const ProgressBar(
                            full: true,
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 20.0,
                              runSpacing: 20.0,
                              children: List.generate(
                                snapshot.data?.size ?? 0,
                                    (index) {
                                  return SizedBox(
                                    height: 215.0,
                                    width: 172.0,
                                    child: ProductCard(
                                      title: snapshot.data!.docs[index].get('title').toString(),
                                      info1: snapshot.data!.docs[index].get('hospital').toString(),
                                      imageUrl: snapshot.data!.docs[index].get('image').toString(),
                                      info2: '',
                                      info3: 'Rs. ${snapshot.data!.docs[index].get('fee')}',
                                      onPressed: () {
                                        Get.to(() => AddServiceScreen.edit(
                                            id: snapshot.data!.docs[index].get('nId').toString(),
                                            title: snapshot.data!.docs[index].get('title').toString(),
                                            imageUrl: snapshot.data!.docs[index].get('image').toString(),
                                            hospital: snapshot.data!.docs[index].get('hospital').toString(),
                                            fee: snapshot.data!.docs[index].get('fee').toString(),
                                            facilities: snapshot.data!.docs[index].get('facilities').toString()));
                                      },
                                      isDoctor: false,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
            );
          }
        }));
  }
}
