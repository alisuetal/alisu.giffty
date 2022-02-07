import 'package:flutter/material.dart';

const palette = MaterialColor(
  0xff000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0x1a000000), //10%
    100: Color(0x33000000), //20%
    200: Color(0x4d000000), //30%
    300: Color(0x66000000), //40%
    400: Color(0x80000000), //50%
    500: Color(0x99000000), //60%
    600: Color(0xb3000000), //70%
    700: Color(0xcc000000), //80%
    800: Color(0xe6000000), //90%
    900: Color(0xff000000), //100%
  },
);
