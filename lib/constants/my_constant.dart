import 'package:demo_alayn_bloc/constants/custom_indicator.dart';
import 'package:demo_alayn_bloc/constants/enum_constant.dart';
import 'package:demo_alayn_bloc/constants/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:lottie/lottie.dart';

void showToast(txt, ToastType type) {
  switch (type) {
    case ToastType.load:
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.cubeGrid
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = MyColor.colorMain
        ..textColor = Colors.white70
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.show(status: txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.success:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.green
        ..textColor = Colors.green
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showSuccess(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.error:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.redAccent
        ..textColor = Colors.redAccent
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showError(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.info:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.yellowAccent
        ..textColor = Colors.yellowAccent
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showInfo(txt, maskType: EasyLoadingMaskType.custom);
      break;
    case ToastType.toast:
      EasyLoading.instance
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..backgroundColor = Colors.black54
        ..indicatorColor = Colors.white70
        ..textColor = Colors.white70
        ..maskColor = Colors.black54.withOpacity(0.6)
        ..userInteractions = false
        ..dismissOnTap = false
        ..customAnimation = CustomIndicator();
      EasyLoading.showToast(txt, maskType: EasyLoadingMaskType.custom);
      break;
  }
}

Widget failed(callBack) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/json/error.json",
      ),
      const Text(
        'تعذر الاتصال بالخادم..تأكد من اتصال الشبكة',
        style: TextStyle(color: MyColor.colorRed),
      ),
      Center(
        child: TextButton.icon(
          // <-- TextButton
          onPressed: callBack,
          icon: const Icon(
            Icons.refresh,
            size: 24.0,
            color: MyColor.colorMain,
          ),
          label: const Text(
            'اعادة المحاولة',
            style: TextStyle(color: MyColor.colorMain),
          ),
        ),
      )
    ],
  );
}

Widget loading() {
  return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ListView(
        children: [
          CardSkeleton(
            isCircularImage: true,
            isBottomLinesActive: true,
          ),
          CardSkeleton(
            isCircularImage: true,
            isBottomLinesActive: true,
          ),
          CardSkeleton(
            isCircularImage: true,
            isBottomLinesActive: true,
          ),
        ],
      ));
}

Widget noData() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/json/no_data.json",
      ),
      const Center(
        child: Text('لا تتوفر بيانات'),
      )
    ],
  );
}