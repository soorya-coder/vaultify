import 'dart:io';
import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:vaultify/object/vault.dart';
import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';
import '../service/passhelper.dart';
import '../screen/newpass.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return ;
      },
      child: Scaffold(
        backgroundColor: cr_blk,
        drawer: const Draw3r(),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                cr_blk,
                cr_pri,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            child: Column(
              children: [
                Row(
                  children: [
                    wspace(5),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          IconlyBold.category,
                          color: cr_sec,
                          size: 15.r,
                        ),
                      );
                    }),
                    wspace(5),
                    Text(
                      'Vaultify',
                      style: GoogleFonts.styleScript(
                          color: cr_sec,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.sp),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: VaultHelper().getvaults(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Vault> plist = snapshot.data;
                      if (plist.isEmpty) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No records.\nTap lock icon to add new ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: cr_sec,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return RefreshIndicator(
                        color: cr_pri,
                        backgroundColor: cr_sec,
                        onRefresh: () async {
                          await Future.delayed(const Duration(seconds: 3));
                          setState(() {});
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: plist.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Vault vault = plist.elementAt(index);
                            return VaultTile(vault: vault);
                          },
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: cr_sec,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: AvatarGlow(
          //glowBorderRadius: BorderRadius.circular(20),
          glowColor: cr_sec,
          child: FloatingActionButton(
            onPressed: () {
              routename(context, '/new');
            },
            shape: const CircleBorder(),
            backgroundColor: cr_pri,
            elevation: 0,
            child: const Icon(
              IconlyBroken.lock,
              size: 30,
              color: cr_sec,
            ),
          ),
        ),
        /*SizedBox(
          height: 70,
          width: 180,
          child: Card(
            color: cr_brown,
            elevation: 8,
            shadowColor: cr_yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            child: InkWell(
              onTap: (){
                routename(context, '/new');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.lock_fill,
                      color: cr_yellow,
                      size: 30,
                    ),
                    hspace(10),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'ADD NEW',
                        style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: cr_yellow),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class VaultTile extends StatefulWidget {
  VaultTile({super.key, required this.vault});

  Vault vault;

  @override
  State<VaultTile> createState() => _VaultTileState();
}

class _VaultTileState extends State<VaultTile> {
  bool show = false;
  late Vault vault;
  @override
  Widget build(BuildContext context) {
    vault = widget.vault;
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          MaterialButton(
            color: Colors.blue.withOpacity(0.15),
            elevation: 0,
            shape: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(5.r),
              child: Icon(
                Icons.edit,
                color: Colors.blue,
                size: 20.r,
              ),
            ),
            onPressed: () {
              route(
                  context,
                  Newpass(
                    edit: true,
                    vault: vault,
                  ));
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          MaterialButton(
            color: Colors.redAccent.withOpacity(0.15),
            elevation: 0,
            shape: const CircleBorder(),
            child: Padding(
              padding: EdgeInsets.all(5.r),
              child: Icon(
                IconlyBold.delete,
                color: Colors.redAccent,
                size: 20.r,
              ),
            ),
            onPressed: () {
              setState(() {
                VaultHelper().delvault(vault.id!);
              });
            },
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          route(context, Newpass(edit: true, vault: vault));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: GlassCard(
            heigth: 70.h,
            width: double.maxFinite,
            color: cr_sec,
            child: Row(
              children: [
                wspace(5),
                CircleAvatar(
                  radius: 20.sp,
                  backgroundColor: cr_pri,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    child: Icon(
                      show ? Icons.lock_open : IconlyBold.lock,
                      size: 15.r,
                      color: cr_sec.withOpacity(0.8),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      vault.site,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: cr_blk,
                      ),
                    ),
                    subtitle: Text(
                      show ? vault.username : '********',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: cr_grey,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          Clipboard.setData(
                              ClipboardData(text: vault.password));
                          Fluttertoast.showToast(
                            msg: 'Password Copied to clipboard',
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.copy,
                          color: cr_secac,
                          size: 12.sp,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
