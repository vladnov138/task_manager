import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(date)
      ],
    );
  }
}
