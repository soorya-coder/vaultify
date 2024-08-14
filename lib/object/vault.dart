
const String col_id = 'id';
const String col_user = 'username';
const String col_site = 'site';
const String col_pass = 'password';
const String col_time = 'time';
//const String col_ = '';

class Vault{

  String? id;
  String username,site,password;

  Vault({
    this.id,
    required this.username,
    required this.site,
    required this.password
  });

  factory Vault.fromMap(Map<String, dynamic> json) => Vault(
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