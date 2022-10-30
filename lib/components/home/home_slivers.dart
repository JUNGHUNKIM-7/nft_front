import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    const TopItems(),
    const TrendingItems(),
    const CollectionItems()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final categories$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setCategoreis));

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:Home'),
      ),
      child: categories$.when(
        data: (int $index) => CustomScrollView(
          slivers: [
            HomeAppBar(height: height),
            Coins(height: height),
            Categories(height: height),
            categorieBodies.elementAt($index),
          ],
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class Categories extends ConsumerWidget with Widgets {
  Categories({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  final List<String> menus = ["top", "trending", "collections"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setCategoreis));
    final groups = getInstances(ref);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * .06,
        child: Container(
          color: Colors.amber,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: kAll8,
              child: categories$.when(
                data: (int index$) => Row(
                  children: [
                    for (var i = 0; i < menus.length; i++)
                      GestureDetector(
                        onTap: () {
                          (groups.first as Repository).setIntEvt.setState =
                              CatchIntEvent.setCategoreis;
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
    return SliverAppBar(
      expandedHeight: height * .45,
      centerTitle: true,
      pinned: true,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MainSliverAppBarBottom(),
      ),
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .45,
        maxExtent: height * .45,
        child: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/1.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: const FlutterLogo(),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class Coins extends ConsumerWidget with Widgets {
  const Coins({
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
    final coins$ = ref.watch(catchIntFamilyProvider(CatchIntEvent.setCoins));

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
            (groups.first as Repository).setIntEvt.setState =
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
