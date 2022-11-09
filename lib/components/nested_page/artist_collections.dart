import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/style.dart';

import '../../components/nested_page/infinite_view.dart';
import '../../utils/enums.dart';
import '../global.dart';

class ArtistCollections extends StatelessWidget with Widgets {
  const ArtistCollections({
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
          SliverPadding(padding: kVertical8),
          const InfiniteScroll(type: InfiniteViewType.artistCollection)
        ],
      ),
    );
  }
}
