import 'package:flutter/material.dart';

var overlayColor = MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.blue.withOpacity(0.54);
    }
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey.shade400;
    }
    return null;
  },
);

var trackColor = MaterialStateProperty.resolveWith<Color?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.blue;
    }
    return null;
  },
);
