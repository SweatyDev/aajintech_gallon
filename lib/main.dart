import 'package:flutter/material.dart';
import 'package:background/background.dart';

void main() {
  runApp(const AdditiveCalculator());
}

class AdditiveCalculator extends StatefulWidget {
  const AdditiveCalculator({super.key});

  @override
  State<AdditiveCalculator> createState() => _AdditiveCalculatorState();
}

class _AdditiveCalculatorState extends State<AdditiveCalculator> {
  final _textController = TextEditingController();
  String calcOutput = 'N/A';

  List<String> metrics = ['Litres', 'Gallons'];
  String chosenMetric = 'Litres';

  // This will calculate and ouput the additive needed depending on user input.
  void calculate() {
    setState(() {
      // Cast String -> double
      var input = double.tryParse(_textController.text);

      // Validation.
      if (input == null) {
        calcOutput = 'Please give a valid input.';
        return;
      }

      // Matric handling.
      String fuelMetric = '';
      int fuelMultiplier = 1;

      if (chosenMetric == 'Litres') {
        fuelMetric = 'centilitres';
      } else {
        fuelMetric = 'ounces';
        fuelMultiplier = 128;
      }

      // Calculate fuel required in the chosen metric.
      String fuel = ((input / 1500) * fuelMultiplier).toStringAsFixed(1);
      // Output result.
      calcOutput = 'Additive in: $fuel $fuelMetric.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAJintech Additive Calculator',
      home: Scaffold(
        body: Stack(
          children: [
            Background(
              path: 'assets/truck_fuel.png',
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // I hate how compact flutter code can be :(
                      //
                      //
                      children: [
                        // Options for metrics.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            //
                            Row(
                              children: [
                                Radio(
                                  value: metrics[0],
                                  groupValue: chosenMetric,
                                  onChanged: (value) {
                                    chosenMetric = value.toString();
                                    calculate();
                                  },
                                ),

                                const Text('Litres'),
                              ],
                            ),

                            Row(
                              children: [
                                Radio(
                                  value: metrics[1],
                                  groupValue: chosenMetric,
                                  onChanged: (value) {
                                    chosenMetric = value.toString();
                                    calculate();
                                  },
                                ),

                                const Text('US Gallons'),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 15), // Padding.
                        // Input row.
                        Row(
                          children: [
                            Text('Input $chosenMetric:'),

                            const SizedBox(
                              width: 10,
                            ), // Padding between field and text.

                            Expanded(
                              // Fuel input.
                              child: TextField(
                                controller: _textController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: '$chosenMetric',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onChanged: (value) {
                                  calculate();
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15), // Padding.
                        // Output text.
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            calcOutput,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // AAJ corner logo.
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/aaj_logo.png', width: 125.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
