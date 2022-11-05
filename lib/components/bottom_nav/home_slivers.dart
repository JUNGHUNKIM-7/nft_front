import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/stream_component/stream_components.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
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

  static final categorieBodies = [
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
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:Home'),
      ),
      child: categories$.when(
        data: (int $index) => CustomScrollView(
          slivers: [
            _HomeAppBar(height: height),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            _HomeCoins(height: height),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            _HomeCategories(height: height),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            categorieBodies.elementAt($index),
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
                          (groups.first as ControllerBase).setIntEvt.setState =
                              CatchIntEvent.setCategoreis;
                          (groups.last as Interactor).setCategories = i;
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
        letterSpacing: kLetterSpacing,
        fontWeight: FontWeight.bold,
      );
    } else {
      return Theme.of(context).textTheme.headline2!.copyWith(
            color: Colors.grey[600],
            letterSpacing: kLetterSpacing,
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

  static final coins = [
    [Icons.money, "bit"],
    [Icons.money, "eth"],
    [Icons.money, "pol"],
    [Icons.money, "sol"],
    [Icons.money, "arb"],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins$ = ref.watch(catchIntProvider(CatchIntEvent.setCoins));

    return SliverToBoxAdapter(
      child: coins$.when(
        data: (int index$) => Padding(
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
                color: index$ == index ? Colors.black : Colors.grey[600],
              ),
              Text(
                "${coins.elementAt(index).elementAt(1)}".toUpperCase(),
                style: _getTextTheme(context, index$: index$, index: index),
              ),
            ],
          ),
        ),
        sizedBox,
      ],
    );
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
        letterSpacing: kLetterSpacing,
      );
    } else {
      return Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            color: Colors.grey[600],
            letterSpacing: kLetterSpacing,
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
              (groups.first as ControllerBase).setIntEvt.setState =
                  CatchIntEvent.setGridItem;
              (groups.last as Interactor).setGridItem = index;
              context.go("${PathVar.topDetails.caller}/$index");
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ShaderBox(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: getBorderRadius(10),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/top.jpg",
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          child: GlassCard(
                            type: GlassCardPosition.gridLeft,
                            child: ToggleFavorite(index: index),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GlassCard(
                            type: GlassCardPosition.gridRight,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.insights,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.hotel_class,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 30,
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
