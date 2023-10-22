import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                      Navigator.of(context).pushNamed(
                          '/sign_up',
                      );
                    },
                    color: Colors.blue,
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
                ]),
              )
            ])));
  }
}
