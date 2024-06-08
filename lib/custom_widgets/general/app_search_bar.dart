import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whc_admin/controllers/app_search_controller.dart';

import '../../utils/constants.dart';

class AppSearchBar extends StatelessWidget {
  final double width;

  const AppSearchBar({
    super.key,
    this.width = 400.0,
  });

  @override
  Widget build(BuildContext context) {
    AppSearchController searchC = Get.put(AppSearchController());
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: EdgeInsets.zero,
      elevation: 1.0,
      color: kWhite,
      surfaceTintColor: kWhite,
      child: SizedBox(
        width: width,
        child: TextField(
          controller: searchC.searchTextC,
          decoration: const InputDecoration(
            isDense: true,
            hintText: "Search by Name",
            suffixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey, width: 0.5),
                borderRadius: BorderRadius.zero),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kGrey, width: 0.5),
                borderRadius: BorderRadius.zero),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor, width: 0.5),
                borderRadius: BorderRadius.zero),
          ),
          maxLines: 1,
          minLines: 1,
          onChanged: (val) {
            String txt = val;
            if (txt.isEmpty) {
              searchC.searchText.value = '';
              searchC.searchTrigger.value = false;
            } else {
              searchC.searchText.value = txt;
              searchC.searchTrigger.value = true;
            }
          },
          onSubmitted: (val) {
            String txt = val;
            if (txt.isEmpty) {
              searchC.searchText.value = '';
              searchC.searchTrigger.value = false;
            } else {
              searchC.searchText.value = txt;
              searchC.searchTrigger.value = true;
            }
          },
        ),
      ),
    );
  }
}
