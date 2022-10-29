import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../../utils/style.dart';
import '../global.dart';

class TopItems extends ConsumerWidget with Widgets {
  const TopItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f$ = ref.watch(catchSetProvider(CatchSetEvent.setFavorite));
    final groups = getInstances(ref);

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              (groups.first as Repository).setIntEvt.setState =
                  CatchIntEvent.setGridItem;
              (groups.last as Interactor).setGridItem = index;
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
                        alignment: Alignment.bottomRight,
                        child: GlassCard(
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
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "ETH",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        f$.when(
                          data: (Set<int> fav$) => ToggleFavorite(
                            f$: fav$,
                            groups: groups,
                            index: index,
                          ),
                          error: (err, stk) => const Text(''),
                          loading: () => const CircularProgressIndicator(),
                        ),
                        Text(
                          "${index + 100}",
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrendingItems extends ConsumerWidget with Widgets {
  const TrendingItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) {
          return CustomCard(
            child: Row(
              children: [
                const SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: AssetImage("assets/images/3.jpg"),
                    fit: BoxFit.contain,
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
                RichText(
                  text: TextSpan(
                    text: "monkey".toTitleCase(),
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                    children: [
                      TextSpan(
                        text: "#338",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
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
          );
        },
      ),
    );
  }
}

class CollectionItems extends ConsumerWidget with Widgets {
  const CollectionItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 10,
        (context, index) {
          return CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: getBorderRadius(60),
                          child: Image.asset("assets/images/2.jpg"),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "nakayama teru".toTitleCase(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        20,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: getBorderRadius(20),
                                  child: Card(
                                    child: Image.asset("assets/images/3.jpg"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: GlassCard(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Name#333".toTitleCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
