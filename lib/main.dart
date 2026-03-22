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
  String calcOutput = "Additive in: ";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAJintech Additive Calculator',
      home: Scaffold(
        body: Background(
          path: 'assets/truck_cropped.mp4',
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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

                    const SizedBox(height: 15),

                    // Input field.
                    TextField(
                      controller: _textController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Input US gallons of fuel:",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Calculate button.
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            var input = double.tryParse(_textController.text);

                            if (input == null) {
                              calcOutput = 'Please give a valid input.';
                              return;
                            }

                            String ounces = ((input / 1500) * 128)
                                .toStringAsFixed(1);

                            calcOutput = 'Additive in: $ounces ounces.';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Calculate'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
