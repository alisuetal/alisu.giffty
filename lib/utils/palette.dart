import 'package:flutter/material.dart';

class PaletteColor {
  static const palette = MaterialColor(
    0xffDB5151, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffDB5151), //10%
      100: Color(0xffDB5151), //20%
      200: Color(0xffDB5151), //30%
      300: Color(0xffDB5151), //40%
      400: Color(0xffDB5151), //50%
      500: Color(0xffDB5151), //60%
      600: Color(0xffDB5151), //70%
      700: Color(0xffDB5151), //80%
      800: Color(0xffDB5151), //90%
      900: Color(0xffDB5151), //100%
    },
  );
  static const secondary = Color(0xFF0F162E);
}
