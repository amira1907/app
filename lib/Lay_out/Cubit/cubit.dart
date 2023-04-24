import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/models/CategoryModel.dart';
import 'package:ShopApp/models/DetielsModel.dart';
import 'package:ShopApp/models/Home_Model.dart';
import 'package:ShopApp/moduls/CartScreen.dart';
import 'package:ShopApp/moduls/UserScreen.dart';
import 'package:ShopApp/moduls/home_screen.dart';
import 'package:ShopApp/network/dio_helper.dart';
import 'package:ShopApp/network/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class ShopCubit extends  Cubit<ShopStates> {


  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  List<Widget>screens=[
    CartScreen(),
    HomeScreen(),
    UserScreen()
  ];
  CategoriesModel  ? categoryModel;
  int currentIndex=0;
  void changeScreen(int index){
    currentIndex=index;
    emit( ShopChangeBottomNavState());
  }
  HomeModel ? homeModel;
  void getHome(){
    emit(ShopLoadingHomeDataState());
    Dio_Helper.getData(
        url: HOME,

    ).then((value) {
       homeModel=HomeModel.fromJson(value.data);
       printFullText(homeModel!.data!.banners[0].image);
       emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategory(){
    emit(ShopLoadingCategoryDataState());
    Dio_Helper.getData(
        url: SET_CATEGORY

    ).then((value) {
      categoryModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }
  ProductDetailsModel? productDetailsModel;
  void getProductDetailsData() {
    emit(ShopLoadingDetailsState());
    Dio_Helper.getData(url: PRODUCT,
    token: token
    ).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(value.data.toString());
      print(productDetailsModel!.data!.data![1].name);

      emit(ShopSuccessDetailsState());
    }).catchError((onError) {
      emit(ShopErrorDetailsState());
      print(onError.toString());

    });
  }

}