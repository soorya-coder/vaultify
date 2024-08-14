import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vaultify/object/vault.dart';
import 'package:vaultify/screen/aboutus.dart';
import 'package:vaultify/screen/login.dart';
import 'package:vaultify/screen/newpass.dart';
import 'package:vaultify/service/authHelper.dart';
import 'constant/color.dart';
import 'constant/functions.dart';
import 'constant/widget.dart';
import 'firebase_options.dart';
import 'object/users.dart';
import 'screen/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(250, 500),
        builder: (context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: cr_pri,
              appBarTheme:
                  AppBarTheme(backgroundColor: Theme.of(context).primaryColor),
              textTheme: GoogleFonts.interTextTheme(),
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => GetUser(),
              '/home': (context) => Home(),
              '/login': (context) => const Login(),
              '/about': (context) => const AboutUs(),
              '/splash': (context) => const Splash(),
              '/new': (context) => Newpass(
                    edit: false,
                    vault: Vault(username: '', site: '', password: ''),
                  ),
              //'/': (context) => (),
            },
          );
        });
  }
}

class GetUser extends StatelessWidget {
  GetUser({Key? key}) : super(key: key);
  AuthHelper authHelper = AuthHelper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authHelper.authchanges(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (snapshot.hasData) {
            return StreamBuilder<Users?>(
              stream: authHelper.startup(),
              builder: (context, AsyncSnapshot<Users?> snapshot) {
                if (!snapshot.hasError) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Home();
                    }
                  }
                  return const Loading();
                } else {
                  return Errored(error: '${snapshot.error}1');
                }
              },
            );
          } else {
            return const Login();
          }
        }
        if (snapshot.hasError) {
          return Errored(error: '${snapshot.error}2');
        }
        return const Splash();
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cr_trt.withOpacity(0.8),
              cr_pri.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const CircleAvatar(
                radius: 50,
                backgroundColor: cr_wht,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: cr_pri,
                    size: 100,
                  ),
                ),
              ),
              hspace(20),
              Text(
                'Vaultify',
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  color: CupertinoColors.white,
                ),
              ),
              const Spacer(),
              LoadingAnimationWidget.hexagonDots(color: cr_pri, size: 30.r),
              hspace(20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: cr_pri.withOpacity(0.7),
          child:
              LoadingAnimationWidget.halfTriangleDot(color: cr_wht, size: 50),
        ),
      ),
    );
  }
}

class Errored extends StatelessWidget {
  Errored({Key? key, required this.error}) : super(key: key);
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: cr_pri.withOpacity(0.7),
        child: Center(
          child: Text(
            'error :$error',
            style: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}

class Inform extends StatelessWidget {
  Inform({Key? key, required this.info}) : super(key: key);
  String info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: cr_pri.withOpacity(0.7),
        child: Center(
          child: Text(
            info,
            style: TextStyle(color: Colors.amber.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}

class _SpalshState extends State<Spalsh> {
  @override
  void initState() {
    super.initState();
    mainscreen();
  }

  void mainscreen() async {
    Future.delayed(const Duration(seconds: 2), () async {
      routename(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              cr_pri.withOpacity(0.5),
              cr_trt,
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (boulds) => LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    cr_pri.withOpacity(0.5),
                    cr_pri.withOpacity(0.9),
                  ],
                ).createShader(boulds),
                child: const Icon(
                  FontAwesomeIcons.barcode,
                  size: 100,
                ),
              ),
              hspace(20),
              Text(
                'codingo qr'.toUpperCase(),
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  color: CupertinoColors.white,
                ),
              ),
              const Spacer(),
              const Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'FroM'),
                  TextSpan(
                      text: ' DARK3R',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ]),
                style: TextStyle(
                    fontFamily: 'elianto', fontSize: 20, color: cr_pri),
              ),
              const LinearProgressIndicator(
                minHeight: 10,
                backgroundColor: cr_sec,
                color: cr_trt,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route nextpage(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
              Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      },
    );
  }
}

class Spalsh extends StatefulWidget {
  const Spalsh({super.key});

  @override
  _SpalshState createState() => _SpalshState();
}
