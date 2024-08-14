import 'package:flutter/widgets.dart';
import 'package:pass_locker/db/passhelper.dart';

class Pword{

  int? id;
  String username,site,password;

  Pword({
    this.id,
    required this.username,
    required this.site,
    required this.password
  });

  factory Pword.fromMap(Map<String, dynamic> json) => Pword(
    id: json[col_id],
    username: json[col_user],
    site: json[col_site],
    password: json[col_pass],
  );

  Map<String, dynamic> toMap() {
    return {
      col_id: id,
      col_user: username,
      col_site: site,
      col_pass: password,
    };
  }

}