import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/stream_component/stream_components.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../../utils/enums.dart';
import '../../utils/extensions.dart';
import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../../utils/style.dart';
import '../global.dart';
import '../global_component.dart';

//slivers(just ui)
class Home extends ConsumerWidget with Widgets {
  const Home({
    Key? key,
  }) : super(key: key);

  static final categoryBodies = [
    const _TopCategories(),
    const _TrendingCategories(),
    const _ColletionCategories()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final categories$ =
        ref.watch(catchIntProvider(CatchIntEvent.setCategoreis));

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 1),
          () => log('hi', name: 'Refresh:Home'),
        );
      },
      child: categories$.when(
        data: (int $index) => CustomScrollView(
          slivers: [
            _HomeAppBar(height: height),
            SliverPadding(
              padding: kVertical8,
            ),
            _HomeCoins(height: height),
            SliverPadding(
              padding: kVertical8,
            ),
            _HomeCategories(height: height),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            categoryBodies.elementAt($index),
          ],
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class _HomeCategories extends ConsumerWidget with Widgets {
  _HomeCategories({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  static const menus = ["top", "trending", "collections"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories$ =
        ref.watch(catchIntProvider(CatchIntEvent.setCategoreis));
    final groups = getInstances(ref);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * .06,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: categories$.when(
                data: (int index$) => Row(
                  children: [
                    for (var i = 0; i < menus.length; i++)
                      GestureDetector(
                        onTap: () {
                          _setCategories(groups, i);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: kHorizontal8.copyWith(left: 25),
                              child: Text(
                                menus.elementAt(i).toTitleCase(),
                                style: _getTextTheme(context,
                                    index$: index$, index: i),
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
    );
  }

  void _setCategories(List<dynamic> groups, int i) {
    (groups.first as ControllerBase).setIntEvt.setState =
        CatchIntEvent.setCategoreis;
    (groups.last as Interactor).setCategories = i;
  }

  TextStyle _getTextTheme(
    BuildContext context, {
    required int index$,
    required int index,
  }) {
    if (index$ == index) {
      return Theme.of(context).textTheme.headline2!.copyWith(
        shadows: [const Shadow(color: Colors.black, offset: Offset(0, -8))],
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationColor: Colors.redAccent,
        decorationThickness: 3,
        decorationStyle: TextDecorationStyle.dashed,
        letterSpacing: kLs,
        fontWeight: FontWeight.bold,
      );
    } else {
      return Theme.of(context).textTheme.headline2!.copyWith(
            color: kGrey,
            letterSpacing: kLs,
          );
    }
  }
}

class _HomeCoins extends ConsumerWidget with Widgets {
  const _HomeCoins({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  static final List<List<String>> coins = [
    ["assets/images/coin.png", "bit"],
    ["assets/images/coin.png", "eth"],
    ["assets/images/coin.png", "pol"],
    ["assets/images/coin.png", "sol"],
    ["assets/images/coin.png", "arb"],
  ];

  static final bool over6 = coins.length >= 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins$ = ref.watch(catchIntProvider(CatchIntEvent.setCoins));

    return SliverToBoxAdapter(
      child: coins$.when(
        data: (int index$) => Padding(
          padding: kHorizontal8,
          child: over6
              ? _wrapper(
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coins.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: height * .2,
                          child: _widgets(context, ref,
                              index$: index$, index: index, over6: over6),
                        ),
                      ),
                    ),
                  ),
                )
              : _wrapper(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var index = 0; index < coins.length; index++)
                        _widgets(context, ref,
                            index$: index$, index: index, over6: over6),
                    ],
                  ),
                ),
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }

  Widget _wrapper(Widget child) {
    return ClipRRect(
      borderRadius: getBorderRadius(10),
      child: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: kAll8,
          child: child,
        ),
      ),
    );
  }

  Widget _widgets(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required int index$,
    required bool over6,
  }) {
    final groups = getInstances(ref);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _setCoin(groups, index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  coins.elementAt(index).elementAt(0),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                coins.elementAt(index).elementAt(1).toUpperCase(),
                style: _getTextTheme(context, index$: index$, index: index),
              ),
            ],
          ),
        ),
        if (over6) kCoinsGap
      ],
    );
  }

  void _setCoin(List<dynamic> groups, int index) {
    (groups.first as ControllerBase).setIntEvt.setState =
        CatchIntEvent.setCoins;
    (groups.last as Interactor).setCoin = index;
  }

  TextStyle _getTextTheme(
    BuildContext context, {
    required int index$,
    required int index,
  }) {
    if (index$ == index) {
      return Theme.of(context).textTheme.bodyText1!.copyWith(
        shadows: [const Shadow(color: Colors.black, offset: Offset(0, -5))],
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        decorationColor: Colors.redAccent,
        decorationThickness: 3,
        decorationStyle: TextDecorationStyle.dashed,
        letterSpacing: kLs,
      );
    } else {
      return Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            color: kGrey,
            letterSpacing: kLs,
          );
    }
  }
}

