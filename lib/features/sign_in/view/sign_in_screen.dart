import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/router/router.dart';

import '../../../generated/l10n.dart';
import '../../../theme/theme.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _makeGuest() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isGuest', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).signIn),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).email),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).password),
                  obscureText: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(children: [
                  MaterialButton(
                    onPressed: () {
                      AutoRouter.of(context).navigate(ProfileRoute());
                    },
                    color: mainTheme.primaryColor,
                    minWidth: 200,
                    child: Text(
                      S.of(context).submit,
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).forgotPassword,
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context).push(SignUpRoute());
                    },
                    child: Text(
                      S.of(context).signUp,
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _makeGuest();
                      AutoRouter.of(context).popAndPush(const ProfileRoute());
                    },
                    child: Text(
                      S.of(context).guestType,
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                ]),
              )
            ])));
  }
}
