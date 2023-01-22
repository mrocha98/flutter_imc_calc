import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';
import 'imc_controller.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({super.key});

  static const String route = '/change-notifier';

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  final imcController = ImcController();

  final weightEC = TextEditingController();

  final heightEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
        title: const Text('Change Notifier'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: imcController,
                  builder: (_, __) => ImcGauge(imc: imcController.imc),
                ),
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
                    imcController.calculateIMC(weight: weight, height: height);
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
