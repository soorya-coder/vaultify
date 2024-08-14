import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant/widget.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _mainlogState extends State<mainlog> {

  List<Widget> page = [const firstpage(),const secondpage()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendents App'),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.red.withOpacity(0.55),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      size: 100,
                      color: Colors.redAccent.withOpacity(0.2),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 30,color: Colors.redAccent.withOpacity(0.6),fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: page[0]
              ),
            ],
          ),
        ),
      ),
    );
  }
}


int np = 1;

List<bool> page = [true,false,false];

class _firstpageState extends State<firstpage> {

  List<register> det = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent.withOpacity(0.2),
            Colors.redAccent.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child: Column(
              children:  [
                const Text('Enter your details',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                hspace(20),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Username',
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (String name){
                    setState(() {
                      pname = name;
                    });
                  },
                ),
                hspace(20),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.building_2_fill,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Name of Institution',
                    labelText: 'Institution',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (instition){
                    setState(() {
                      pinstut = instition;
                    });
                  },
                ),
                hspace(20,),
                TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    suffix: const Text('@gmail.com'),
                    prefixIcon: Icon(Icons.email_outlined,color: Colors.redAccent.shade700,),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.8))
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.withOpacity(0.2),width: 2)
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Useremail',
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.redAccent.withOpacity(0.5)),
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                  onChanged: (email){
                    setState(() {
                      pemail = email;
                    });
                  },
                ),
                hspace(30),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () async{
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString('pname', pname);
                        pref.setString('pinstution', pinstut);
                        pref.setString('pemail', pemail);

                        route(context, screens[inrout]);
                        /*setState(() {
                    np = 1;
                  });*/

                      },
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Next',style: TextStyle(fontSize: 20,color: Colors.white70,),),
                              wspace(10),
                              const Icon(CupertinoIcons.arrow_right,color: Colors.white70,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    wspace(20),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _secondpageState extends State<secondpage> {

  List<register> det = [];

  @override
  void initState() {
    super.initState();
    det = [
      register(type: 'Spr number', yn: true),
      register(type: 'Name', yn: false),
      register(type: 'Register number', yn: true)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent.withOpacity(0.2),
            Colors.redAccent.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 50,bottom: 50,left: 20,right: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children:  [
                  const Text('Select register details',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  hspace(20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: det.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(det.elementAt(index).type),
                        leading: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.red,
                          focusColor: Colors.yellowAccent,
                          hoverColor: Colors.redAccent,
                          value: det.elementAt(index).yn,
                          onChanged: (bool? value) {
                            setState(() {
                              det.elementAt(index).yn = value!;
                            });
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    /*setState(() {
                      np--;
                    });

                     */
                  },
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.redAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Next ',style: TextStyle(fontSize: 20,color: Colors.white70,),),
                          wspace(10),
                          const Icon(CupertinoIcons.arrow_right,color: Colors.white70,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class mainlog extends StatefulWidget {
  const mainlog({Key? key}) : super(key: key);

  @override
  _mainlogState createState() => _mainlogState();
}

class secondpage extends StatefulWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  _secondpageState createState() => _secondpageState();
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}
