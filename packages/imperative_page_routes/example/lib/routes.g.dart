// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'dialog',
          factory: $DialogRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'bottom-sheet',
          factory: $BottomSheetRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'drawer',
          factory: $DrawerRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DialogRouteExtension on DialogRoute {
  static DialogRoute _fromState(GoRouterState state) => const DialogRoute();

  String get location => GoRouteData.$location(
        '/dialog',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BottomSheetRouteExtension on BottomSheetRoute {
  static BottomSheetRoute _fromState(GoRouterState state) =>
      const BottomSheetRoute();

  String get location => GoRouteData.$location(
        '/bottom-sheet',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DrawerRouteExtension on DrawerRoute {
  static DrawerRoute _fromState(GoRouterState state) => const DrawerRoute();

  String get location => GoRouteData.$location(
        '/drawer',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
