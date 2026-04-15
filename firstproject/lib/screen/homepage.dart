import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  double result = 0.0;
  String title = "Moghlester";
  int counter = 0;

  @override
  void initState() {
    super.initState();
    number1.text = "0";
    number2.text = "0";
  }

  double _parse(String s) => double.tryParse(s) ?? 0.0;

  void addNumbers() {
    setState(() {
      result = _parse(number1.text) + _parse(number2.text);
    });
  }

  void subtractNumbers() {
    setState(() {
      result = _parse(number1.text) - _parse(number2.text);
    });
  }

  void multiplyNumbers() {
    setState(() {
      result = _parse(number1.text) * _parse(number2.text);
    });
  }

  void _incrementCounter() {
    setState(() {
      counter += 1;
    });
  }

  @override
  void dispose() {
    number1.dispose();
    number2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Counter: $counter', style: const TextStyle(fontSize: 26)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Press to be a Victim'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextField(
              controller: number1,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Number 1'),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: number2,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Number 2'),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: addNumbers, child: const Text('Add')),
                ElevatedButton(
                  onPressed: subtractNumbers,
                  child: const Text('Subtract'),
                ),
                ElevatedButton(
                  onPressed: multiplyNumbers,
                  child: const Text('Multiply'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Result: $result',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
