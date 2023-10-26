import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/repository/abstract_repository.dart';
import 'package:task_manager/router/router.dart';

import '../../../theme/theme.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  String? login;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    login = value;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25),
                child: Column(children: [
                  MaterialButton(
                    onPressed: () {
                      GetIt.I<AbstractRepository>().signUp(login!, password!);
                      AutoRouter.of(context).popAndPush(const ProfileRoute());
                    },
                    color: mainTheme.primaryColor,
                    minWidth: 200,
                    child: Text(
                      "Sign up",
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                ]),
              )
            ])));
    ;
  }
}
