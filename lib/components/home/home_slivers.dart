import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/extensions.dart';
import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../../utils/style.dart';
import '../global.dart';
import 'categories_tabs.dart';

//slivers(just ui)
class HomeBody extends ConsumerWidget with Widgets {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  static final categorieBodies = [
    const TopCategories(),
    const TrendingCategories(),
    const ColletionCategories()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final categories$ =
        ref.watch(catchIntProvider(CatchIntEvent.setCategoreis));

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:Home'),
      ),
      child: categories$.when(
        data: (int $index) => CustomScrollView(
          slivers: [
            HomeAppBar(height: height),
            HomeCoins(height: height),
            HomeCategories(height: height),
            const SliverPadding(padding: EdgeInsets.only(top: 4)),
            categorieBodies.elementAt($index),
            const SliverPadding(padding: EdgeInsets.only(bottom: 4)),
          ],
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class HomeCategories extends ConsumerWidget with Widgets {
  HomeCategories({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  final List<String> menus = ["top", "trending", "collections"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories$ =
        ref.watch(catchIntProvider(CatchIntEvent.setCategoreis));
    final groups = getInstances(ref);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * .06,
        child: Container(
          color: Colors.amber,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: kHorizontal8.copyWith(left: 16),
                child: categories$.when(
                  data: (int index$) => Row(
                    children: [
                      for (var i = 0; i < menus.length; i++)
                        GestureDetector(
                          onTap: () {
                            (groups.first as ControllerBase)
                                .setIntEvt
                                .setState = CatchIntEvent.setCategoreis;
                            (groups.last as Interactor).setCategories = i;
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: kHorizontal8.copyWith(left: 25),
                                child: Text(
                                  menus.elementAt(i).toTitleCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        letterSpacing: kLetterSpacing,
                                        fontWeight: FontWeight.bold,
                                        color: index$ == i
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                ),
                              ),
                              kWidth30,
                            ],
                          ),
                        )
                    ],
                  ),
                  error: (err, stk) => Text('$err: $stk'),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget with Widgets {
  const HomeAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      imagePath: "assets/images/1.jpg",
      type: AppbarType.home,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MainSliverAppBarBottom(type: AppbarType.home),
      ),
    );
  }
}

class HomeCoins extends ConsumerWidget with Widgets {
  const HomeCoins({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  static final coins = [
    [Icons.money, "bit"],
    [Icons.money, "eth"],
    [Icons.money, "pol"],
    [Icons.money, "sol"],
    [Icons.money, "arb"],
    [Icons.money, "arb"],
    [Icons.money, "arb"],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins$ = ref.watch(catchIntProvider(CatchIntEvent.setCoins));

    return SliverToBoxAdapter(
      child: coins$.when(
        data: (int index$) => Container(
          color: Colors.black,
          height: height * .1,
          child: Padding(
            padding: kHorizontal8,
            child: coins.length >= 6
                ? Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: coins.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: height * .2,
                        child: _widgets(context, index, index$, ref, kCoinsGap),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var index = 0; index < coins.length; index++)
                          _widgets(context, index, index$, ref, kCoinsGap),
                      ],
                    ),
                  ),
          ),
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }

  //Row<Col(Icon + Text) + SizedBox>
  Row _widgets(BuildContext context, int index, int index$, WidgetRef ref,
      SizedBox sizedBox) {
    final groups = getInstances(ref);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            (groups.first as ControllerBase).setIntEvt.setState =
                CatchIntEvent.setCoins;
            (groups.last as Interactor).setCoin = index;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                coins.elementAt(index).elementAt(0) as IconData,
                size: 45,
                color: index$ == index ? Colors.white : Colors.amber,
              ),
              Text(
                "${coins.elementAt(index).elementAt(1)}".toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: index$ == index ? Colors.white : Colors.amber,
                    ),
              ),
            ],
          ),
        ),
        sizedBox,
      ],
    );
  }
}
