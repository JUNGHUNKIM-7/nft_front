import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/layout.dart';
import 'utils/style.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: Styles.getInstance(true).themeDark,
      theme: Styles.getInstance(false).themeLight,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: PathVar.home.path,
        builder: (BuildContext context, GoRouterState state) => const Home(),
        routes: [
          GoRoute(
            path: PathVar.gridItem.path,
            builder: (BuildContext context, GoRouterState state) {
              return DetailsPage(id: state.params['id']!);
            },
          ),
        ],
      ),
    ],
  );
}

enum PathVar {
  home(path: "/", caller: "/"),
  gridItem(
      path: "tokens/:id",
      caller: "/tokens"); // Must add prefix: "/dynamicValue"

  final String path;
  final String caller;
  const PathVar({
    required this.path,
    required this.caller,
  });
}
