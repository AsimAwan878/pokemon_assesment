import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon/bloc/app_bloc.dart';
import 'package:pokemon/utils/constants/constants.dart';
import 'package:pokemon/utils/constants/image_path.dart';
import 'package:pokemon/utils/pref_utils/prefs_keys.dart';
import 'package:pokemon/utils/pref_utils/shared_prefs.dart';
import 'package:pokemon/utils/routes/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _getAllPokemon();
    super.initState();
  }

  _getAllPokemon() async {
    context.read<AppBloc>().add(AppEventFetchData());
  }
  List<bool> favouriteList=[];
  List<dynamic> favouriteItem = [];
  bool isInitialized=false;

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
                text: "Home",
                style: text22p600(context, color: defaultDarkColor),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.favouriteRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    ImagePath.favourite,
                    color: defaultDarkColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
            width: screenWidth(context, 1),
            height: screenHeight(context, 1),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth(context, 0.1)),
                    topRight: Radius.circular(screenWidth(context, 0.1)))),
            child: BlocBuilder<AppBloc, AppState>
              (builder: (context, state) {
                if (state is AppStateLoading){
                  return Center(
                      child: CircularProgressIndicator(
                        color: defaultDarkColor,
                      ));
                }
                else if(state is AppStateDataLoaded)
                  {
                    if(!isInitialized){
                      initializeFavouriteList(state.dataList.length);
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: globalHorizontalPadding36(context),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Add Your Favourite One",
                              style: text28p500(context, color: defaultDarkColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemCount: state.dataList.length,
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
                                                    state.dataList[index]["name"],
                                                    style: text22p600(context,
                                                        color: defaultDarkColor),
                                                    maxLines: 2,
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      favouriteList.removeAt(index);
                                                      favouriteList.insert(index, true);
                                                      if(favouriteItem.contains(state.dataList[index])){
                                                        favouriteItem.removeAt(index);
                                                        favouriteItem.add(state.dataList[index]);
                                                      }
                                                      Prefs.setString(UserInfoKeys.favourite, jsonEncode(favouriteItem));
                                                      setState(() {

                                                      });
                                                    },
                                                    child: Image.asset(
                                                      favouriteList[index]
                                                          ? ImagePath.favourite 
                                                          : ImagePath.unFavourite,
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
                    );
                  }
                else{
                  return const SizedBox();
                }

            }
            )
        )
    );
  }
  
  initializeFavouriteList(int length){
    for(int i = 0 ; i< length; i++){
      favouriteList.add(false);
    }
   String? items = Prefs.getString(UserInfoKeys.favourite);
    if(items != "")
      {
        favouriteItem = jsonDecode(items);
      }
        isInitialized = true;
  }

}
