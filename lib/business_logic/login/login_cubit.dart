import 'package:bloc/bloc.dart';
import 'package:demo_alayn_bloc/Data/model/login/user_model.dart';
import 'package:demo_alayn_bloc/Data/repository/login/login_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  Future<void> login(countryCode,phone) async{
    try{
      emit(LoginLoading());
      UserModel res = await repository.login(countryCode, phone);
      emit(LoginComplete(res));
    }catch(ex){
      emit(LoginError(ex.toString()));
    }
  }
}
