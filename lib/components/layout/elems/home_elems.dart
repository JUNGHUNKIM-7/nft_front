import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_layout/extensions.dart';
import 'package:flutter_layout/main.dart';
import 'package:flutter_layout/providers.dart';
import 'package:flutter_layout/style.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repository.dart';

class Categories extends ConsumerWidget with Widgets {
  Categories({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  final List<String> menus = ["top", "trending", "collections"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setCategoreis));
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * .06,
        child: Container(
          color: Colors.amber,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: kAll8,
              child: stream$.when(
                data: (int index$) => Row(
                  children: [
                    for (var i = 0; i < menus.length; i++)
                      GestureDetector(
                        onTap: () {
                          repository.setIntEvt.setState =
                              CatchIntEvent.setCategoreis;
                          interactor.setCategories = i;
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: kHorizontal8.copyWith(left: 20),
                              child: Text(
                                menus.elementAt(i).toTitleCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
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

class Inputs extends ConsumerStatefulWidget with Widgets {
  const Inputs({
    super.key,
    required this.height,
  });
  final double height;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputsState();
}

class _InputsState extends ConsumerState<Inputs> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: widget.height * .1,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: widget.kHorizontal8.copyWith(left: 20, right: 20),
            child: TextField(
              onSubmitted: (value) {
                repository.setStringEvt.setState = CatchStringEvent.setSearch;
                interactor.searchValue = value;
              },
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                labelText: "search items, collections.. ".toTitleCase(),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: widget.getBorderRadius(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: widget.getBorderRadius(20),
                ),
                border: OutlineInputBorder(
                  borderRadius: widget.getBorderRadius(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridItems extends ConsumerWidget with Widgets {
  const GridItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite$ = ref.watch(favoriteProvider(CatchSetEvent.setFavorite));
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              repository.setIntEvt.setState = CatchIntEvent.setGridItem;
              interactor.setGridItem = index;
              context.go("${PathVar.gridItem.caller}/$index");
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: getBorderRadius(20),
              ),
              child: ClipRRect(
                borderRadius: getBorderRadius(20),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/2.jpg",
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: kAll8,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: getBorderRadius(20),
                              border:
                                  Border.all(width: 2, color: Colors.white30),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                                colors: [Colors.white60, Colors.white10],
                              ),
                            ),
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "0.25",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    kWidth15,
                                    Text(
                                      "ETH",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    favorite$.when(
                      data: (Set<int> f$) => IconButton(
                        onPressed: () {
                          if (f$.contains(index)) {
                            repository.setListEvent.setState =
                                CatchSetEvent.unsetFavorite;
                            interactor.unsetFavorite = index;
                          } else {
                            repository.setListEvent.setState =
                                CatchSetEvent.setFavorite;
                            interactor.setFavorite = index;
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color:
                              f$.contains(index) ? Colors.amber : Colors.black,
                        ),
                      ),
                      error: (err, stk) => const Text(''),
                      loading: () => const CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        childCount: 10,
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget with Widgets {
  const CustomSliverAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: height * .4,
      centerTitle: true,
      pinned: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: getBorderRadius(20),
                    border: Border.all(width: 2, color: Colors.white30),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white60, Colors.white10],
                    ),
                  ),
                  child: FittedBox(
                    child: Padding(
                      padding: kAll8,
                      child: Opacity(
                        opacity: 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "monkey #338".toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  ?.copyWith(fontSize: 24),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "0.25",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                ),
                                kWidth15,
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    "ETH",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .3,
        minExtent: 0,
        maxExtent: height * .6,
        child: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/1.jpg",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      title: Text(
        "nft market".toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(fontSize: 20, color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.white,
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
    // todo: should change index = 0 to image path
    [Icons.money, "bit"],
    [Icons.money, "eth"],
    [Icons.money, "pol"],
    [Icons.money, "sol"],
    [Icons.money, "arb"],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream$ = ref.watch(catchIntFamilyProvider(CatchIntEvent.setCoins));

    return SliverToBoxAdapter(
      child: stream$.when(
        data: (int index$) => Container(
          color: Colors.black,
          height: height * .1,
          child: Padding(
            padding: kHorizontal8.copyWith(left: 12),
            child: coins.length > 5
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: coins.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: height * .2,
                      child: _widgets(context, index, index$, ref, kCoinsGap),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            repository.setIntEvt.setState = CatchIntEvent.setCoins;
            interactor.setCoin = index;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                coins.elementAt(index).elementAt(0) as IconData,
                size: 45,
                color: index$ == index ? Colors.amber : Colors.white,
              ),
              Text(
                "${coins.elementAt(index).elementAt(1)}".toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: index$ == index ? Colors.amber : Colors.white,
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

class InfiniteScroll extends StatelessWidget {
  const InfiniteScroll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('List Item $index'),
          );
        },
      ),
    );
  }
}
