import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:quantiinvest_app/constants/constants.dart';
import 'package:quantiinvest_app/pages/ForgotPasswordScreen/ForgotPasswordScreen.dart';
import 'package:quantiinvest_app/pages/SignupScreen.dart/SignupScreen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  bool _hasErrorText = false;
  String _errorText = "";

  bool isSigningIn = false;

  Future login(String userEmail, String password) async {
    try {
      setState(() {
        isSigningIn = true;
      });
      final data = jsonEncode(<String, dynamic>{
        "userEmail": userEmail,
        "password": password,
      });

      http.Response response = await http.post(
        Uri.parse('$API_URL/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: data,
      );

      Map<dynamic, dynamic> result = json.decode(response.body);

      print(result['user']['_id']);

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
        isSigningIn = false;
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
                    "Lets Sign you in",
                    style: TextStyle(
                        fontFamily: "Gilroy-Bold",
                        fontSize: 32.sp,
                        color: AppColors.colors.lkWhite),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Login to continue using the app",
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
                                    return "Please enter email";
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
                                    return "Please enter password";
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
                          width: double.maxFinite,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontFamily: "Gilroy-Bold",
                              color: AppColors.colors.tkLightGrey,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            await login(_emailController.text,
                                _passwordController.text);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.h),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.colors.qtBlue,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: isSigningIn
                              ? const CircularProgressIndicator.adaptive(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  "Login",
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
                  margin: EdgeInsets.only(top: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
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
                                      const SignupScreen()));
                        },
                        child: Text(
                          "Register",
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
