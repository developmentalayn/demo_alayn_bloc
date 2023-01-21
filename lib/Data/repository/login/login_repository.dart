import 'dart:convert';

import 'package:demo_alayn_bloc/Data/api/api.dart';
import 'package:demo_alayn_bloc/Data/model/login/user_model.dart';
import 'package:demo_alayn_bloc/constants/strings.dart';

class LoginRepository{
  Api api = Api();
  LoginRepository();

  Future<UserModel> login(countryCode,phone) async{
    try{
      Map<String, dynamic> body = {
        'country_code': countryCode,
        'phone': phone
      };
      final res = await api.callApi(body, '/api/$version/User/Login', sendToken: false);
      if (res.isNotEmpty) {
        return UserModel.fromJson(json.decode(res));
      } else {
        throw 'null';
      }
    }catch(ex){
      rethrow;
    }
  }
}