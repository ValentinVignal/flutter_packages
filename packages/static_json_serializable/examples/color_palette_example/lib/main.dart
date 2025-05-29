import 'package:flutter/material.dart';
import 'package:static_json_serializable_annotation/static_json_serializable_annotation.dart';

part 'main.g.dart';

@StaticJsonSerializable()
abstract class Palette {
  static const primary = Color(0xFF3366CC);
  static const secondary = Color(0xFFFFA000);
  static const error = Color(0xFFD32F2F);

  static const light = Color(0xFFF4F7FA);
  static const dark = Color(0xFF222B45);
  static const white = Colors.white;
  static const black = Colors.black;
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Palette.primary,
  onPrimary: Palette.white,
  secondary: Palette.secondary,
  onSecondary: Palette.black,
  surface: Palette.light,
  onSurface: Palette.black,
  error: Palette.error,
  onError: Palette.white,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Palette.primary,
  onPrimary: Palette.black,
  secondary: Palette.secondary,
  onSecondary: Palette.black,
  surface: Palette.dark,
  onSurface: Palette.white,
  error: Palette.error,
  onError: Palette.black,
);

final lightTheme = ThemeData(colorScheme: lightColorScheme);
final darkTheme = ThemeData(colorScheme: darkColorScheme);

/// Returns a contrasting color for the given [color].
Color getContrastColor(Color color) {
  final brightness = ThemeData.estimateBrightnessForColor(color);
  return brightness == Brightness.light ? Palette.dark : Palette.light;
}

void main() {
  runApp(const StaticJsonSerializableExample());
}

class StaticJsonSerializableExample extends StatelessWidget {
  const StaticJsonSerializableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Static JSON Serializable Example'),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        children: $paletteStaticJson.entries.map((entry) {
          return Card(
            color: entry.value,
            child: Center(
              child: Text(
                entry.key,
                style: TextStyle(color: getContrastColor(entry.value)),
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
