// ignore_for_file: constant_identifier_names

const String col_uid = 'uid';
const String col_name = 'name';
const String col_logins = 'login_ats';
const String col_crtm = 'created_at';
const String col_email = 'email';
const String col_url = 'photo_url';
const String col_ = '';

class Users {
  String uid, name,crtime,email,url;
  List<String> logins;

  Users({
    required this.uid,
    required this.name,
    required this.crtime,
    required this.logins,
    required this.email,
    required this.url
  });

  factory Users.fromMap(Map<String, dynamic>? map) => Users(
    uid: map![col_uid] ?? '',
    name: map[col_name] ?? '',
    logins: List.castFrom(map[col_logins]?? []),
    crtime: map[col_crtm],
    email : map[col_email] ?? '',
    url:  map[col_url] ?? ''
  );

  Map<String, dynamic> toMap(){
    return {
      col_uid: uid,
      col_name: name,
      col_crtm: crtime,
      col_email: email,
      col_url: url,
    };
  }

}
