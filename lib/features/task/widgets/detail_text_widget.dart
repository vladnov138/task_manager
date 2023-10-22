import 'dart:math';

import 'package:flutter/material.dart';

class DetailTextWidget extends StatefulWidget {
  const DetailTextWidget({super.key, required this.text});

  final String text;

  @override
  State<DetailTextWidget> createState() => _DetailTextWidgetState();
}

class _DetailTextWidgetState extends State<DetailTextWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: TextFormField(
        controller: TextEditingController(
          text: widget.text,
        ),
        expands: true,
        maxLines: null,
        onChanged: (text) => {},
        keyboardType: TextInputType.text,
      ),
    );
  }
}
