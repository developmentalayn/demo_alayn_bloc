import 'package:demo_alayn_bloc/Data/repository/login/login_repository.dart';
import 'package:demo_alayn_bloc/Data/repository/signup/signup_repository.dart';
import 'package:demo_alayn_bloc/business_logic/login/login_cubit.dart';
import 'package:demo_alayn_bloc/presentation/login/login.dart';
import 'package:demo_alayn_bloc/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/Signup/Signup_cubit.dart';
import '../presentation/home/home.dart';

class Routes{
  static const String splashRoute = '/';
  static const String loginRoute = "/login";
  static const String SignupRoute = "/Signup";
  static const String homeRoute = "/home";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute :
        return MaterialPageRoute(builder: (context) => const Splash());
      case Routes.loginRoute :
        return MaterialPageRoute(builder: (context) =>
          BlocProvider(
            create: (_) => LoginCubit(LoginRepository()),
            child: const Login(),
          )
        );
      case Routes.SignupRoute :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (_) => SignupCubit(SignupRepository()),
              child: const Home(),
            )
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('no Route Found'),
          ),
          body: const Center(child: Text('no Route Found')),
        ));
  }
}