import 'package:ShopApp/models/LoginModel.dart';
import 'package:ShopApp/moduls/Login/cubit/states.dart';
import 'package:ShopApp/network/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit():super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel ?loginModel;
  void userLogin({
    required String email,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    Dio_Helper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,

        }
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel!.data!.image);
      emit(ShopLoginSuccessState(loginModel!));

    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));

    });
  }
  }
