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
  AuthHelper authHelper =AuthHelper();

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                cr_trt.withOpacity(0.8),
                cr_pri.withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hspace(40.h),
              const Spacer(),
              Image.asset(height: 100.r,width: 100.r,'assets/qr.png'),
              hspace(20.h),
              Text(
                'Codingo Qr',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    letterSpacing: 1,
                    color: cr_blk
                ),
              ),
              hspace(10.h),
              Text(
                'In the world of QR codes, every scan tells a story.',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w400,
                    fontSize: 9.sp,
                    color: cr_blk
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.only(left: 5.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  'LOG IN :',
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      letterSpacing: 2,
                      color: cr_blk
                  ),
                ),
              ),
              hspace(5.h),
              InkWell(
                onTap: ()async{
                  User? user = await authHelper.signInGoogle();
                  if(user!=null){
                    msg('Login Successfully');
                  }else{
                    msg('Error occured');
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: cr_wht,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.google,color: cr_sec,),
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
              hspace(30.h)
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
