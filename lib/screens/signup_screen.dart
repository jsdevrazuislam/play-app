import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:play/constant/font.dart';
import 'package:play/controller/login_controller.dart';
import 'package:play/routes/route_constant.dart';
import 'package:play/widget/app_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              Text("Create an account",
                  style: TextStyle(
                      fontSize: 25.sp, fontFamily: AppFonts.poppinsBlack)),
              Text("Let’s create your account.",
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
                      keyBoardType: TextInputType.name,
                      label: 'Username',
                      autoFocus: false,
                      hinit: 'Enter username',
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Enter username';
                      },
                      onFiledSubmitedValue: (value) {
                        loginController.username.value = value;
                      },
                    ),
                    SizedBox(height: 15.h),
                    AppInput(
                      keyBoardType: TextInputType.text,
                      label: 'Full Name',
                      hinit: 'Enter full name',
                      autoFocus: false,
                      onValidator: (value) {
                        if (value!.isEmpty) return 'Enter fullName';
                      },
                      onFiledSubmitedValue: (value) {
                        loginController.fullName.value = value;
                      },
                    ),
                    SizedBox(height: 15.h),
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
                        else if (value.length < 7)
                      return "Password at least 8 characters ";
                      },
                      onFiledSubmitedValue: (value) {
                        loginController.password.value = value;
                      },
                    ),
                    SizedBox(height: 15.h),
                    GestureDetector(onTap: () {
                      loginController.pickFile();
                    }, child: Obx(() {
                      return Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: loginController.isAvatar.value
                            ? Image(
                                image: FileImage(
                                    File(loginController.avatar!.path)))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    child: Icon(Icons.cloud_upload),
                                  ),
                                  SizedBox(height: 5.h),
                                  const Center(
                                    child: Text(
                                      "Upload Avatar...",
                                      style: TextStyle(
                                          fontFamily: AppFonts.poppinsLight),
                                    ),
                                  ),
                                ],
                              ),
                      );
                    })),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          loginController.register();
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
                                        "Register",
                                        style: TextStyle(
                                            fontFamily: AppFonts.poppinsRegular,
                                            fontSize: 12.sp),
                                      ));
                          })),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(fontFamily: AppFonts.poppinsRegular, fontSize: 12.sp)),
                  InkWell(
                    onTap: () {
                      Get.offNamed(RoutesName.loginScreen);
                    },
                    child: Text("login", style: TextStyle(fontFamily: AppFonts.poppinsBold, fontSize: 12.sp))
                    ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
