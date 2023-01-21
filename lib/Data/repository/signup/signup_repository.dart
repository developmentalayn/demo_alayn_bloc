import 'dart:convert';

import 'package:demo_alayn_bloc/Data/model/login/user_model.dart';

import '../../../constants/strings.dart';
import '../../api/api.dart';
class SignupRepository{
  Api api = Api();
  SignupRepository();

  Future<UserModel> signup (firstName,lastName,countryCode,phone,dateBirth) async{
    try{
      Map<String, dynamic> body = {


          "first_name": firstName,
          "last_name": lastName,
          "country_code": countryCode,
          "phone": phone,
          "date_birth": dateBirth

      };
      final res = await api.callApi(body, '/api/v1/User/Create', sendToken: true);
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