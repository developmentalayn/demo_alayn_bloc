import 'package:demo_alayn_bloc/business_logic/login/login_cubit.dart';
import 'package:demo_alayn_bloc/constants/enum_constant.dart';
import 'package:demo_alayn_bloc/constants/my_color.dart';
import 'package:demo_alayn_bloc/constants/my_constant.dart';
import 'package:demo_alayn_bloc/utils/custom_clipper_shape.dart';
import 'package:demo_alayn_bloc/utils/shared_pref.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:demo_alayn_bloc/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode = const CountryCode(name: 'Iraq', code: 'IQ', dialCode: '+964');
  TextEditingController txtPhone = TextEditingController();
  final FocusNode fcsPhone = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: BlocListener<LoginCubit,LoginState>(
        listener: (context,state) async{
          if(state is LoginInitial){
            form();
          }
          else if(state is LoginComplete){
             await SharedPref.setUser(state.model.firstName,
                state.model.lastName,
                state.model.username,
                state.model.countryCode,
                state.model.phone,
                state.model.dateBirth,
                state.model.idGender,
                state.model.pathImg,
                state.model.token,
                state.model.expiration);
             EasyLoading.dismiss();
             Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          else if(state is LoginLoading){
            showToast('يرجى الانتظار', ToastType.load);
            form();
          }
          else if(state is LoginError){
            showToast(state.err, ToastType.error);
            form();
          }
        },
        child: form(),
      )
    );
  }

  Widget form(){
    return Scaffold(
      backgroundColor: MyColor.colorBackground2,
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height/4,
                child: ClipPath(
                  clipper: CustomClipperShape(),
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70
                            ),
                          ),
                        ),
                        const SizedBox(height: 40,),
                        TextFormField(
                          // onFieldSubmitted: (term) {
                          //   FocusScope.of(context).requestFocus(fcsPhone2);
                          // },
                          maxLines: null,
                          minLines: 1,
                          maxLength: 10,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.done,
                          controller: txtPhone,
                          keyboardType: TextInputType.number,
                          focusNode: fcsPhone,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white70,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            prefix: GestureDetector(
                              onTap: () async{
                                final code = await countryPicker.showPicker(
                                  context: context,
                                  scrollToDeviceLocale: true,
                                );
                                if (code != null) {
                                  countryCode = code;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.deepPurple),
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                                child: Text(countryCode == null ? '+964' : countryCode.dialCode,
                                    style: const TextStyle(color: Colors.white)),
                              ),
                            ),
                            fillColor: Colors.white,
                            // filled: true,
                            counterText: "",
                            labelText: 'رقم الهاتف',
                            labelStyle: const TextStyle(color: Colors.white54),
                            // border: fieldBorder,
                          ),
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'ادخل رقم الهاتف';
                            } else if(value.trim().length > 10){
                              return 'لقد تجاوزت 10 مراتب';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 40,),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColor.colorMain
                            ),
                            child: const Text('تسجيل الدخول'),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _goToSignup,
                          child: const Text('انشاء حساب',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold)
                          ),
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login(){
    if(_formKey.currentState!.validate()){
      FocusScope.of(context).unfocus();
      BlocProvider.of<LoginCubit>(context).login(countryCode.dialCode, txtPhone.text);
    }
  }

  void _goToSignup(){
    Navigator.pushReplacementNamed(context, Routes.SignupRoute);
  }

  @override
  void dispose() {
    txtPhone.dispose();
    super.dispose();
  }
}
