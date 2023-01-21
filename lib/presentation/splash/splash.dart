import 'dart:async';
import 'package:demo_alayn_bloc/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:demo_alayn_bloc/utils/routes.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 3700), _goNext);
  }

  void _goNext() async{
    if(await SharedPref.haveLogin()){
      Navigator.pushReplacementNamed(context, Routes.homeRoute);
    }else{
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/json/splash.json',
        fit: BoxFit.fill),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
