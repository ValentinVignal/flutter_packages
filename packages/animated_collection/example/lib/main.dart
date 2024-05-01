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

  @override
  void initState() {
    super.initState();
    _colors.addAll([_generateColor(), _generateColor()]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('animated_collection'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'AnimatedVisibility'),
              Tab(text: 'AnimatedLocation'),
              Tab(text: 'AnimatedAppearing'),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
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
                }
              },
              child: const Icon(Icons.loop),
            );
          },
        ),
        body: TabBarView(
          children: [
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
                      child: Center(
                        child: Text('Hide me'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
            ListView.builder(
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                return AnimatedAppearing(
                  child: ListTile(
                    tileColor: _colors[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
