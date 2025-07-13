import 'package:flutter/material.dart';

extension CustomColors on ThemeData {
  Color get neonGreen => brightness == Brightness.dark
      ? const Color.fromRGBO(213, 255, 95, 1.0)
      : const Color.fromRGBO(213, 255, 95, 1.0);

  Color get darkGreen => brightness == Brightness.dark
      ? const Color.fromRGBO(3, 79, 67, 1.0)
      : const Color.fromRGBO(3, 79, 67, 1.0);

  Color get cottonSeed => brightness == Brightness.dark
      ? const Color.fromRGBO(186, 186, 186, 1.0)
      : const Color.fromRGBO(186, 186, 186, 1.0);

  Color get outerSpace => brightness == Brightness.dark
      ? const Color.fromRGBO(45, 45, 53, 1.0)
      : const Color.fromRGBO(45, 45, 53, 1.0);

  Color get raisinBlack => brightness == Brightness.dark
      ? const Color.fromRGBO(30, 31, 36, 1.0)
      : const Color.fromRGBO(30, 31, 36, 1.0);

  Color get redWine => brightness == Brightness.dark
      ? const Color.fromRGBO(197, 29, 29, 1.0)
      : const Color.fromRGBO(197, 29, 29, 1.0);

  Color get midGrey => brightness == Brightness.dark
      ? const Color.fromRGBO(101, 101, 101, 1.0)
      : const Color.fromRGBO(101, 101, 101, 1.0);
}