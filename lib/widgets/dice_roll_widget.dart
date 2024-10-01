// dice_roll_widget.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class DiceRollWidget extends StatefulWidget {
  final int finalValue; // The final value the dice should show (1-6)
  final bool rolling; // External parameter to control rolling

  const DiceRollWidget({
    Key? key,
    required this.finalValue,
    required this.rolling,
  }) : super(key: key);

  @override
  _DiceRollWidgetState createState() => _DiceRollWidgetState();
}

class _DiceRollWidgetState extends State<DiceRollWidget> {
  int currentValue = 1; // Current displayed value
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.rolling) {
      startRolling();
    } else {
      currentValue = widget.finalValue;
    }
  }

  @override
  void didUpdateWidget(covariant DiceRollWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rolling != widget.rolling) {
      if (widget.rolling) {
        // Rolling started
        startRolling();
      } else {
        // Rolling stopped
        stopRolling();
      }
    } else if (oldWidget.finalValue != widget.finalValue && !widget.rolling) {
      // Final value changed while not rolling
      setState(() {
        currentValue = widget.finalValue;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startRolling() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentValue = Random().nextInt(6) + 1;
      });
    });
  }

  void stopRolling() {
    _timer?.cancel();
    setState(() {
      currentValue = widget.finalValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          currentValue >= 0 ? currentValue.toString() : "-",
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
