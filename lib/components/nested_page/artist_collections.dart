import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/style.dart';

import '../../components/nested_page/infinite_view.dart';
import '../global.dart';

class AritstCollections extends StatelessWidget with Widgets {
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
          const MainAppBar(
            type: AppbarType.artistCollection,
            imagePath: "assets/images/collections.jpg",
            bottom: MainSliverAppBarBottom(
              type: AppbarType.artistCollection,
            ),
          ),
          SliverToBoxAdapter(
            child: Text("artistName: $name"),
          ),
          const InfiniteScroll(type: InfinitePageType.artistCollection)
        ],
      ),
    );
  }
}
