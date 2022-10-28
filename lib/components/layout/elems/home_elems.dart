import 'dart:developer';

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
  final List<String> menus = ["trending", "trending", "trending"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setCategoreis));
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * .05,
        child: Container(
          color: Colors.amber,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: stream$.when(
                data: (int index$) => Row(
                  children: [
                    for (var i = 0; i < menus.length; i++)
                      GestureDetector(
                        onTap: () {
                          log('$i', name: 'Categories');
                          repository.setIntEvt.setState =
                              CatchIntEvent.setCategoreis;
                          interactor.setCategories = i;
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: kHorizontal8.copyWith(left: 12),
                              child: Text(
                                menus.elementAt(i).toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: index$ == i
                                          ? Colors.red
                                          : Colors.blue,
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
            padding: widget.kHorizontal8,
            child: TextField(
              onSubmitted: (value) {
                repository.setStringEvt.setState = CatchStringEvent.setSearch;
                interactor.searchValue = value;
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: "search items, collections.. ".toTitleCase(),
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
                color: Colors.teal[100 * (index % 9)],
                borderRadius: getBorderRadius(20),
              ),
              child: Text('Grid Item $index'),
            ),
          );
        },
        childCount: 20,
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
      stretch: true,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .6,
        minExtent: 0,
        maxExtent: height * .6,
        child: FlexibleSpaceBar(
          background: Image.network(
            "https://source.unsplash.com/random/1600*900",
            fit: BoxFit.fill,
            scale: 2,
          ),
          collapseMode: CollapseMode.parallax,
          expandedTitleScale: 1,
          titlePadding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("TITLE"),
              Row(
                children: [
                  const Text("TITLE"),
                  kWidth15,
                  const Text("TITLE"),
                ],
              ),
            ],
          ),
        ),
      ),
      title: const FlutterLogo(),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.abc),
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
    [Icons.abc, "bit"], //TODO: should change index = 0 to image path
    [Icons.abc, "eth"],
    [Icons.abc, "pol"],
    [Icons.abc, "sol"],
    [Icons.abc, "arb"],
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
                      child: _widgets(index, index$, ref, kCoinsGap),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var index = 0; index < coins.length; index++)
                        _widgets(index, index$, ref, kCoinsGap),
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
  Row _widgets(int index, int index$, WidgetRef ref, SizedBox sizedBox) {
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            log('$index', name: 'Coins');
            repository.setIntEvt.setState = CatchIntEvent.setCoins;
            interactor.setCoin = index;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                coins.elementAt(index).elementAt(0) as IconData,
                size: 45,
                color: index$ == index ? Colors.red : Colors.blue,
              ),
              Text(
                "${coins.elementAt(index).elementAt(1)}",
                style: TextStyle(
                    color: index$ == index ? Colors.red : Colors.blue),
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
