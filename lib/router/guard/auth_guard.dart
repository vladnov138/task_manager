import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool isAuthed = false;

  bool isGuest = false;

  void _initSharedPreferences() async {
    _prefs = SharedPreferences.getInstance();
    isAuthed = await _isAuthed();
    isGuest = await _isGuest();
  }

  Future<bool> _isAuthed() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool('isAuthed') ?? false;
  }

  Future<bool> _isGuest() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool('isGuest') ?? false;
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _initSharedPreferences();
    if (isAuthed || isGuest) {
      resolver.next();
    } else {
      router.push(const SignInRoute());
    }
  }
}
