import 'dart:math';

import 'package:flutter/material.dart';

class ImcController extends ChangeNotifier {
  double imc = 0.0;

  Future<void> calculateIMC({
    required double weight,
    required double height,
  }) async {
    imc = 0.0;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    imc = weight / pow(height, 2);
    notifyListeners();
  }
}