class _HomeAppBar extends StatelessWidget with Widgets {
  const _HomeAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      imagePath: "assets/images/1.jpg",
      type: AppbarType.home,
      bottom: MainSliverAppBarBottom(type: AppbarType.home),
    );
  }
}

class _TopCategories extends ConsumerWidget with Widgets {
  const _TopCategories({
    Key? key,
  }) : super(key: key);

  static final icons = [
    "assets/images/badge.png",
    "assets/images/rating.png",
    "assets/images/star.png"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _chooseGridItem(groups, index, context);
            },
            child: Padding(
              padding: kAll4,
              child: ShaderBox(
                child: Padding(
                  padding: kAll4,
                  child: ClipRRect(
                    borderRadius: getBorderRadius(10),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/top.jpg",
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          child: ToggleFavorite(index: index),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GlassCard(
                            type: GlassCardPosition.gridRight,
                            child: Padding(
                              padding: kAll4,
                              child: Row(
                                children: [
                                  for (var path in icons)
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Image.asset(path),
                                        ),
                                        if (icons.indexOf(path) !=
                                            icons.length - 1)
                                          const SizedBox(
                                            width: 8,
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _chooseGridItem(List<dynamic> groups, int index, BuildContext context) {
    (groups.first as ControllerBase).setIntEvt.setState =
        CatchIntEvent.setGridItem;
    (groups.last as Interactor).setGridItem = index;
    context.go("${PathVar.topDetails.caller}/$index");
  }
}

class _TrendingCategories extends ConsumerWidget with Widgets {
  const _TrendingCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return GestureDetector(
            onTap: () => context.go("${PathVar.trendingDetails.caller}/$index"),
            child: CustomCard(
              child: Row(
                children: [
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: RoundedImage(
                      child: Image(
                        image: AssetImage("assets/images/trending.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "${index + 1}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const ItemNameWithTag(),
                  const Spacer(),
                  Text(
                    "0.25 ETH",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w500),
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

class _ColletionCategories extends ConsumerWidget with Widgets {
  const _ColletionCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 50,
        (context, index) {
          return GestureDetector(
            onTap: () => context.go(
              "${PathVar.collectionArtist.caller}/artistName!",
            ),
            child: CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: getBorderRadius(60),
                            child: Image.asset("assets/images/2.jpg"),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "nakayama teru".toTitleCase(),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 24,
                                      color: Colors.black54,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    "${index + 100}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .23,
                    child: ListView(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                          20,
                          (index) => Padding(
                            padding: kAll8,
                            child: GestureDetector(
                              onTap: () {
                                context.go(
                                  "${PathVar.collectionArtistDetails.caller}/artistName/$index",
                                );
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: ClipRRect(
                                      borderRadius: getBorderRadius(20),
                                      child: Card(
                                        child:
                                            Image.asset("assets/images/3.jpg"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
