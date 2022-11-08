import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../../utils/enums.dart';
import '../../utils/style.dart';
import '../global.dart';
import '../global_component.dart';
import '../stream_component/stream_components.dart';

class InfiniteView extends ConsumerWidget with Widgets {
  const InfiniteView({
    super.key,
    required this.id,
    required this.type,
  });
  final String id;
  final InfiniteViewType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MainAppBar(
            bottom: MainSliverAppBarBottom(
              type: type == InfiniteViewType.top
                  ? AppbarType.top
                  : AppbarType.trending,
            ),
            imagePath: type == InfiniteViewType.top
                ? 'assets/images/top.jpg'
                : 'assets/images/trending.jpg',
            type: type == InfiniteViewType.top
                ? AppbarType.top
                : AppbarType.trending,
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          _InfiniteViewBar(
            height: height,
            defaultLetterspacing: kLetterSpacing,
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          InfiniteScroll(
            type: type,
          )
        ],
      ),
    );
  }
}

class _InfiniteViewBar extends StatelessWidget {
  const _InfiniteViewBar({
    Key? key,
    required this.height,
    required this.defaultLetterspacing,
  }) : super(key: key);

  final double height;
  final double defaultLetterspacing;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ShaderBox(
        child: Container(
          height: height * .08,
          color: Colors.white30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'more items'.toUpperCase(),
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      letterSpacing: defaultLetterspacing,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfiniteScroll extends StatelessWidget with Widgets {
  const InfiniteScroll({
    Key? key,
    required this.type,
  }) : super(key: key);

  final InfiniteViewType type;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 100.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              switch (type) {
                case InfiniteViewType.top:
                  context.go("${PathVar.topSingle.caller}/$index/single");
                  break;
                case InfiniteViewType.trending:
                  context.go("${PathVar.trendingSingle.caller}/$index/single");
                  break;
                case InfiniteViewType.artistCollection:
                  context.go(
                      "${PathVar.collectionArtistDetails.caller}/artistName/$index");
                  break;
              }
            },
            child: CustomCard(
              child: Row(
                children: [
                  RoundedImage(
                    child: Image.asset(
                      "assets/images/3.jpg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  ToggleBookMark(index: index),
                  const SizedBox(
                    width: 4,
                  ),
                  const ItemNameWithTag(),
                  const Spacer(),
                  Text(
                    "0.30 ETH",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Padding(padding: kAll8.copyWith(left: 5)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
