import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/router/router.dart';

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
          title: const Text("Sign in"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Password"),
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
                      "Submit",
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password",
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      AutoRouter.of(context).push(const SignUpRoute());
                    },
                    child: Text(
                      "Sign Up",
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _makeGuest();
                      AutoRouter.of(context).popAndPush(const ProfileRoute());
                    },
                    child: Text(
                      "Guest type",
                      style: mainTheme.textTheme.labelSmall,
                    ),
                  ),
                ]),
              )
            ])));
  }
}
