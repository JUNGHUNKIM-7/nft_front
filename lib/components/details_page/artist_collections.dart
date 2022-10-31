import 'package:flutter/material.dart';
import 'package:flutter_layout/components/details_page/infinite_view.dart';
import 'package:flutter_layout/components/global.dart';

class AritstCollections extends StatelessWidget {
  const AritstCollections({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Text(name),
          ),
          const InfiniteScroll(type: InfinitePageType.artistCollection)
        ],
      ),
    );
  }
}
