import 'package:flutter/material.dart';

import '../global.dart';
import '../global_component.dart';

class SinglePage extends StatelessWidget {
  const SinglePage({
    super.key,
    required this.id,
    required this.type,
  });
  final SinglePageType type;
  final String id;

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
                  ? "bookmark"
                  : type == SinglePageType.top
                      ? "top"
                      : type == SinglePageType.trending
                          ? "trending"
                          : "collecitons",
            ),
          ),
          const SliverFillRemaining()
        ],
      ),
    );
  }
}
