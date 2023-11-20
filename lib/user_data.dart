
class user_data{
  static final user_data _instance = user_data._internal();
  factory user_data(){
    return _instance;
  }
  user_data._internal(){}

  static bool _login_check = false;
  static String _user_nickname = "";
  static String _user_email = "";
  static String _user_roles = "";


  void input_login_data(String nickname,String email,String roles){
    _user_nickname = nickname;
    _user_email = email;
    _user_roles = roles;
    _login_check = true;
  }

  void reset_login_data()
  {
    _user_nickname = "";
    _user_email = "";
    _user_roles = "";
    _login_check = false;
  }

  bool get_login_check() => _login_check;
  String get_nickname() => _user_nickname;
  String get_email() => _user_email;
  String get_roles() => _user_roles;


}