// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goback(context);
        return false;
      },
      child: Scaffold(
        body: Container(
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
          child: SafeArea(
            child: Column(
              children: [
                Text('About Us',style: TextStyle(color: cr_wht,fontWeight: FontWeight.bold,fontSize: 15.sp),),
                Card(
                  elevation: 10.sp,
                  shadowColor: cr_sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100.w,
                        ),
                      ),
                      wspace(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'elianto',
                                color: cr_sec,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Developed by \n',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: cr_sec.withOpacity(0.5),
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'Soorya S',
                                ),
                              ],
                            ),
                          ),
                          hspace(10.h),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'elianto',
                                color: cr_pri,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Owned by \n',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                    color: cr_pri.withOpacity(0.5),
                                    letterSpacing: 0.sp,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'Dark3r',
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 10.sp,
                  shadowColor: cr_sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: ListTile(
                    onTap: () {
                      launchUrlString(
                          'mailto:sooryasivask@gmail.com?subject=Report an issue');
                    },
                    leading: const Icon(
                      Icons.alternate_email,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Report An issue',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38,
                        letterSpacing: 0.sp,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),
                /*Card(
                  elevation: 10.sp,
                  shadowColor: cr_sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: ListTile(
                    onTap: (){
                      launchUrlString('https://www.linkedin.com/in/soorya-s-b23b05213/');
                    },
                    leading: const Icon(
                      IconlyBold.profile,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      'Connect to LinkedIn',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38,
                        letterSpacing: 0.sp,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),*/
                Card(
                  elevation: 10.sp,
                  shadowColor: cr_sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: ListTile(
                    onTap: () {
                      launchUrlString('tel://9342573534');
                    },
                    leading: const Icon(
                      IconlyBold.call,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38,
                        letterSpacing: 0.sp,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),
                /*Card(
                  elevation: 10.sp,
                  shadowColor: cr_sec,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.r,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: ListTile(
                    onTap: (){
                      launchUrlString('https://play.google.com/store/apps/details?id=com.dark3r.salvamento');
                    },
                    leading: const Icon(
                      IconlyBold.star,
                      color: Colors.amber,
                    ),
                    title: Text(
                      'Rate Us',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38,
                        letterSpacing: 0.sp,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ),*/
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Text(
                                snapshot.data!.packageName,
                                style: TextStyle(
                                    color: cr_pri.withOpacity(0.8), fontFamily: 'elianto',fontSize: 10.sp),
                              ),
                              hspace(5.h),
                              Text(
                                'V:${snapshot.data!.version}+(${snapshot.data!.buildNumber})',
                                style: TextStyle(
                                    color: cr_sec, fontFamily: 'elianto',fontSize: 12.sp,fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}
