import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/constants/constants.dart';
import 'package:quantiinvest_app/pages/LoginScreen/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isRegistering = false;
  bool _hasErrorText = false;
  String _errorText = "";
  final storage = const FlutterSecureStorage();

  Future register(
    String userEmail,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    try {
      setState(() {
        isRegistering = true;
      });
      final data = jsonEncode(<String, dynamic>{
        "userEmail": userEmail,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
      });

      http.Response response = await http.post(
        Uri.parse('$API_URL/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data,
      );

      Map<dynamic, dynamic> result = json.decode(response.body);

      if (response.statusCode == 200) {
        if (result['success'] == false) {
          setState(() {
            _hasErrorText = true;
            _errorText = result['errmsg'] ?? "";
          });
        } else {
          final token = result['token'];
          await storage.write(key: 'auth-token', value: token);
          await storage.write(key: 'userId', value: result['user']['_id']);
        }
      }
      setState(() {
        isRegistering = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 35.h, bottom: 20.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/quant-trade-logo.png",
                      fit: BoxFit.cover,
                      height: 100.h,
                      width: 200.w,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        fontFamily: "Gilroy-Bold",
                        fontSize: 32.sp,
                        color: AppColors.colors.lkWhite),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Signup to continue using the app",
                    style: TextStyle(
                        fontFamily: "Gilroy-Medium",
                        fontSize: 16.sp,
                        color: AppColors.colors.tkLightGrey),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                  color: AppColors.colors.lkWhite),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: const Color.fromARGB(255, 27, 27, 27),
                              ),
                              child: TextFormField(
                                /// Email Box
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email is required!";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () => setState(() {
                                  _hasErrorText = false;
                                  _errorText = "";
                                }),
                                controller: _emailController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: 15.sp,
                                    color: AppColors.colors.lkWhite),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey),
                                    prefixIcon: Icon(
                                      Icons.mail_rounded,
                                      color: AppColors.colors.qtBlue,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                  color: AppColors.colors.lkWhite),
                            ),
                            Container(
                              ///// Password Box
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: const Color.fromARGB(255, 27, 27, 27),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password is required!";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () => setState(() {
                                  _hasErrorText = false;
                                  _errorText = "";
                                }),
                                controller: _passwordController,
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: 15.sp,
                                    color: AppColors.colors.lkWhite),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: AppColors.colors.qtBlue,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First Name",
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                  color: AppColors.colors.lkWhite),
                            ),
                            Container(
                              ///// First Name Box
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: const Color.fromARGB(255, 27, 27, 27),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "First Name is required!";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () => setState(() {
                                  _hasErrorText = false;
                                  _errorText = "";
                                }),
                                controller: _firstNameController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: 15.sp,
                                    color: AppColors.colors.lkWhite),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "First Name",
                                    hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey),
                                    prefixIcon: Icon(
                                      Icons.account_circle_rounded,
                                      color: AppColors.colors.qtBlue,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Name",
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Bold',
                                  fontSize: 16.sp,
                                  color: AppColors.colors.lkWhite),
                            ),
                            Container(
                              ///// Last Name Box
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: const Color.fromARGB(255, 27, 27, 27),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Last Name is required!";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () => setState(() {
                                  _hasErrorText = false;
                                  _errorText = "";
                                }),
                                controller: _lastNameController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: 15.sp,
                                    color: AppColors.colors.lkWhite),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey),
                                    prefixIcon: Icon(
                                      Icons.account_circle_rounded,
                                      color: AppColors.colors.qtBlue,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16.sp,
                                      color: AppColors.colors.lkWhite),
                                ),
                                Text(
                                  "(eg. +91 xxxxxxxxxx)",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 14.sp,
                                      color: AppColors.colors.tkLightGrey),
                                ),
                              ],
                            ),
                            Container(
                              ///// Phone Number Box
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: const Color.fromARGB(255, 27, 27, 27),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Number is required!";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () => setState(() {
                                  _hasErrorText = false;
                                  _errorText = "";
                                }),
                                controller: _phoneNumberController,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontFamily: "Gilroy-Medium",
                                    fontSize: 15.sp,
                                    color: AppColors.colors.lkWhite),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(
                                        color: AppColors.colors.tkLightGrey),
                                    prefixIcon: Icon(
                                      Icons.dialpad,
                                      color: AppColors.colors.qtBlue,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _hasErrorText,
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          width: double.maxFinite,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _errorText,
                            style: TextStyle(
                              fontFamily: "Gilroy-Bold",
                              color: AppColors.colors.lkRed,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            await register(
                                _emailController.text,
                                _passwordController.text,
                                _firstNameController.text,
                                _lastNameController.text,
                                _phoneNumberController.text
                                    .replaceAll("+", ""));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40.h),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.colors.qtBlue,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: isRegistering
                              ? const CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy-Bold',
                                      fontSize: 16.sp),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?  ",
                        style: TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            fontSize: 14.sp,
                            color: AppColors.colors.lkWhite),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: 'Gilroy-Medium',
                            fontSize: 14.sp,
                            color: AppColors.colors.qtBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
