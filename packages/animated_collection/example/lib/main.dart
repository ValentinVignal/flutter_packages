import 'dart:math';

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
      home: const DefaultTabController(length: 6, child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Animated visibility
  var _visible = true;

  // Animated location.
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

  // Animated appearing.
  final _random = Random();

  Color _generateColor() {
    return Color(0xff000000 + _random.nextInt(0xffffff));
  }

  final _colors = <Color>[];

  // Animated boolean.

  bool _boolean = false;

  // Animated expanded.

  // As long as https://github.com/flutter/flutter/issues/22512 in not fixed, we
  // need high number to make it smooth.
  int _flex = 100;

  // Animated color.
  late Color _color;

  @override
  void initState() {
    super.initState();
    _colors.addAll([_generateColor(), _generateColor()]);
    _color = _generateColor();
  }

  void _onPressed() {
    switch (DefaultTabController.of(context).index) {
      case 0:
        setState(() {
          _visible = !_visible;
        });
        break;
      case 1:
        final currentIndex = _alignments.indexOf(_alignment);
        final newIndex = (currentIndex + 1) % _alignments.length;
        setState(() {
          _alignment = _alignments[newIndex];
        });
        break;
      case 2:
        setState(() {
          _colors.addAll([_generateColor(), _generateColor()]);
        });
        break;
      case 3:
        setState(() {
          _boolean = !_boolean;
        });
        break;
      case 4:
        setState(() {
          // As long as https://github.com/flutter/flutter/issues/22512 in not
          // fixed, we need high number to make it smooth.
          _flex = _random.nextInt(500);
        });
        break;
      case 5:
        setState(() {
          _color = _generateColor();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('animated_collection'),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'AnimatedVisibility'),
            Tab(text: 'AnimatedLocation'),
            Tab(text: 'AnimatedAppearing'),
            Tab(text: 'AnimatedBoolean'),
            Tab(text: 'AnimatedExpanded'),
            Tab(text: 'AnimatedColor'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        child: const Icon(Icons.loop),
      ),
      body: TabBarView(
        children: [
          // AnimatedVisibility
          Center(
            child: Container(
              color: Colors.red,
              child: AnimatedVisibility(
                visible: _visible,
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(child: Text('Hide me')),
                  ),
                ),
              ),
            ),
          ),
          // AnimatedLocation
          AnimatedLocationScope(
            child: Align(
              alignment: _alignment,
              child: AnimatedLocation(
                tag: 'tag',
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: SizedBox.square(
                    dimension:
                        30 + 5 * _alignments.indexOf(_alignment).toDouble(),
                  ),
                ),
              ),
            ),
          ),
          // AnimatedAppearing
          ListView.builder(
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              return AnimatedAppearing(
                child: ListTile(tileColor: _colors[index]),
              );
            },
          ),
          // AnimatedBoolean
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(value: _boolean, onChanged: (_) => _onPressed()),
                AnimatedBoolean(
                  value: _boolean,
                  duration: const Duration(seconds: 5),
                  builder: (context, _, value) {
                    return Text('Value: ${value.toStringAsFixed(2)}');
                  },
                ),
              ],
            ),
          ),
          // AnimatedExpanded
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  // As long as https://github.com/flutter/flutter/issues/22512
                  // in not fixed, we need high number to make it smooth.
                  flex: 100,
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const Center(
                      child: Text('Expanded 100', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                AnimatedExpanded(
                  flex: _flex,
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Center(
                      child: Text(
                        'Expanded $_flex',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // AnimatedColor
          Center(
            child: Container(
              color: Colors.red,
              child: AnimatedColor(
                color: _color,
                builder: (_, _, color) {
                  return ColoredBox(
                    color: color ?? Colors.transparent,
                    child: const SizedBox(
                      height: 200,
                      width: 200,
                      child: Center(child: Text('Change my color')),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
