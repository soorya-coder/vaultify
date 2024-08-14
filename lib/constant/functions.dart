import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void msg(String msg) => Fluttertoast.showToast(msg: msg);

void route(BuildContext context,Widget page){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) {
            return page;
          }
      )
  );
}

void routename(BuildContext context,String route){
  Navigator.pushNamed(
      context,
      route
  );
}

void goback(BuildContext context){
  Navigator.pop(context);
}

TValue? selectof<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
      TValue? defaultValue,
    ]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}

String get timenow {
  return DateTime.now().toIso8601String();
}

//2022-06-19T 20:35:07.218578
//012345678910

String timeof(String iso) {
  return '${iso.substring(11,13)}:${iso.substring(14,16)},${iso.substring(17,19)}';
}

String getime(String iso){
  final DateTime now = DateTime.now(),dateTime = DateTime.parse(iso);
  int min = now.difference(dateTime).inMinutes;
  int hour = now.difference(dateTime).inHours;
  int day = now.difference(dateTime).inDays;
  if(min<2){
    return 'Just now';
  }else if(min<61){
    return '$min mins ago';
  }else if(hour<25){
    return '$hour hours ago';
  }else if(day<5){
    return '$day days ago';
  }else {
    return '${dateTime.hour}:${dateTime.minute} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
