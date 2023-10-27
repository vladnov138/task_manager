import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/repository/abstract_repository.dart';
import 'package:task_manager/router/router.dart';

import '../../../generated/l10n.dart';
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
          title: Text(S.of(context).signUp),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).name),
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).email),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    login = value;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).password),
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
                      S.of(context).signUp,
                      style: mainTheme.textTheme.labelMedium,
                    ),
                  ),
                ]),
              )
            ])));
    ;
  }
}
