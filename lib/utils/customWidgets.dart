import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textfield_tags/textfield_tags.dart';

import 'constants.dart';

class customWidgets {
  Widget dashItemHead({required String headingText, required Widget image}) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: ListTile(
          title: Text(
            headingText,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                overflow: TextOverflow.ellipsis),
          ),
          trailing: image),
    );
  }

  Widget orderDetailCell({required String info, required String value}) {
    return Card(
      margin: const EdgeInsets.all(2.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info,
                style: const TextStyle(color: kGrey, fontSize: 12.0),
              ),
              const Padding(padding: EdgeInsets.only(top: 5.0)),
              SelectableText(value, style: const TextStyle(fontSize: 16.0))
            ],
          )),
    );
  }

  Widget productCardMobile({required BuildContext context,
    required String title,
    required String imageUrl,
    required String info1,
    required String info2,
    required String info3,
    required onPressed,
  required bool isDoctor}) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Stack(
            children: [
              Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  ),
                ),
              ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child:AspectRatio(
                aspectRatio: 2.2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                    color: kBlack.withOpacity(0.3)
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, color: kWhite),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 5.0,),
                        child: Text(
                          info1,
                          style: const TextStyle(color: kWhite, fontSize: 12.0,),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 5.0, right: 10.0,),
                        child: Text(
                          info2.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11,
                          color: kWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),),
              Align(
                alignment: FractionalOffset.topRight,
                child:isDoctor? Container(
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kBlack.withOpacity(0.3)
                  ),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        info3.toString(),
                        style: const TextStyle(color: kWhite, fontSize: 14.0),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5.0)),
                      const Icon(
                        Icons.star, color: Colors.yellowAccent, size: 18.0,
                      )
                    ],
                  ),
                )
                    :Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: kGreen.withOpacity(0.8)
                    ),
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(5.0),
                      child: Text(
                        info3.toString(),
                        style: const TextStyle(color: kWhite, fontSize: 11.0),
                      ),
                    ),)
            ],
          ),
        ),
      ),
    );
  }

  // Widget productCard({
  //   required BuildContext context,
  //   required String title,
  //   required String imageUrl,
  //   required String info1,
  //   required String info2,
  //   required String info3,
  //   required onPressed,
  // }) {
  //   return Card(
  //     elevation: 2.0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0),
  //     ),
  //     child: Stack(children: [
  //       Container(
  //         width: 180.0,
  //         height: 180.0,
  //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   image: DecorationImage(
  //                       image: NetworkImage(imageUrl), fit: BoxFit.cover)),
  //             ),
  //             Column(
  //               mainAxisAlignment: MediaQuery.of(context).size.width>1200? MainAxisAlignment.center : MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: MediaQuery.of(context).size.width>1200? EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0)
  //                   : EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
  //                   child: Text(
  //                     title,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width>1200? 18.0: 14.0),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
  //                   child: Text(
  //                     info1,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(color: kGrey, fontSize: MediaQuery.of(context).size.width>1200? 14.0 : 10.0),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
  //                   child: SizedBox(
  //                     width: MediaQuery.of(context).size.width>1000? 250.0 : 100.0,
  //                     child: Text(
  //                       info2.toString(),
  //                       overflow: TextOverflow.ellipsis,
  //                       maxLines: 3,
  //                       style: TextStyle(fontSize: MediaQuery.of(context).size.width>1200? 12.0 : 10.0),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       Align(
  //           alignment: FractionalOffset.bottomRight,
  //           child: Padding(
  //               padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
  //               child:
  //               // isDoctor? Row(
  //               //   mainAxisAlignment: MainAxisAlignment.end,
  //               //   children: [
  //               //     Text(
  //               //       info3.toString(),
  //               //       style: TextStyle(color: kGreen, fontSize: 14.0),
  //               //     ),
  //               //     Padding(padding: EdgeInsets.only(left: 5.0)),
  //               //     Icon(
  //               //       Icons.star, color: Colors.yellowAccent, size: 18.0,
  //               //     )
  //               //   ],
  //               // )
  //               //     :
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     info3.toString(),
  //                     style: TextStyle(color: kGreen, fontSize: 14.0),
  //                   ),
  //                 ],
  //               )
  //           ),
  //       ),
  //       Align(
  //           alignment: FractionalOffset.topRight,
  //           child: IconButton(
  //               onPressed: onPressed,
  //               icon: Icon(
  //                 Icons.edit,
  //                 color: kPrimarySwatch,
  //                 size: 20.0,
  //               )))
  //     ]),
  //   );
  // }

  Widget addProductTextField(
      {required TextEditingController controller, required String label, bool readOnly = false}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }



  Widget addProductNumberField(
      {required TextEditingController controller, required String label, bool readOnly = false}) {
    return TextField(
      readOnly: readOnly,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9]'),
        ),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
      ),
    );

  }

  Widget labTestCard({required BuildContext context,
    required String title,
    required String info1,
    required String info2,
    required String info3,
    required onPressed,}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width>1200? 18.0: 14.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  info1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kGrey, fontSize: MediaQuery.of(context).size.width>1200? 14.0 : 10.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                    info2.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width>1200? 12.0 : 10.0),
                  ),
                ),
              const Divider()
            ],
          ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      info3.toString(),
                      style: const TextStyle(color: kGreen, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      info3.toString(),
                      style: const TextStyle(color: kGreen, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: FractionalOffset.topRight,
                child: InkWell(
                    onTap: onPressed,
                    child: const Icon(
                      Icons.edit,
                      color: kPrimarySwatch,
                      size: 20.0,
                    )))
          ]
        ),
      ),
    );
  }

  Widget pageViewPage({required BuildContext context, required Widget widget}){
   return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), bottomLeft: Radius.circular(18.0))
      ),
      color: kCanvasColor,
      elevation: 2.0,
      margin: const EdgeInsets.only(left: 5.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0)
            )
          // image: DecorationImage(
          //     image: AssetImage('images/homeService.png'),
          //     fit: BoxFit.scaleDown
          // )
        ),
        child: widget
      ),
    );
  }
  
  Widget searchBar({required double width, required TextEditingController controller, required onChanged, required onSubmit}){
    return Container(
      height: 50.0,
      width: width,
      margin: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Press enter for advanced search, advanced search is case sensitive.',
            style: TextStyle(fontSize: 9.0, color: kGrey),),
          Container(
            height: 35.0,
            width: width,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: kGrey, width: 1.0),
              color: kWhite
            ),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                isDense: true,
                hintText: "Search by Name",
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none
              ),
              maxLines: 1,
              minLines: 1,
              onChanged: onChanged,
              onSubmitted: onSubmit,
            ),
          ),
        ],
      ),
    );
  }

  Widget tagsTextField(
      {required TextfieldTagsController controller,
        required double distanceToField,
        required List<String> dataList,
        required String hintText,
        required helperText,}){
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
                return '\"$tag\" is not in list';
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

                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: kPrimarySwatch,
                          width: 2.0),
                    ),
                    helperText: helperText,
                    helperStyle: const TextStyle(
                      color: kPrimarySwatch,
                    ),
                    hintText: controller.hasTags ? '' : hintText,
                    errorText: error,
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

    Widget chip({required String text, required onTap}){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: kGrey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        color: kWhite
      ),
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, overflow: TextOverflow.fade,),
          InkWell(
            onTap: onTap,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGreyOutline
                ),
                padding: const EdgeInsets.all(2.0),
                child: const Icon(Icons.close, size: 12.0, color: kGrey,)),
          )
        ],
      ),
    );
    }
  }

