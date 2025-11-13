import 'package:flutter/material.dart';
import 'package:selective_ignore_pointer/selective_ignore_pointer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SelectiveIgnorePointerDemo());
  }
}

class SelectiveIgnorePointerDemo extends StatefulWidget {
  const SelectiveIgnorePointerDemo({super.key});

  @override
  State<SelectiveIgnorePointerDemo> createState() =>
      _SelectiveIgnorePointerDemoState();
}

class _SelectiveIgnorePointerDemoState
    extends State<SelectiveIgnorePointerDemo> {
  bool _ignoring = true;
  String _lastTapped = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selective Ignore Pointer Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last tapped: $_lastTapped',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text(
                    'Ignore Pointer (except blue and orange boxes)',
                  ),
                  value: _ignoring,
                  onChanged: (value) {
                    setState(() {
                      _ignoring = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SelectiveIgnorePointer(
              ignoring: _ignoring,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: _Box(
                              color: Colors.red,
                              label: 'Red Box\n(Ignored)',
                              onTap: () {
                                setState(() {
                                  _lastTapped = 'Red Box';
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: PointerPassthrough(
                              child: _Box(
                                color: Colors.blue,
                                label: 'Blue Box\n(Passthrough)',
                                onTap: () {
                                  setState(() {
                                    _lastTapped = 'Blue Box';
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: _Box(
                              color: Colors.green,
                              label: 'Green Box\n(Ignored)',
                              onTap: () {
                                setState(() {
                                  _lastTapped = 'Green Box';
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: PointerPassthrough(
                              child: _Box(
                                color: Colors.orange,
                                label: 'Orange Box\n(Passthrough)',
                                onTap: () {
                                  setState(() {
                                    _lastTapped = 'Orange Box';
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.onTap, required this.label, required this.color});
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
