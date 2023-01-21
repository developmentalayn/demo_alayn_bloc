import 'package:demo_alayn_bloc/Data/api/api.dart';
import 'package:demo_alayn_bloc/Data/model/home/home_model.dart';
import 'package:demo_alayn_bloc/constants/strings.dart';

class HomeRepository{
  Api api = Api();
  HomeRepository();

  Future<HomeModel?> getContent() async {
    try {
      await Future.delayed(Duration(seconds: 4));
      return null;
      // final res = await api.callApi(
      //     null, '/api/$version/Home/GetAll', sendToken: false);
      // if (res.isNotEmpty) {
      //   return HomeModel(); //.fromJson(json.decode(res));
      // } else {
      //   throw 'null';
      // }
    } catch (ex) {
      rethrow;
    }
  }
}