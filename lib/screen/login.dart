// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';
import '../service/authHelper.dart';

class _LoginState extends State<Login> {
  TextEditingController emailcon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                cr_pri.withOpacity(0.9),
                cr_sec.withOpacity(0.9),
                cr_sec.withOpacity(0.9),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hspace(40.h),
              const Spacer(flex: 2,),
              hspace(10.h),
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: cr_pri,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: cr_wht,
                      size: 18.sp,
                    ),
                    hspace(5.h),
                    Text(
                      'Vaultify',
                      style: GoogleFonts.styleScript(
                        color: cr_wht,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2,),
              hspace(20.h),
              Text(
                'Your digital world, secured—one password at a time.',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w400, fontSize: 9.sp, color: cr_blk),
              ),
              hspace(5.h),
              Text(
                'Rely on this tool to effortlessly track and retrieve your passwords whenever needed.',
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                  color: cr_blk,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  User? user = await authHelper.signInGoogle();
                  if (user != null) {
                    msg('Login Successfully');
                  } else {
                    msg('Error occured');
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: cr_pri,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.google,
                          color: cr_sec,
                        ),
                        wspace(10.w),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Continue with Google',
                                style: TextStyle(
                                  color: cr_sec,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.r,
                                ),
                              ),
                            ],
                          ),
                        ),
                        wspace(10.w),
                      ],
                    ),
                  ),
                ),
              ),
              hspace(20.h)
            ],
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
