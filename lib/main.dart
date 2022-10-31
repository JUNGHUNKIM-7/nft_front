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
    initialLocation: PathVar.home.path,
    routes: <GoRoute>[
      GoRoute(
        path: PathVar.home.path,
        builder: (BuildContext context, GoRouterState state) => const Home(),
        routes: [
          GoRoute(
            path: PathVar.topDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(id: state.params['id']!),
          ),
          GoRoute(
            path: PathVar.trendingDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(id: state.params['id']!),
          ),
          GoRoute(
            path: PathVar.collectionDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(id: state.params['id']!),
          ),
          GoRoute(
            path: PathVar.collectionArtistDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(id: state.params['name']!),
          ),
          GoRoute(
            path: PathVar.bookmark.path,
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(id: state.params['id']!),
          ),
        ],
      ),
    ],
  );
}

enum PathVar {
  home(path: "/", caller: "/"),
  topDetails(
    path: "top/:id",
    caller: "/top",
  ),
  trendingDetails(
    path: "trending/:id",
    caller: "/trending",
  ),
  collectionDetails(
    path: "collection/:id",
    caller: "/collection",
  ),
  collectionArtistDetails(
    path: "collection/:artist",
    caller: "/collection",
  ),
  bookmark(
    path: "bookmark/:id",
    caller: "/bookmark",
  );

  final String path;
  final String caller;
  const PathVar({
    required this.path,
    required this.caller,
  });
}
