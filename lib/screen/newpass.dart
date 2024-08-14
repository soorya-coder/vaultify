import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';
import '../db/passhelper.dart';
import '../object/vault.dart';

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
        backgroundColor: cr_pri,
        appBar: AppBar(
          backgroundColor: cr_pri,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () {
              goback(context);
            },
          ),
          title: const Text.rich(TextSpan(
              style: TextStyle(
                  color: cr_secac,
                  fontSize: 30,
                  letterSpacing: 2,
                  wordSpacing: 5),
              children: [
                TextSpan(text: 'ADD '),
                TextSpan(text: 'NEW'),
              ])),
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
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 2),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.45,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      color: cr_blue.withOpacity(0.8),
                      elevation: 100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Enter your ',
                                  style:
                                      TextStyle(fontSize: 20, color: cr_pri)),
                              TextSpan(
                                  text: ' detail',
                                  style: TextStyle(fontSize: 30, color: cr_pri))
                            ])),
                            hspace(20),
                            TextField(
                                controller: usercon,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  fillColor: CupertinoColors.white,
                                  filled: true,
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                        const ClipboardData(
                                          text: '',
                                        ),
                                      );
                                      passcon.text = '';
                                      Fluttertoast.showToast(
                                          msg: 'Password Copied to clipboard',);
                                    },
                                    child: Container(
                                      width: 110,
                                      height: 50,
                                      color: cr_sec,
                                      child: const Center(
                                          child: Text(
                                        'Generate',
                                        style: TextStyle(
                                            color: CupertinoColors.white,
                                            fontSize: 18,
                                            letterSpacing: 2),
                                      )),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
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
                                      width: 100,
                                      height: 50,
                                      color: cr_sec,
                                      child: Center(
                                        child: Text(
                                          edit ? 'change' : 'Add',
                                          style: const TextStyle(
                                              color: CupertinoColors.white,
                                              fontSize: 20,
                                              letterSpacing: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ),
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
