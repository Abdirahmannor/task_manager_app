import 'package:hive/hive.dart';

class SessionManager {
  final _sessionBox = Hive.box('sessionBox');

  void saveUserSession(String email) {
    _sessionBox.put('isLoggedIn', true);
    _sessionBox.put('email', email);
  }

  bool isUserLoggedIn() {
    return _sessionBox.get('isLoggedIn', defaultValue: false);
  }

  String? getUserEmail() {
    return _sessionBox.get('email');
  }

  void clearUserSession() {
    _sessionBox.delete('isLoggedIn');
    _sessionBox.delete('email');
  }
}
