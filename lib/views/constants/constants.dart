import 'package:flutter/material.dart';

const double kPaddingHorizontal = 12.0;
const double kSizedBoxHeight = 16.0;
const double kButtonRadius = 10.0;
const double kAppBarTitleSpacing = 8.0;

// Colors
const kPrimaryColor = Colors.black54;
const kSecondaryColor = Color(0xFFF3F3F3);
const kTerTertiary = Colors.black;

const Color kTextFieldBackgroundColor = Color(0xFFF3F3F3);
const Color kTextFieldHintColor = Colors.grey;

const kBorderRadius = BorderRadius.all(Radius.circular(15));

const kPrimaryButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kSecondaryButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kTertiaryButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const InputDecoration kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: kTextFieldBackgroundColor,
  border: OutlineInputBorder(
    borderRadius: kBorderRadius,
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: kBorderRadius,
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: kBorderRadius,
    borderSide: BorderSide.none,
  ),
  hintStyle: TextStyle(
    color: kTextFieldHintColor,
  ),
);
