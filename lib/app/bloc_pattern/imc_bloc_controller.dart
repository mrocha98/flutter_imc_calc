import 'dart:async';
import 'dart:math';

import 'imc_state.dart';

class ImcBlocController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcStateData());

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  void dispose() {
    _imcStreamController.close();
  }

  Future<void> calculateIMC({
    required double weight,
    required double height,
  }) async {
    _imcStreamController.add(ImcStateLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final imc = weight / pow(height, 2);
      _imcStreamController.add(ImcStateData(imc: imc));
    } catch (_) {
      _imcStreamController.add(
        ImcStateError(message: 'Erro ao calcular IMC'),
      );
    }
  }
}
