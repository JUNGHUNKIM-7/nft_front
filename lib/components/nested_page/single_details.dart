import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/enums.dart';
import '../stream_component/stream_components.dart';

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
          _SingleViewAppBar(
            height: MediaQuery.of(context).size.height,
            id: id,
            type: type,
          ),
          //for debug
          SliverToBoxAdapter(
            child: Text(
              type == SinglePageType.bookmark
                  ? "bookMark single: $id"
                  : type == SinglePageType.topSingle
                      ? "top single: $id"
                      : type == SinglePageType.trendingSingle
                          ? "trending single: $id"
                          : name != null
                              ? "collection: $id / artistName: $name"
                              : "",
            ),
          ),
          const SliverFillRemaining()
        ],
      ),
    );
  }
}

class _SingleViewAppBar extends ConsumerWidget {
  const _SingleViewAppBar({
    Key? key,
    required this.height,
    required this.id,
    required this.type,
  }) : super(key: key);

  final double height;
  final String id;
  final SinglePageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: height * .4,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .3,
        minExtent: 0,
        maxExtent: height * .6,
        child: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/2.jpg",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      actions: [
        if (type == SinglePageType.trendingSingle ||
            type == SinglePageType.topSingle ||
            type == SinglePageType.collection)
          ToggleBookMark(
            index: int.parse(id),
          )
      ],
    );
  }
}
