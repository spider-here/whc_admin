import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../utils/constants.dart';

class TagsTextField extends StatelessWidget{
  final TextfieldTagsController controller;
  final double distanceToField;
  final List<String> dataList;
  final String hintText;
  final String helperText;

  const TagsTextField(
      {super.key, required this.controller,
        required this.distanceToField,
        required this.dataList,
        required this.hintText,
        required this.helperText});
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) {
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 4.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 2.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dynamic option = options.elementAt(index);
                    return TextButton(
                      onPressed: () {
                        onSelected(option);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0),
                          child: Text(
                            '$option',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: kBlack,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return dataList.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selectedTag) {
        controller.addTag = selectedTag;
      },
      fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
        return TextFieldTags(
          textEditingController: ttec,
          focusNode: tfn,
          textfieldTagsController: controller,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (!dataList.contains(tag)) {
              return '$tag is not in list';
            } else if (controller.getTags!.contains(tag)) {
              return 'You already entered that';
            }
            return null;
          },
          inputfieldBuilder:
              (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return TextField(
                controller: tec,
                focusNode: fn,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.zero
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: kGrey),
                      borderRadius: BorderRadius.zero
                  ),
                  labelText: hintText,
                  helperText: helperText,
                  helperStyle: const TextStyle(
                    color: kPrimarySwatch,
                  ),
                  hintText: controller.hasTags ? '' : hintText,
                  errorText: error,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  prefixIconConstraints: BoxConstraints(
                      maxWidth: distanceToField * 0.74),
                  prefixIcon: tags.isNotEmpty
                      ? SingleChildScrollView(
                    controller: sc,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: tags.map((String tag) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: kPrimarySwatch,
                            ),
                            margin:
                            const EdgeInsets.only(right: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  onTap: () {
                                    //print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: kWhite,
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                  )
                      : null,
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              );
            });
          },
        );
      },
    );
  }

}