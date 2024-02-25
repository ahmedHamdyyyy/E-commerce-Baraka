import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';

ButtonStyle elevatedButtonTheme() {
  return ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: checkOutCartColor[0],
    foregroundColor: primaryColor[1],
    minimumSize: const Size(double.infinity, 48),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
}
