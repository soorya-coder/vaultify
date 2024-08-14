import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vaultify/constant/functions.dart';
import 'package:vaultify/screen/login.dart';
import 'package:vaultify/service/authHelper.dart';
import 'color.dart';

class Userhead extends StatelessWidget {
  Color color;
  String name, email;
  IconData icon;

  Userhead(
      {Key? key,
      required this.color,
      required this.name,
      required this.email,
      this.icon = FontAwesomeIcons.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fill,
              child: CircleAvatar(
                backgroundColor: color,
                foregroundImage:
                    CachedNetworkImageProvider(AuthHelper.myuser!.photoURL!),
                child: const Icon(
                  IconlyBold.profile,
                  color: cr_wht,
                ),
              ),
            ),
          ),
          wspace(10),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w900,
                    color: cr_sec,
                  ),
                  textAlign: TextAlign.start,
                ),
                hspace(5),
                Text(
                  email,
                  style: TextStyle(
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w200,
                      color: cr_sec),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.icon,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = cr_sec;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(
              color: cr_wht, fontWeight: FontWeight.w900, letterSpacing: 1.sp)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

class Draw3r extends Drawer {
  const Draw3r({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: cr_blk, // Color(0xff4338CA),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5.h),
              child: Column(
                children: [
                  hspace(8.h),
                  FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(color: cr_sec),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Center(
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: snapshot.data!.appName.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: cr_sec,
                                  ),
                                ),
                                TextSpan(
                                  text: ' @ ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 10.sp,
                                    color: cr_sec.withOpacity(0.8),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${snapshot.data!.version}+(${snapshot.data!.buildNumber})',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: cr_sec,
                                  ),
                                )
                              ]),
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  const Divider(color: cr_pri),
                  Userhead(
                    color: cr_pri,
                    name: AuthHelper.myuser!.displayName!,
                    email: AuthHelper.myuser!.email!,
                  ),
                  const Divider(color: cr_pri),
                  MenuItem(
                    text: 'Home',
                    icon: IconlyBold.home,
                    onClicked: () {
                      routename(context, '/home');
                    },
                  ),
                  MenuItem(
                    text: 'About Us',
                    icon: IconlyBold.discovery,
                    onClicked: () {
                      routename(context, '/about');
                    },
                  ),
                  hspace(2.h),
                  const Divider(color: cr_pri),
                  /*Card(
                    color: cr_livioet,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: ListTile(
                      onTap: (){

                      },
                      leading: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.r),
                        ),color: cr_wht,
                        child:  const Icon(Icons.add,color: cr_livioet),
                      ),
                      title: const Text('New Flow',style: TextStyle(color: cr_wht),),
                    ),
                  ),*/
                  //const Spacer(),
                  Card(
                    color: cr_pri.withOpacity(0.8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: MenuItem(
                      text: 'Log out',
                      icon: IconlyLight.logout,
                      onClicked: () async {
                        await AuthHelper().signOut();
                        route(context, const Login());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class GlassCard extends StatelessWidget {
  Widget child;
  double width, heigth;
  EdgeInsets padding;
  Color color;
  GlassCard(
      {required this.child,
      this.width = 150,
      this.heigth = 200,
      this.color = Colors.grey,
      this.padding = const EdgeInsets.all(10),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          width: width,
          height: heigth,
          padding: padding,
          decoration: BoxDecoration(
              border: Border.all(color: cr_pri, width: .25),
              borderRadius: BorderRadius.circular(15.0),
              color: color.withOpacity(0.2)),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}

class Glassbutton extends StatelessWidget {
  Function onpressed;
  String name;
  Color color;
  Glassbutton(
      {Key? key,
      required this.name,
      required this.color,
      required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: InkWell(
          onTap: () {
            onpressed();
          },
          splashColor: color.withOpacity(0.5),
          hoverColor: color.withOpacity(0.5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: color, width: .4),
                borderRadius: BorderRadius.circular(15.0),
                color: color.withOpacity(0.25)),
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                    fontSize: 20.0, color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget option({Color color = cr_sec}) {
  return PopupMenuButton<String>(
    icon: ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (boulds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color],
      ).createShader(boulds),
      child: const Icon(CupertinoIcons.ellipsis_vertical),
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Row(
          children: const [
            Icon(
              CupertinoIcons.delete,
            ),
            Spacer(),
            Center(child: Text('')),
          ],
        ),
        value: '0',
        onTap: () {},
      ),
      PopupMenuItem(
        child: Row(
          children: const [
            Icon(
              Icons.edit,
            ),
            SizedBox(
              width: 15,
            ),
            Center(child: Text('')),
          ],
        ),
        value: '0',
        onTap: () {},
      )
    ],
  );
}

Widget back(Function function) {
  return IconButton(
      onPressed: () => function,
      icon: const Icon(
        CupertinoIcons.back,
        color: Colors.white,
      ));
}

Widget hspace(double height) {
  return SizedBox(height: height.h);
}

Widget wspace(double width) {
  return SizedBox(width: width.w);
}

Widget present() {
  return Container(
    height: 60,
    width: 120,
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Opacity(
                opacity: 0.4,
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.clear_thick_circled,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/*Widget future(){
  return FutureBuilder(
    builder: (context,AsyncSnapshot snapshot){
      if(!snapshot.hasError){
        if(snapshot.connectionState != ConnectionState.waiting) {
          if(snapshot.hasData){
            List lists = snapshot.data ?? [];
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: lists.length,
              itemBuilder: (context,index){
                var item = lists[index];
                return const Card();
              },
            );
          }else {
            return const Center(child: const Text(' has no data'),);
          }
        }else {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
        }
      }else {
        return Center(
          child: Text(
            snapshot.error.toString(),
            style: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
          ),
        );
      }

    },
  );
}*/

class ButtonImageFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const ButtonImageFb1({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: AspectRatio(
        aspectRatio: 208 / 71,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                color: const Color(0x4960F9).withOpacity(.3),
                spreadRadius: 4,
                blurRadius: 50)
          ]),
          child: MaterialButton(
            onPressed: onPressed,
            splashColor: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
                decoration: BoxDecoration(
                  //gradient:
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/finance_app_2%2FbuttonBackgroundSmall.png?alt=media&token=fa2f9bba-120a-4a94-8bc2-f3adc2b58a73"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 88.0,
                        minHeight: 36.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Text(text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300)))),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Function() onMoreTap;

  final String subInfoTitle;
  final String subInfoText;
  final Widget subIcon;

  const InfoCard(
      {required this.title,
      this.body =
          """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
      required this.onMoreTap,
      this.subIcon = const CircleAvatar(
        child: Icon(
          Icons.directions,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        radius: 25,
      ),
      this.subInfoText = "545 miles",
      this.subInfoTitle = "Directions",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 10),
              blurRadius: 0,
              spreadRadius: 0,
            )
          ],
          gradient: const RadialGradient(
            colors: [Colors.orangeAccent, Colors.orange],
            focal: Alignment.topCenter,
            radius: .85,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 75,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  gradient: const LinearGradient(
                      colors: [Colors.white, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: GestureDetector(
                  onTap: onMoreTap,
                  child: const Center(
                      child: Text(
                    "More",
                    style: const TextStyle(color: Colors.orange),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style:
                TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
          ),
          const SizedBox(height: 15),
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  subIcon,
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subInfoTitle),
                      Text(
                        subInfoText,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardFb1 extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String subtitle;
  final Function() onPressed;

  const CardFb1(
      {required this.text,
      required this.imageUrl,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 250,
        height: 230,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 90, fit: BoxFit.cover),
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class DialogFb1 extends StatelessWidget {
  const DialogFb1({Key? key}) : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: 25,
              child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/FlutterBricksLogo-Med.png?alt=media&token=7d03fedc-75b8-44d5-a4be-c1878de7ed52"),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("How are you doing?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            const Text("This is a sub text, use it to clarify",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Great", onPressed: () {}),
                SimpleBtn1(
                  text: "Not bad",
                  onPressed: () {},
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}

class EmailInputFb1 extends StatelessWidget {
  final TextEditingController inputController;
  const EmailInputFb1({Key? key, required this.inputController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(.9)),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1)),
          ]),
          child: TextField(
            controller: inputController,
            onChanged: (value) {
              //Do something wi
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              // prefixIcon: Icon(Icons.email),
              filled: true,
              fillColor: accentColor,
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: errorColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

gradient4() {
  return LinearGradient(colors: [Colors.blue, Colors.blue.shade900]);
}

class AnimatedPageIndicatorFb1 extends StatelessWidget {
  const AnimatedPageIndicatorFb1(
      {Key? key,
      required this.currentPage,
      required this.numPages,
      this.dotHeight = 10,
      this.activeDotHeight = 10,
      this.dotWidth = 10,
      this.activeDotWidth = 20,
      this.gradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)]),
      this.activeGradient =
          const LinearGradient(colors: [Color(0xff4338CA), Color(0xff6D28D9)])})
      : super(key: key);

  final int
      currentPage; //the index of the active dot, i.e. the index of the page you're on
  final int
      numPages; //the total number of dots, i.e. the number of pages your displaying

  final double dotWidth; //the width of all non-active dots
  final double activeDotWidth; //the width of the active dot
  final double activeDotHeight; //the height of the active dot
  final double dotHeight; //the height of all dots
  final Gradient gradient; //the gradient of all non-active dots
  final Gradient activeGradient; //the gradient of the active dot

  double _calcRowSize() {
    //Calculates the size of the outer row that creates spacing that is equivalent to the width of a dot
    const int widthFactor = 2; //assuming spacing is equal to the width of a dot
    return (dotWidth * numPages * widthFactor) + activeDotWidth - dotWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _calcRowSize(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          numPages,
          (index) => AnimatedPageIndicatorDot(
            isActive: currentPage == index,
            gradient: gradient,
            activeGradient: activeGradient,
            activeWidth: activeDotWidth,
            activeHeight: activeDotHeight,
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicatorDot extends StatelessWidget {
  const AnimatedPageIndicatorDot(
      {Key? key,
      required this.isActive,
      this.height = 10,
      this.width = 10,
      this.activeWidth = 20,
      this.activeHeight = 10,
      required this.gradient,
      required this.activeGradient})
      : super(key: key);

  final bool isActive;
  final double height;
  final double width;
  final double activeWidth;
  final double activeHeight;
  final Gradient gradient;
  final Gradient activeGradient;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isActive ? activeWidth : width,
      height: isActive ? activeHeight : height,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          gradient: isActive ? activeGradient : gradient,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
    );
  }
}

String im1 =
    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Holiday%2FThanksgiving-03.png?alt=media&token=5e0b5969-4de3-4dd9-83b3-f24d4f314bf7";
String dear1 =
    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Christmas%20Illustrations%2FReindeer.png?alt=media&token=83096fa1-a6f3-4ef4-80d9-83c75f5a13dc";
String crima1 =
    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Christmas%20Illustrations%2FSocks.png?alt=media&token=705f3255-90cd-4c4c-87bc-5cb4f3eabc25";
String mous1 =
    "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/Illustrations%20Icons%2Fgamingmouse.png?alt=media&token=81fd6f20-2322-4435-af62-25b4cf5d9e81";
