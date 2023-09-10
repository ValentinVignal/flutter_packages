import 'package:animated_collection/animated_collection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  var _alignment = Alignment.center;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentIndex = _alignments.indexOf(_alignment);
          final newIndex = (currentIndex + 1) % _alignments.length;
          setState(() {
            _alignment = _alignments[newIndex];
          });
        },
        child: const Icon(Icons.loop),
      ),
      body: AnimatedLocationScope(
        child: Align(
          alignment: _alignment,
          child: AnimatedLocation(
            tag: 'tag',
            child: ColoredBox(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: SizedBox.square(
                dimension: 30 + 5 * _alignments.indexOf(_alignment).toDouble(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
