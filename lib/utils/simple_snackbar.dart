import 'package:flutter/material.dart';

void simpleSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
