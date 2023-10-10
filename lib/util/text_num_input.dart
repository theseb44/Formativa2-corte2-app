import 'package:flutter/material.dart';

export 'text_num_input.dart';

Widget inputAbstracto(
    {TextEditingController? controller, String? labelText, bool op = true}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    keyboardType: op ? TextInputType.text : TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor, ingresa $labelText';
      }
      if (double.tryParse(value) == null && op == false) {
        return 'Por favor, ingresa un número válido';
      }
      return null;
    },
  );
}