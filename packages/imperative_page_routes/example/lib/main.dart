import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(routes: $appRoutes);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      routerConfig: router,
    );
  }
}
