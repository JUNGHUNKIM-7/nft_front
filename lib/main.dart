import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/enums.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/bottom_navigator.dart';
import 'components/nested_page/artist_collections.dart';
import 'components/nested_page/infinite_view.dart';
import 'components/nested_page/single_details.dart';
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
        builder: (BuildContext context, GoRouterState state) =>
            const RoutingPage(),
        routes: [
          GoRoute(
            path: PathVar.topDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                InfiniteView(
              id: state.params['id']!,
              type: InfiniteViewType.top,
            ),
            routes: [
              GoRoute(
                path: PathVar.topSingle.path,
                builder: (BuildContext context, GoRouterState state) =>
                    SinglePage(
                  id: state.params['id']!,
                  type: SinglePageType.topSingle,
                ),
              ),
            ],
          ),
          GoRoute(
            path: PathVar.trendingDetails.path,
            builder: (BuildContext context, GoRouterState state) =>
                InfiniteView(
              id: state.params['id']!,
              type: InfiniteViewType.trending,
            ),
            routes: [
              GoRoute(
                path: PathVar.trendingSingle.path,
                builder: (BuildContext context, GoRouterState state) =>
                    SinglePage(
                  id: state.params['id']!,
                  type: SinglePageType.trendingSingle,
                ),
              ),
            ],
          ),
          GoRoute(
              path: PathVar.collectionArtist.path,
              builder: (BuildContext context, GoRouterState state) =>
                  AritstCollections(
                    name: state.params['name']!,
                  ),
              routes: [
                GoRoute(
                  path: PathVar.collectionArtistDetails.path,
                  builder: (BuildContext context, GoRouterState state) {
                    final id = state.params['id'];
                    final name = state.params['name'];
                    return SinglePage(
                      id: id!,
                      name: name,
                      type: SinglePageType.collection,
                    );
                  },
                ),
              ]),
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
  collectionArtist(
    path: "collections/artist/:name",
    caller: "/collections/artist",
  ),
  collectionArtistDetails(
    path: ":id",
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
