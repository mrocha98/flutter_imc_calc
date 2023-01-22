abstract class ImcState {}

class ImcStateData extends ImcState {
  ImcStateData({this.imc = 0});

  final double imc;
}

class ImcStateLoading extends ImcState {}

class ImcStateError extends ImcState {
  ImcStateError({required this.message});

  final String message;
}
