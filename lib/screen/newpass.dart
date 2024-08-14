import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaultify/object/vault.dart';

import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';
import '../service/passhelper.dart';

class Newpass extends StatefulWidget {
  Vault vault;
  bool edit;

  Newpass({this.edit = false, required this.vault});

  @override
  _NewpassState createState() => _NewpassState();
}

class _NewpassState extends State<Newpass> {
  late bool edit;
  bool sho = true;
  late Vault vault;

  @override
  void dispose() {
    usercon.dispose();
    sitecon.dispose();
    passcon.dispose();
    super.dispose();
  }

  late TextEditingController usercon, sitecon, passcon;

  @override
  Widget build(BuildContext context) {
    vault = widget.vault;
    usercon = TextEditingController(text: vault.username);
    sitecon = TextEditingController(text: vault.site);
    passcon = TextEditingController(text: vault.password);
    edit = widget.edit;
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/');
        return true;
      },
      child: Scaffold(
        backgroundColor: cr_blk,
        appBar: AppBar(
          backgroundColor: cr_pri,
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.back,
              color: cr_sec,
            ),
            onPressed: () {
              goback(context);
            },
          ),
          title: Text.rich(
            TextSpan(
              style: TextStyle(
                color: cr_secac,
                fontSize: 12.sp,
                letterSpacing: 2,
                wordSpacing: 5,
              ),
              children: const [
                TextSpan(
                  text: 'ADD ',
                ),
                TextSpan(
                  text: 'NEW',
                ),
              ],
            ),
          ),
          actions: const [
            // edit ?  option(id!) : SizedBox(),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'null ' * 1000,
                    style: TextStyle(
                        color: Colors.redAccent.shade100,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 2),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    color: cr_pri.withOpacity(1),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          hspace(10),
                          Text(
                            'Enter your details to encrypt',
                            style: TextStyle(
                                color: cr_sec,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                          hspace(10),
                          TextField(
                              controller: usercon,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                fillColor: CupertinoColors.white,
                                filled: true,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Icon(
                                    CupertinoIcons.person_alt,
                                    color: cr_sec,
                                  ),
                                ),
                                border: norborder,
                                enabledBorder: norborder,
                                focusedBorder: fosborder,
                                hintText: 'Name',
                                hintStyle: hintstyle,
                                labelText: 'username'.toUpperCase(),
                                labelStyle: hintstyle,
                              ),
                              style: TextStyle(
                                color: Colors.blue.withOpacity(0.8),
                              ),
                              keyboardType: TextInputType.name,
                              onChanged: (text) {
                                vault.username = text;
                                //name = text;
                              }),
                          hspace(20),
                          TextField(
                              controller: sitecon,
                              textCapitalization: TextCapitalization.none,
                              decoration: InputDecoration(
                                fillColor: CupertinoColors.white,
                                filled: true,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Icon(
                                    CupertinoIcons.personalhotspot,
                                    color: cr_sec,
                                  ),
                                ),
                                border: norborder,
                                enabledBorder: norborder,
                                focusedBorder: fosborder,
                                hintText: 'site',
                                hintStyle: hintstyle,
                                labelText: 'website'.toUpperCase(),
                                labelStyle: hintstyle,
                              ),
                              style: TextStyle(
                                color: Colors.blue.withOpacity(0.8),
                              ),
                              keyboardType: TextInputType.name,
                              onChanged: (text) {
                                vault.site = text;
                              }),
                          hspace(20),
                          TextField(
                              textCapitalization: TextCapitalization.words,
                              controller: passcon,
                              decoration: InputDecoration(
                                  fillColor: CupertinoColors.white,
                                  filled: true,
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Icon(
                                      CupertinoIcons.lock,
                                      color: cr_sec,
                                    ),
                                  ),
                                  border: norborder,
                                  enabledBorder: norborder,
                                  focusedBorder: fosborder,
                                  hintText: '',
                                  hintStyle: hintstyle,
                                  labelText: 'password'.toUpperCase(),
                                  labelStyle: hintstyle,
                                  suffix: SizedBox(
                                    height: 30,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          sho = !sho;
                                        });
                                      },
                                      icon: Icon(
                                        sho
                                            ? FontAwesomeIcons.solidEye
                                            : FontAwesomeIcons.eyeSlash,
                                        color: cr_secac,
                                      ),
                                    ),
                                  )),
                              obscureText: sho,
                              style: TextStyle(
                                color: cr_grey.withOpacity(0.8),
                              ),
                              keyboardType: TextInputType.name,
                              onChanged: (text) {
                                vault.password = text;
                                //name = text;
                              }),
                          hspace(20),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                    const ClipboardData(
                                      text: '',
                                    ),
                                  );
                                  passcon.text = '';
                                  Fluttertoast.showToast(
                                    msg: 'Password Copied to clipboard',
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: cr_pri,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                                  child: const Text(
                                    'Generate',
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  if (usercon.text.isEmpty ||
                                      sitecon.text.isEmpty ||
                                      passcon.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: 'Enter all detail',
                                    );
                                  } else {
                                    if (edit) {
                                      VaultHelper().editvault(vault);
                                    } else {
                                      VaultHelper().addvault(vault);
                                    }
                                    routename(context, '/');
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: cr_sec,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 3.h),
                                  child: Text(
                                    edit ? 'change' : 'Add',
                                    style: TextStyle(
                                        color: CupertinoColors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2),
                                  ),
                                ),
                              )
                            ],
                          ),
                          hspace(10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final norborder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: cr_sec.withOpacity(0.5), width: 1.5),
    gapPadding: 10,
  );
  final fosborder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: cr_secac.withOpacity(0.8), width: 2),
    gapPadding: 10,
  );
  final hintstyle = TextStyle(
      color: cr_grey.withOpacity(0.4),
      fontSize: 20,
      fontWeight: FontWeight.w900);
}
