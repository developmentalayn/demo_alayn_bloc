import 'package:demo_alayn_bloc/constants/enum_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static Future<void> setUser(firstName,lastName,username,countryCode,phone,dateBirth,idGender,pathImg,token,expiration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', firstName);
    await prefs.setString('last_name', lastName);
    await prefs.setString('username', username);
    await prefs.setString('country_code', countryCode);
    await prefs.setString('phone', phone);
    await prefs.setString('date_birth', dateBirth.toString());
    await prefs.setInt('id_gender', idGender);
    await prefs.setString('path_img', pathImg);
    await prefs.setString('token', token);
    await prefs.setString('expiration', expiration.toString());
  }
  static Future<void> setPathImgUsername(username,pathImg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('path_img', pathImg);
  }
  static Future<dynamic> getUser(UserEnum userEnum) async {
    switch(userEnum){
      case UserEnum.firstName:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('first_name');
      case UserEnum.lastName:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('last_name');
      case UserEnum.username:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('username');
      case UserEnum.countryCode:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('country_code');
      case UserEnum.phone:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('phone');
      case UserEnum.dateBirth:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('date_birth');
      case UserEnum.idGender:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getInt('id_gender');
      case UserEnum.pathImg:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('path_img');
      case UserEnum.token:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString('token');
      case UserEnum.expiration:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return DateTime.parse(prefs.getString('expiration')!);
    }
  }
  static Future<String> getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstName = prefs.getString('first_name');
    var lastName = prefs.getString('last_name');
    return '$firstName $lastName';
  }
  static Future<bool> haveLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString('token');
    return res == null ? false : true;
  }
  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('first_name');
    prefs.remove('last_name');
    prefs.remove('username');
    prefs.remove('country_code');
    prefs.remove('phone');
    prefs.remove('date_birth');
    prefs.remove('id_gender');
    prefs.remove('path_img');
    prefs.remove('token');
    prefs.remove('expiration');
  }
}