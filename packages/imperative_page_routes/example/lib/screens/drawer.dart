import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CloseButton(),
          ),
          Expanded(
            child: Center(
              child: Text('Drawer'),
            ),
          ),
        ],
      ),
    );
  }
}
