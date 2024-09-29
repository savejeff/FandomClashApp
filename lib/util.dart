// util.dart
import 'dart:math';
import 'package:sprintf/sprintf.dart';


//******************************************************************************************

int _millis0 = millis_epoch();

int millis() {
  return millis_epoch() - _millis0;
}


int millis_epoch() {
  return DateTime.now().millisecondsSinceEpoch;
}


//******************************************************************************************

String getClassName_byInstance(Object instance) {
  return instance.runtimeType.toString();
}

String getClassName<T>() {
  return T.toString();
}



String format(String format, [List<Object>? args]) {
  String msg = format;
  try {
    msg = args != null
        ? sprintf(format, args)
        : format;
  } catch (e) {
    // Handle error in format (if any)
  }

  return msg;
}


//******************************************************************************************

class ExecuterEvery {
  int executeDt; // [ms] period of execution
  int lastTimeExecute = 0;

  ExecuterEvery(this.executeDt);

  bool itsTime() {
    if (_millisSince(lastTimeExecute) > executeDt) {
      lastTimeExecute = millis();
      return true;
    }
    return false;
  }

  int _millisSince(int lastTime) {
    return millis() - lastTime;
  }
}

//******************************************************************************************


// LIMIT function using generic num type
T LIMIT<T extends num>(T LOWER, T X, T UPPER) {
	return min(max(X, LOWER), UPPER) as T;
}

// MAP function using generic num type
T MAP<T extends num>(T value, T FROM_MIN, T FROM_MAX, T TO_LOW, T TO_HIGH) {
	final limitedValue = LIMIT(FROM_MIN, value, FROM_MAX);
	return ((limitedValue - FROM_MIN) * (TO_HIGH - TO_LOW) / (FROM_MAX - FROM_MIN) + TO_LOW) as T;
}

// MAP_UNLIMITED function using generic num type
T MAP_UNLIMITED<T extends num>(T value, T FROM_MIN, T FROM_MAX, T TO_LOW, T TO_HIGH) {
	return ((value - FROM_MIN) * (TO_HIGH - TO_LOW) / (FROM_MAX - FROM_MIN) + TO_LOW) as T;
}

