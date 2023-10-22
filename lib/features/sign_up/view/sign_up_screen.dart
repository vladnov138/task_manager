import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                        onPressed: () { },
                        color: Colors.blue,
                        minWidth: 200,
                        child: Text(
                          "Sign up",
                          style: mainTheme.textTheme.labelMedium,
                        ),
                      ),
                    ]),
                  )
                ])));;
  }
}
