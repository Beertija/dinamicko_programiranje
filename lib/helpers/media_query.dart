import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

bool orientationMode(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait){
    return true;
  } else {
    return false;
  }
}

double fontSize(BuildContext context) {
  return MediaQuery.of(context).textScaleFactor;
}