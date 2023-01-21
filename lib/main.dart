import 'package:demo_alayn_bloc/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      builder: EasyLoading.init(),
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
    );
  }
}