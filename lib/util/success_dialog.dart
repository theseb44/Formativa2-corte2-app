import 'package:flutter/material.dart';

export 'success_dialog.dart';

void success(context, String texto) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Result'),
        content: Text(texto),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}