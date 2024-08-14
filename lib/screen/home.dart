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
import 'package:iconly/iconly.dart';
import '../constant/color.dart';
import '../constant/functions.dart';
import '../constant/widget.dart';
import '../db/passhelper.dart';
import '../object/vault.dart';
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
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        exit(0);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: cr_secac,
          title: const Text.rich(
            TextSpan(
              style: TextStyle(color: cr_sec),
              children: [
                TextSpan(text: 'Password ', style: TextStyle(fontSize: 30)),
                TextSpan(
                    text: ' locker',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          backgroundColor: cr_pri,
        ),
        drawer: const Draw3r(),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              cr_blk,
              cr_pri,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: RefreshIndicator(
            color: cr_pri,
            backgroundColor: cr_sec,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 3));
              setState(() {});
            },
            child: StreamBuilder(
              stream: VaultHelper().getvaults(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Vault> plist = snapshot.data;
                  if (plist.isEmpty) {
                    return Center(
                      child: Text(
                        "No records. \n ",
                        style: TextStyle(
                            color: cr_sec,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: plist.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Vault item = plist.elementAt(index);
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            MaterialButton(
                              color: Colors.blue.withOpacity(0.15),
                              elevation: 0,
                              height: 50,
                              minWidth: 50,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 30,
                              ),
                              onPressed: () {
                               route(context, Newpass(
                                   edit: true,
                                   id: item.id!,
                                   username: item.username,
                                   site: item.site,
                                   password: item.password,),);
                              },
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            MaterialButton(
                              color: Colors.redAccent.withOpacity(0.15),
                              elevation: 0,
                              height: 70,
                              minWidth: 70,
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  VaultHelper().delvault(item.id!);
                                });
                              },
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            route(
                                context,
                                Newpass(
                                    edit: true,
                                    id: item.id,
                                    username: item.username,
                                    site: item.site,
                                    password: item.password));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: GlassCard(
                              heigth: 150,
                              width: size.width,
                              color: cr_sec,
                              child: Row(
                                children: [
                                  wspace(10),
                                  CircleAvatar(
                                    radius: 35,
                                    child: Icon(
                                      IconlyBold.lock,
                                      size: 30,
                                      color: cr_sec.withOpacity(0.8),
                                    ),
                                    backgroundColor: cr_pri,
                                  ),
                                  wspace(10),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        item.site.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 28, color: cr_blk),
                                      ),
                                      subtitle: Text(
                                        item.username,
                                        style: const TextStyle(
                                            fontSize: 16, color: cr_grey),
                                      ),
                                    ),
                                  ),
                                  wspace(10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: cr_blk,
                                    ),
                                    child: IconButton(
                                        onPressed: () async {
                                          Clipboard.setData(ClipboardData(
                                              text: item.password));
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Password Copied to clipboard');
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.copy,
                                          color: cr_secac,
                                        )),
                                  ),
                                  wspace(10)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
            child: const Icon(
              IconlyBroken.lock,
              size: 30,
              color: cr_sec,
            ),
            backgroundColor: cr_pri,
            elevation: 0,
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
