import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global_component.dart';
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
          //debug
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
          const _SingleViewBody()
        ],
      ),
    );
  }
}

class _SingleViewBody extends StatelessWidget {
  const _SingleViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        color: Colors.black54,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
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
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      pinned: true,
      expandedHeight: height * .45,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .45,
        maxExtent: height * .45,
        child: const ShaderBox(
          child: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: DarkenImage(
                image: AssetImage(
                  "assets/images/2.jpg",
                ),
              ),
            ),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
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
