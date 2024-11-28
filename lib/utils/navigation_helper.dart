import 'package:flutter/material.dart';

void navigateTo(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

void navigateBack(BuildContext context) {
  Navigator.pop(context);
}
