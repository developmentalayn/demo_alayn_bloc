import 'package:date_time_picker/date_time_picker.dart';
import 'package:demo_alayn_bloc/constants/my_color.dart';
import 'package:demo_alayn_bloc/utils/custom_clipper_shape.dart';
import 'package:demo_alayn_bloc/utils/shared_pref.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:demo_alayn_bloc/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../business_logic/signup/signup_cubit.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtFirstname = TextEditingController();
  TextEditingController txtLastname = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  final FocusNode fcsFirstname = FocusNode();
  final FocusNode fcsLastname = FocusNode();
  final FocusNode fcsUsername = FocusNode();
  final FocusNode fcsBirthdate = FocusNode();
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode = const CountryCode(name: 'Iraq', code: 'IQ', dialCode: '+964');

  TextEditingController txtPhone = TextEditingController();
  final FocusNode fcsPhone = FocusNode();
  String birthDate = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
        child:  BlocListener<SignupCubit,SignupState>(
          listener: (context,state)async{
            if(state is SignupInitial){
              form();
            }
            else if (state is SignupComplete){
               await SharedPref.setUser(state.modle.firstName,
                   state.modle.lastName,
                   state.modle.username,
                   state.modle.countryCode,
                   state.modle.phone,
                   state.modle.dateBirth,
                   state.modle.idGender,
                   state.modle.pathImg,
                   state.modle.token,
                   state.modle.expiration);
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              onFieldSubmitted: (term) {
                                FocusScope.of(context).requestFocus(fcsPhone);
                              },
                              maxLines: null,
                              minLines: 1,
                              maxLength: 32,
                              enabled: true,
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              controller: txtLastname,
                              keyboardType: TextInputType.text,
                              focusNode: fcsLastname,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.call,
                                //   color: MyColor.colorMain,
                                //   size: 16,),
                                counterText: "",
                                labelText: 'الاسم الثاني',
                                labelStyle: TextStyle(color: Colors.white54),
                                prefixIcon: Icon(Icons.person,
                                  color: Colors.white54,
                                  size: 16,),
                              ),
                              validator: (String? value) {
                                if (value!.trim().isEmpty) {
                                  return 'ادخل الاسم الثاني';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Flexible(
                            child: TextFormField(
                              onFieldSubmitted: (term) {
                                FocusScope.of(context).requestFocus(fcsLastname);
                              },
                              maxLines: null,
                              minLines: 1,
                              maxLength: 32,
                              enabled: true,
                              textAlign: TextAlign.center,
                              textInputAction: TextInputAction.next,
                              controller: txtFirstname,
                              keyboardType: TextInputType.text,
                              focusNode: fcsFirstname,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                // icon: Icon(Icons.call,
                                //   color: MyColor.colorMain,
                                //   size: 16,),
                                counterText: "",
                                labelText: 'الاسم الاول',
                                labelStyle: TextStyle(color: Colors.white54),
                                prefixIcon: Icon(Icons.person,
                                  color: Colors.white54,
                                  size: 16,),
                              ),
                              validator: (String? value) {
                                if (value!.trim().isEmpty) {
                                  return 'ادخل الاسم الاول';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        // onFieldSubmitted: (term) {
                        //   FocusScope.of(context).requestFocus(fcsPhone2);
                        // },
                        maxLines: null,
                        minLines: 1,
                        maxLength: 32,
                        enabled: true,
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
                      DateTimePicker(
                        initialValue: birthDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2030),
                        focusNode: fcsBirthdate,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                              color: Colors.white54
                          ),
                          label: Text('تاريخ الميلاد'),
                        ),
                        onChanged: (val) => birthDate = val,
                        fieldHintText: 'تاريخ الميلاد',
                        dateMask: 'yyyy/MM/dd',
                        validator: (val) {
                          return val.toString().isEmpty ? 'ادخل تاريخ الميلاد' : null;
                        },
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: _Signup,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyColor.colorMain
                          ),
                          child: const Text('انشاء حساب'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _goToHome,
              child: const Text('لديك حساب؟ تسجيل دخول',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold)
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void _Signup(){
    if(_formKey.currentState!.validate()){
      FocusScope.of(context).unfocus();
      BlocProvider.of<SignupCubit>(context).signup(
          txtFirstname.text,
          txtLastname.text,
        txtPhone.text,
        countryCode.dialCode,
        birthDate,
      );

      
    }
  }
  void _goToHome(){
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }
  @override
  void dispose() {
    txtPhone.dispose();
    super.dispose();
  }
}

