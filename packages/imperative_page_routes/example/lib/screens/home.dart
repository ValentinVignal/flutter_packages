import 'package:flutter/material.dart' hide DialogRoute;
import 'package:imperative_page_routes_example/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton(
              onPressed: () {
                const DialogRoute().go(context);
              },
              child: const Text('Dialog'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton(
              onPressed: () {
                const BottomSheetRoute().go(context);
              },
              child: const Text('Bottom sheet'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton(
              onPressed: () {
                const DrawerRoute().go(context);
              },
              child: const Text('Drawer'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
