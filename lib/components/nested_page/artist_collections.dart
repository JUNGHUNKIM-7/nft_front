import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/style.dart';

import '../../components/nested_page/infinite_view.dart';
import '../../utils/enums.dart';
import '../global.dart';

class AritstCollections extends StatelessWidget with Widgets {
  const AritstCollections({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          MainAppBar(
            type: AppbarType.artistCollection,
            imagePath: "assets/images/collections.jpg",
            bottom: MainSliverAppBarBottom(
              type: AppbarType.artistCollection,
            ),
          ),
          SliverPadding(padding: EdgeInsets.symmetric(vertical: 8.0)),
          InfiniteScroll(type: InfiniteViewType.artistCollection)
        ],
      ),
    );
  }
}
