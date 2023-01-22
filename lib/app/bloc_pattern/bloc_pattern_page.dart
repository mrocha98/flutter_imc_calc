import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';
import 'imc_bloc_controller.dart';
import 'imc_state.dart';

class BlocPatternPage extends StatefulWidget {
  const BlocPatternPage({super.key});

  static const String route = '/bloc-pattern';

  @override
  State<BlocPatternPage> createState() => _BlocPatternPageState();
}

class _BlocPatternPageState extends State<BlocPatternPage> {
  final imcBlocController = ImcBlocController();

  final weightEC = TextEditingController();

  final heightEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    imcBlocController.dispose();
    weightEC.dispose();
    heightEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: imcBlocController.imcOut,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    final imc = data is ImcStateData ? data.imc : 0.0;
                    return ImcGauge(imc: imc);
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder<ImcState>(
                  stream: imcBlocController.imcOut,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data is ImcStateError) {
                      return Text(
                        data.message,
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    if (data is ImcStateLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const SizedBox.shrink();
                  },
                ),
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
                  onPressed: () async {
                    final formValid = formKey.currentState?.validate() ?? false;
                    if (!formValid) return;
                    final formatter = NumberFormat.simpleCurrency(
                      locale: 'pt_BR',
                      decimalDigits: 2,
                    );
                    final weight = formatter.parse(weightEC.text).toDouble();
                    final height = formatter.parse(heightEC.text).toDouble();
                    await imcBlocController.calculateIMC(
                      weight: weight,
                      height: height,
                    );
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
