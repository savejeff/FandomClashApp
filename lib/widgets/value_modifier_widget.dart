import 'package:flutter/material.dart';

/*

class IntegerModifierWidget extends StatefulWidget {
  final int initialValue;
  final void Function(int) onValueChanged;
  final String label; // Added a label parameter

  const IntegerModifierWidget({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
    required this.label, // Require the label in constructor
  }) : super(key: key);

  @override
  _IntegerModifierWidgetState createState() => _IntegerModifierWidgetState();
}



class _IntegerModifierWidgetState extends State<IntegerModifierWidget> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  void _incrementValue() {
    setState(() {
      currentValue++;
    });
    widget.onValueChanged(currentValue);
  }

  void _decrementValue() {
    setState(() {
      currentValue--;
    });
    widget.onValueChanged(currentValue);
  }

  @override
  Widget build(BuildContext context) {
    // Use Theme to access primary container color and surface variant
    final theme = Theme.of(context);
    final containerColor = theme.colorScheme.primaryContainer;
    final backgroundColor = theme.colorScheme.surfaceVariant; // Surface variant for whole widget

    return Container(
      padding: EdgeInsets.all(16), // Padding for the entire widget
      decoration: BoxDecoration(
        color: backgroundColor, // Apply surface variant as background
        borderRadius: BorderRadius.circular(16), // Rounded corners for the whole widget
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label at the top
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10), // Space between label and increment button
          // Plus button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementValue,
          ),
          // Container with a square background and rounded corners for the value
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$currentValue',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          // Minus button
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _decrementValue,
          ),
        ],
      ),
    );
  }
}


 */

class IntegerModifierWidget extends StatelessWidget {
  final int value;
  final void Function(int) onValueChanged;
  final String label;

  const IntegerModifierWidget({
    Key? key,
    required this.value, // Pass the current value from parent
    required this.onValueChanged, // Callback to modify value
    required this.label,
  }) : super(key: key);

  void _incrementValue() {
    onValueChanged(value + 1); // Call the parent callback with new value
  }

  void _decrementValue() {
    onValueChanged(value - 1); // Call the parent callback with new value
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final containerColor = theme.colorScheme.primaryContainer;
    final backgroundColor = theme.colorScheme.surfaceContainerHighest;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _incrementValue, // Increment on button press
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$value', // Display the passed value
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _decrementValue, // Decrement on button press
          ),
        ],
      ),
    );
  }
}
