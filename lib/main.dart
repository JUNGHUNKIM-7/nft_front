import 'package:flutter/material.dart';
import 'package:flutter_layout/components/details_page/artist_collections.dart';
import 'package:flutter_layout/components/details_page/infinite_view.dart';
import 'package:flutter_layout/components/details_page/single_details.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/global.dart';
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
    routes: [
      GoRoute(
        path: PathVar.home.path,
        builder: (BuildContext context, GoRouterState state) => const Home(),
        routes: [
          GoRoute(
            path: PathVar.topDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                InfiniteView(
              id: state.params['id']!,
              type: InfinitePageType.top,
            ),
            routes: [
              GoRoute(
                path: PathVar.topSingle.path,
                builder: (BuildContext context, GoRouterState state) =>
                    SinglePage(
                  id: state.params['id']!,
                  type: SinglePageType.top,
                ),
              ),
            ],
          ),
          GoRoute(
            path: PathVar.trendingDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                InfiniteView(
                    id: state.params['id']!, type: InfinitePageType.trending),
            routes: [
              GoRoute(
                path: PathVar.trendingSingle.path,
                builder: (BuildContext context, GoRouterState state) =>
                    SinglePage(
                  id: state.params['id']!,
                  type: SinglePageType.trending,
                ),
              ),
            ],
          ),
          GoRoute(
            path: PathVar.collectionSingle.path,
            builder: (BuildContext context, GoRouterState state) => SinglePage(
              id: state.params['id']!,
              type: SinglePageType.collection,
            ),
          ),
          GoRoute(
            path: PathVar.collectionArtistDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                AritstCollections(name: state.params['name']!),
          ),
          GoRoute(
            path: PathVar.bookmark.path,
            builder: (BuildContext context, GoRouterState state) => SinglePage(
              id: state.params['id']!,
              type: SinglePageType.bookmark,
            ),
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
  topSingle(
    path: "single",
    caller: "/top",
  ),
  trendingDetails(
    path: "trending/:id",
    caller: "/trending",
  ),
  trendingSingle(
    path: "single",
    caller: "/trending",
  ),
  collectionSingle(
    path: "collections/:id",
    caller: "/collections",
  ),
  collectionArtistDetails(
    path: "collections/artist/:name",
    caller: "/collections/artist",
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
