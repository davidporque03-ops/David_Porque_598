import 'package:flutter/material.dart';
import 'dart:math';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // ============================================================
  // STATE VARIABLES (Do not modify these declarations)
  // ============================================================
  String _display = '0';
  String _firstOperand = '';
  String _operator = '';
  bool _shouldResetDisplay = false;
  String _expression = '';

  // ============================================================
  // TASK 1: Complete initState() [15 POINTS]
  //
  // Initialize all state variables to their default values.
  //
  // Instructions:
  // - Call super.initState() first
  // - Set _display to '0'
  // - Set _firstOperand to ''
  // - Set _operator to ''
  // - Set _shouldResetDisplay to false
  // - Set _expression to ''
  // ============================================================
  @override
  void initState() {
    super.initState();
    _display = '0';
    _firstOperand = '';
    _operator = '';
    _shouldResetDisplay = false;
    _expression = '';
  }

  // ============================================================
  // TASK 2: Complete _onNumberPressed() [20 POINTS]
  //
  // Handle when number buttons (0-9) are pressed.
  //
  // Instructions:
  // - Use setState(() { ... })
  // - If _display is '0' OR _shouldResetDisplay is true:
  //     -> Set _display to the number
  //     -> Set _shouldResetDisplay to false
  // - Otherwise:
  //     -> Append number to _display
  // ============================================================
  void _onNumberPressed(String number) {
    setState(() {
      if (_display == '0' || _shouldResetDisplay) {
        _display = number;
        _shouldResetDisplay = false;
      } else {
        _display = _display + number;
      }
    });
  }

  // ============================================================
  // TASK 3: Complete _onDecimalPressed() [15 POINTS]
  //
  // Handle when the decimal point (.) button is pressed.
  //
  // Instructions:
  // - Use setState(() { ... })
  // - If _shouldResetDisplay is true:
  //     -> Set _display to '0.'
  //     -> Set _shouldResetDisplay to false
  // - Else if _display does NOT contain '.':
  //     -> Append '.' to _display
  // ============================================================
  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display = _display + '.';
      }
    });
  }

  // ============================================================
  // TASK 4: Complete _onOperatorPressed() [25 POINTS]
  //
  // Handle when operator buttons (+, -, ×, ÷) are pressed.
  //
  // Instructions:
  // - Use setState(() { ... })
  // - Set _firstOperand to _display
  // - Set _operator to the operator parameter
  // - Set _expression to show "$_display $operator"
  // - Set _shouldResetDisplay to true
  // ============================================================
  void _onOperatorPressed(String operator) {
    setState(() {
      _firstOperand = _display;
      _operator = operator;
      _expression = '$_display $operator';
      _shouldResetDisplay = true;
    });
  }

  // ============================================================
  // TASK 5: Complete _calculateTriangle() [25 POINTS]
  //
  // Calculate Area and Perimeter of an Equilateral Triangle.
  // Use the current _display value as the side length.
  //
  // Formulas:
  //   Area = (sqrt(3) / 4) * side * side
  //   Perimeter = 3 * side
  //
  // Instructions:
  // - Use setState(() { ... })
  // - Get side: double side = double.tryParse(_display) ?? 0;
  // - Calculate area and perimeter using the formulas above
  // - Set _expression to show all results:
  //     'Triangle (side=$side)\nArea: ${area.toStringAsFixed(2)} | Perimeter: ${perimeter.toStringAsFixed(2)}'
  // - Set _display to show the area (use .toStringAsFixed(2))
  // - Set _shouldResetDisplay to true
  // ============================================================
  void _calculateTriangle() {
    setState(() {
      double side = double.tryParse(_display) ?? 0;
      double area = (sqrt(3) / 4) * side * side;
      double perimeter = 3 * side;

      _expression =
          'Triangle (side=$side)\nArea: ${area.toStringAsFixed(2)} | Perimeter: ${perimeter.toStringAsFixed(2)}';
      _display = area.toStringAsFixed(2);
      _shouldResetDisplay = true;
    });
  }

  // ============================================================
  // PROVIDED FUNCTIONS (Do not modify below this line)
  // ============================================================

  void _calculate() {
    if (_firstOperand.isEmpty || _operator.isEmpty) return;

    double num1 = double.tryParse(_firstOperand) ?? 0;
    double num2 = double.tryParse(_display) ?? 0;
    double result = 0;

    setState(() {
      switch (_operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            _display = 'Error';
            _expression = 'Cannot divide by zero';
            _firstOperand = '';
            _operator = '';
            _shouldResetDisplay = true;
            return;
          }
          result = num1 / num2;
          break;
      }

      _expression =
          '$_firstOperand $_operator $num2 = ${_formatResult(result)}';
      _display = _formatResult(result);
      _firstOperand = '';
      _operator = '';
      _shouldResetDisplay = true;
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = '';
      _operator = '';
      _shouldResetDisplay = false;
      _expression = '';
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  String _formatResult(double result) {
    if (result.isNaN || result.isInfinite) {
      return 'Error';
    }
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result
        .toStringAsFixed(4)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  Widget _buildButton(
    String text, {
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: backgroundColor ?? const Color(0xFF333333),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onPressed,
            child: Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: text.length > 3 ? 16 : 28,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // UI BUILD METHOD (Do not modify)
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expression Display
                    Text(
                      _expression,
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Main Display
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _display,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Operator Indicator
                    if (_operator.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Operator: $_operator',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Divider
            Container(
              height: 1,
              color: Colors.grey[800],
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),

            const SizedBox(height: 10),

            // Calculator Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // Row 1: C, Backspace, Triangle, Divide
                  Row(
                    children: [
                      _buildButton(
                        'C',
                        backgroundColor: const Color(0xFFFF6B6B),
                        onPressed: _clear,
                      ),
                      _buildButton(
                        '⌫',
                        backgroundColor: const Color(0xFF505050),
                        onPressed: _backspace,
                      ),
                      _buildButton(
                        'Triangle',
                        backgroundColor: const Color(0xFF9C27B0),
                        onPressed: _calculateTriangle,
                      ),
                      _buildButton(
                        '÷',
                        backgroundColor: const Color(0xFF2196F3),
                        onPressed: () => _onOperatorPressed('÷'),
                      ),
                    ],
                  ),

                  // Row 2: 7, 8, 9, Multiply
                  Row(
                    children: [
                      _buildButton('7', onPressed: () => _onNumberPressed('7')),
                      _buildButton('8', onPressed: () => _onNumberPressed('8')),
                      _buildButton('9', onPressed: () => _onNumberPressed('9')),
                      _buildButton(
                        '×',
                        backgroundColor: const Color(0xFF2196F3),
                        onPressed: () => _onOperatorPressed('×'),
                      ),
                    ],
                  ),

                  // Row 3: 4, 5, 6, Subtract
                  Row(
                    children: [
                      _buildButton('4', onPressed: () => _onNumberPressed('4')),
                      _buildButton('5', onPressed: () => _onNumberPressed('5')),
                      _buildButton('6', onPressed: () => _onNumberPressed('6')),
                      _buildButton(
                        '-',
                        backgroundColor: const Color(0xFF2196F3),
                        onPressed: () => _onOperatorPressed('-'),
                      ),
                    ],
                  ),

                  // Row 4: 1, 2, 3, Add
                  Row(
                    children: [
                      _buildButton('1', onPressed: () => _onNumberPressed('1')),
                      _buildButton('2', onPressed: () => _onNumberPressed('2')),
                      _buildButton('3', onPressed: () => _onNumberPressed('3')),
                      _buildButton(
                        '+',
                        backgroundColor: const Color(0xFF2196F3),
                        onPressed: () => _onOperatorPressed('+'),
                      ),
                    ],
                  ),

                  // Row 5: 00, 0, Decimal, Equals
                  Row(
                    children: [
                      _buildButton(
                        '00',
                        onPressed: () {
                          _onNumberPressed('0');
                          _onNumberPressed('0');
                        },
                      ),
                      _buildButton('0', onPressed: () => _onNumberPressed('0')),
                      _buildButton('.', onPressed: _onDecimalPressed),
                      _buildButton(
                        '=',
                        backgroundColor: const Color(0xFFFF9800),
                        onPressed: _calculate,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
