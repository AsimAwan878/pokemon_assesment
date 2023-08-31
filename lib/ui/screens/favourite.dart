import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon/utils/constants/constants.dart';
import 'package:pokemon/utils/constants/image_path.dart';
import 'package:pokemon/utils/pref_utils/prefs_keys.dart';
import 'package:pokemon/utils/pref_utils/shared_prefs.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<bool> favouriteList=[];
  List<Map<String, dynamic>> favouriteItem = [];
  bool isInitialized=false;

  @override
  void initState() {
    _getAllFavourite();
    super.initState();
  }

  _getAllFavourite() async {
   String items= Prefs.getString(UserInfoKeys.favourite);
   favouriteItem = jsonDecode(items);
   setState(() {
     isInitialized = true;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: TextSpan(
                text: "Favourite",
                style: text22p600(context, color: defaultDarkColor),
              ),
            ),
          ),
        ),
        body: isInitialized
        ? Container(
            width: screenWidth(context, 1),
            height: screenHeight(context, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth(context, 0.1)),
                    topRight: Radius.circular(screenWidth(context, 0.1)))),
            child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: globalHorizontalPadding36(context),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Favourite Items",
                  style: text28p500(context, color: defaultDarkColor),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: favouriteItem.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, 0.056),
                          vertical: screenHeight(context, 0.026)),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: screenHeight(context, 0.02),
                            left: screenHeight(context, 0.02),
                            right: screenHeight(context, 0.02)),
                        decoration: BoxDecoration(
                          color: defaultColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Image.asset(
                                      ImagePath.character,
                                      width: screenWidth(context, 0.2),
                                      height: screenHeight(context, 0.1),
                                    )),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        favouriteItem[index]["name"],
                                        style: text22p600(context,
                                            color: defaultDarkColor),
                                        maxLines: 2,
                                      ),
                                      InkWell(
                                        // onTap: (){
                                        //   favouriteList.removeAt(index);
                                        //   favouriteList.insert(index, true);
                                        //   if(favouriteItem.contains(state.dataList[index])){
                                        //     favouriteItem.removeAt(index);
                                        //     favouriteItem.add(state.dataList[index]);
                                        //   }
                                        //   Prefs.setString(UserInfoKeys.favourite, jsonEncode(favouriteItem));
                                        // },
                                        child: Image.asset(
                                          // favouriteList[index]
                                          //     ?
                                          ImagePath.favourite,
                                              // : ImagePath.unFavourite,
                                          color: defaultDarkColor,
                                          height:
                                          screenHeight(context, 0.04),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ))
            :Center(
            child: CircularProgressIndicator(
              color: defaultDarkColor,
            ))
    );
  }
}
