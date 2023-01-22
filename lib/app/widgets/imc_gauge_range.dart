import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRange extends GaugeRange {
  ImcGaugeRange({
    super.key,
    required super.color,
    required super.startValue,
    required super.endValue,
    required super.label,
  }) : super(
          sizeUnit: GaugeSizeUnit.factor,
          labelStyle: const GaugeTextStyle(
            fontFamily: 'Times',
            fontSize: 12,
          ),
          startWidth: 0.65,
          endWidth: 0.65,
        );
}
