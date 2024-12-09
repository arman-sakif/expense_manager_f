import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserViewModel extends ChangeNotifier{

  // Future<bool> saveUser(UserModel user) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('token', user.token.toString());
  //   sp.setString('user', userModelToJson(user));
  //   notifyListeners();
  //   return true ;
  // }

  Future<bool> saveUser(UserModel body) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('id_token', body.body?.idToken ?? ''); // Assuming token is inside User object
    sp.setString('user_id', body.body?.userId ?? ''); // Assuming token is inside User object
    sp.setString('access_token', body.body?.accessToken ?? ''); // Assuming token is inside User object
    // sp.setString('company_id', body.body?.companyId ?? ''); // Assuming token is inside User object
    notifyListeners();
    return true;
  }


  Future<UserModel?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? idToken = sp.getString('id_token');
    final String? userId = sp.getString('user_id');
    final String? accessToken = sp.getString('access_token');
    // final String? companyId = sp.getString('company_id');

    if (idToken != null && userId != null && accessToken != null) {
      Body user = Body(userId: userId, idToken: idToken, accessToken: accessToken);
      return UserModel(body: user);
    }

    return null;
  }

  // Future<UserModel> getUser() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   final String? token = sp.getString('token');
  //   final String? userJson = sp.getString('user');
  //   if (userJson != null) {
  //     return userModelFromJson(userJson);
  //   }
  //   return UserModel(token: token.toString(), user: null);
  // }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('id_token');
    sp.remove('user_id');
    sp.remove('access_token');
    sp.remove('company_id');
    //notifyListeners();
    return true;
  }
}
