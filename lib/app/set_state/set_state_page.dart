import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';

class SetStatePage extends StatefulWidget {
  const SetStatePage({super.key});

  static const String route = '/set-state';

  @override
  State<SetStatePage> createState() => _SetStatePageState();
}

class _SetStatePageState extends State<SetStatePage> {
  final weightEC = TextEditingController();

  final heightEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  double imc = 0.0;

  Future<void> _calculateIMC({
    required double weight,
    required double height,
  }) async {
    setState(() {
      imc = 0.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      imc = weight / pow(height, 2);
    });
  }

  @override
  void dispose() {
    weightEC.dispose();
    heightEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ImcGauge(imc: imc),
                const SizedBox(height: 20),
                TextFormField(
                  controller: weightEC,
                  decoration: const InputDecoration(
                    labelText: 'Peso (Kg)',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: heightEC,
                  decoration: const InputDecoration(
                    labelText: 'Altura (m)',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatória';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final formValid = formKey.currentState?.validate() ?? false;
                    if (!formValid) return;
                    final formatter = NumberFormat.simpleCurrency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                    );
                    final weight = formatter.parse(weightEC.text).toDouble();
                    final height = formatter.parse(heightEC.text).toDouble();
                    _calculateIMC(weight: weight, height: height);
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
