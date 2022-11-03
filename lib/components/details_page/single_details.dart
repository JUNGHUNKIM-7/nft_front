import 'package:flutter/material.dart';

import '../global.dart';
import '../global_component.dart';

class SinglePage extends StatelessWidget {
  const SinglePage({
    super.key,
    required this.id,
    required this.type,
    this.name,
  });
  final SinglePageType type;
  final String id;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SingleViewAppBar(
            height: MediaQuery.of(context).size.height,
            id: id,
            type: type,
          ),
          //for debug
          SliverToBoxAdapter(
            child: Text(
              type == SinglePageType.bookmark
                  ? "bookMark: $id"
                  : type == SinglePageType.top
                      ? "top: $id"
                      : type == SinglePageType.trending
                          ? "trending: $id"
                          : type == SinglePageType.trendingSingle
                              ? "trending single: $id"
                              : name != null
                                  ? "collection: $id / artistName: $name"
                                  : "collection: $id",
            ),
          ),
          const SliverFillRemaining()
        ],
      ),
    );
  }
}
