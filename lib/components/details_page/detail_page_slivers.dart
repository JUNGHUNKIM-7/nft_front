import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/providers.dart';
import '../../utils/style.dart';
import '../global.dart';
import '../global_component.dart';

class DetailsPageHome extends ConsumerWidget with Widgets {
  const DetailsPageHome({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ItemAppBar(height: height, id: id),
          RealatedItemsBar(
            height: height,
            defaultLetterspacing: kLetterSpacing,
          ),
          const InfiniteScroll()
        ],
      ),
    );
  }
}

class RealatedItemsBar extends StatelessWidget {
  const RealatedItemsBar({
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

class ItemAppBar extends ConsumerWidget {
  const ItemAppBar({
    Key? key,
    required this.height,
    required this.id,
  }) : super(key: key);

  final double height;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));

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
        b$.when(
          data: (Set<int> bookMark$) => ToggleBookMark(
            b$: bookMark$,
            groups: groups,
            index: int.parse(id),
          ),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ShopNowBtn(),
          ),
        ),
      ),
    );
  }
}

class InfiniteScroll extends ConsumerWidget with Widgets {
  const InfiniteScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));

    return SliverFixedExtentList(
      itemExtent: 100.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomCard(
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
                  "0.25 ETH",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(padding: kAll8.copyWith(left: 5)),
              ],
            ),
          );
        },
      ),
    );
  }
}
