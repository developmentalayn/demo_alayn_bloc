part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}


class SignupLoading extends SignupState{}

class SignupComplete extends SignupState{

  final UserModel  modle;
  SignupComplete( this.modle);
}



class SignupError extends SignupState{
  final String err;
  SignupError (this.err);
}