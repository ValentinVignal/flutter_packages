import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imperative_page_routes/imperative_page_routes.dart';
import 'package:imperative_page_routes_example/screens/drawer.dart';

import 'screens/bottom_sheet.dart';
import 'screens/dialog.dart';
import 'screens/home.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DialogRoute>(path: 'dialog'),
    TypedGoRoute<BottomSheetRoute>(path: 'bottom-sheet'),
    TypedGoRoute<DrawerRoute>(path: 'drawer'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class DialogRoute extends GoRouteData {
  const DialogRoute();
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DialogPage(
      key: state.pageKey,
      child: const DialogScreen(),
    );
  }
}

class BottomSheetRoute extends GoRouteData {
  const BottomSheetRoute();
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      key: state.pageKey,
      child: const BottomSheetScreen(),
    );
  }
}

class DrawerRoute extends GoRouteData {
  const DrawerRoute();
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return DrawerPage(
      key: state.pageKey,
      child: const DrawerScreen(),
    );
  }
}
