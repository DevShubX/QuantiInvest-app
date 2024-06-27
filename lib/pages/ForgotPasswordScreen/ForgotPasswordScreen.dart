import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantiinvest_app/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:quantiinvest_app/constants/constants.dart';
import 'package:quantiinvest_app/pages/LoginScreen/LoginScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isSigningIn = false;
  bool _hasEmailSent = false;

  Future sendEmail(String userEmail) async {
    http.Response response;
    response = await http
        .get(Uri.parse('$API_URL/auth/forgot-password?userEmail=$userEmail'));
    if (response.statusCode == 200) {
      setState(() {
        _hasEmailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        foregroundColor: AppColors.colors.lkWhite,
      ),
      backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/forgot-pass-icon.png",
                      fit: BoxFit.cover,
                      height: 220.h,
                      width: 280.w,
                    ),
                  ),
                ),
                Visibility(
                  visible: !_hasEmailSent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontFamily: "Gilroy-Bold",
                              fontSize: 25.sp,
                              color: AppColors.colors.lkWhite),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: Text(
                          "Don't worry! it occurs, Please enter the email address linked with your account",
                          style: TextStyle(
                              fontFamily: "Gilroy-Medium",
                              fontSize: 14.sp,
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
                                    padding:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color:
                                          const Color.fromARGB(255, 27, 27, 27),
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
                                      controller: _emailController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextStyle(
                                          fontFamily: "Gilroy-Medium",
                                          fontSize: 15.sp,
                                          color: AppColors.colors.lkWhite),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color:
                                                  AppColors.colors.tkLightGrey),
                                          prefixIcon: Icon(
                                            Icons.mail_rounded,
                                            color: AppColors.colors.qtBlue,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  await sendEmail(_emailController.text);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30.h),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                alignment: Alignment.center,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: AppColors.colors.qtBlue,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: isSigningIn
                                    ? const CircularProgressIndicator.adaptive(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : Text(
                                        "Send Email",
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
                    ],
                  ),
                ),
                Visibility(
                  visible: _hasEmailSent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        alignment: Alignment.center,
                        child: Text(
                          "Success",
                          style: TextStyle(
                              fontFamily: "Gilroy-Bold",
                              fontSize: 24.sp,
                              color: AppColors.colors.lkWhite),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        alignment: Alignment.center,
                        child: Text(
                          "Your message was sent successfully, please check your mail to confirm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Gilroy-Medium",
                              fontSize: 14.sp,
                              color: AppColors.colors.tkLightGrey),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 30.h),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.colors.qtBlue,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            "Back to login",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy-Bold',
                                fontSize: 16.sp),
                          ),
                        ),
                      ),
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
