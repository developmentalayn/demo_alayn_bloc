import 'package:bloc/bloc.dart';
import 'package:demo_alayn_bloc/Data/model/login/user_model.dart';
import 'package:demo_alayn_bloc/Data/repository/signup/signup_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupRepository repository;

  SignupCubit(this.repository) : super(SignupInitial());

  Future<void>signup(firstName,lastName,countryCode,phone,dateBirth) async{
    try{
      emit(SignupLoading());
            UserModel res =await repository.signup(firstName, lastName, countryCode, phone, dateBirth);

      emit(SignupComplete(res));
  }catch(ex){
    emit(SignupError(ex.toString()));
    }
  }
}
