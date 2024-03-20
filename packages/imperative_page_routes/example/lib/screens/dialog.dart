import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Text('Dialog'),
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Dialog content'),
        ),
      ],
    );
  }
}
