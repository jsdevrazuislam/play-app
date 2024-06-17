import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:play/routes/route_constant.dart';
import 'package:play/widget/app_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offNamed(RoutesName.homeScreen);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            size: 25.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* 
                ---------------------------- Create Account Title ---------------------------
              */
              Text("Login to your account",
                  style: TextStyle(
                      fontSize: 25.sp, fontFamily: AppFonts.poppinsBlack)),
              Text("It’s great to see you again.",
                  style: TextStyle(
                      fontSize: 14.sp, fontFamily: AppFonts.poppinsRegular)),
              SizedBox(height: 20.h),
              /* 
                ---------------------------- Added Input Here ---------------------------
              */
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    AppInput(
                      keyBoardType: TextInputType.emailAddress,
                      label: 'Email',
                      hinit: 'Enter email',
                      autoFocus: false,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Enter email';
                      },
                      onFiledSubmitedValue: (value) {
                        loginController.email.value = value;
                      },
                    ),
                    SizedBox(height: 15.h),
                    AppInput(
                      keyBoardType: TextInputType.text,
                      label: 'Password',
                      hinit: 'Enter password',
                      obscureText: true,
                      autoFocus: false,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Enter password';
                      },
                      onFiledSubmitedValue: (value) {
                        loginController.password.value = value;
                      },
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          loginController.login();
                          _formkey.currentState!.reset();
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 15.h),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Obx(() {
                            return Center(
                                child: loginController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                            fontFamily: AppFonts.poppinsRegular,
                                            fontSize: 12.sp),
                                      ));
                          })),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("If you have already account? ",
                            style: TextStyle(
                                fontFamily: AppFonts.poppinsRegular,
                                fontSize: 12.sp)),
                        InkWell(
                            onTap: () {
                              Get.offNamed(RoutesName.signUpScreen);
                            },
                            child: Text("register",
                                style: TextStyle(
                                    fontFamily: AppFonts.poppinsBold,
                                    fontSize: 12.sp))),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
