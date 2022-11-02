import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/style.dart';

import '../../components/details_page/infinite_view.dart';
import '../../components/global.dart';

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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: MainSliverAppBarBottom(
                type: AppbarType.artistCollection,
              ),
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
