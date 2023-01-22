import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gauge_range.dart';

class ImcGauge extends StatelessWidget {
  const ImcGauge({
    super.key,
    required this.imc,
  });

  final double imc;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: [
            ImcGaugeRange(
              color: Colors.blue,
              startValue: 12.5,
              endValue: 18.5,
              label: 'MAGREZA',
            ),
            ImcGaugeRange(
              color: Colors.green,
              startValue: 18.5,
              endValue: 24.5,
              label: 'SAUDÁVEL',
            ),
            ImcGaugeRange(
              color: Colors.yellow[600],
              startValue: 24.5,
              endValue: 29.9,
              label: 'SOBREPESO',
            ),
            ImcGaugeRange(
              color: Colors.red[500],
              startValue: 29.9,
              endValue: 39.9,
              label: 'OBESIDADE',
            ),
            ImcGaugeRange(
              color: Colors.red[900],
              startValue: 39.9,
              endValue: 47.9,
              label: 'OBESIDADE GRAVE',
            ),
          ],
          pointers: [
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            )
          ],
        ),
      ],
    );
  }
}
