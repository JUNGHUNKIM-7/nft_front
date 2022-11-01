import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../../utils/providers.dart';
import '../../utils/style.dart';
import '../global.dart';
import '../global_component.dart';

class InfiniteView extends ConsumerWidget with Widgets {
  const InfiniteView({
    super.key,
    required this.id,
    required this.type,
  });
  final String id;
  final InfinitePageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SingleViewAppBar(
            height: height,
            id: id,
            type: type == InfinitePageType.top
                ? SinglePageType.top
                : SinglePageType.trending,
          ),
          SliverToBoxAdapter(
            child: Text(type == InfinitePageType.top ? "top" : "trending"),
          ),
          InfiniteViewBar(
            height: height,
            defaultLetterspacing: kLetterSpacing,
          ),
          InfiniteScroll(
            type: type,
          )
        ],
      ),
    );
  }
}

class InfiniteViewBar extends StatelessWidget {
  const InfiniteViewBar({
    Key? key,
    required this.height,
    required this.defaultLetterspacing,
  }) : super(key: key);

  final double height;
  final double defaultLetterspacing;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: height * .08,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Realated Item'.toUpperCase(),
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    letterSpacing: defaultLetterspacing,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteScroll extends ConsumerWidget with Widgets {
  const InfiniteScroll({
    Key? key,
    required this.type,
  }) : super(key: key);

  final InfinitePageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));

    return SliverFixedExtentList(
      itemExtent: 100.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              type == InfinitePageType.top
                  ? context.go("${PathVar.topSingle.caller}/$index/single")
                  : type == InfinitePageType.trending
                      ? context
                          .go("${PathVar.trendingSingle.caller}/$index/single")
                      : null; //artist
            },
            child: SliverTiles(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/3.jpg",
                    fit: BoxFit.contain,
                  ),
                  b$.when(
                    data: (Set<int> bookMark$) => ToggleBookMark(
                        b$: bookMark$, groups: groups, index: index),
                    error: (err, stk) => const Text(''),
                    loading: () => const CircularProgressIndicator(),
                  ),
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
