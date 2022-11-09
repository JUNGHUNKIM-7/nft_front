import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global_component.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/enums.dart';
import '../stream_component/stream_components.dart';

class SinglePage extends StatelessWidget with Widgets {
  const SinglePage({
    super.key,
    required this.id,
    required this.type,
    this.name,
  });
  final SinglePageType type;
  final String id;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: CustomScrollView(
        slivers: [
          _SingleViewAppBar(
            height: MediaQuery.of(context).size.height,
            id: id,
            type: type,
          ),
          //debug
          // SliverToBoxAdapter(
          //   child: Text(
          //     type == SinglePageType.bookmark
          //         ? "bookMark single: $id"
          //         : type == SinglePageType.topSingle
          //             ? "top single: $id"
          //             : type == SinglePageType.trendingSingle
          //                 ? "trending single: $id"
          //                 : name != null
          //                     ? "collection: $id / artistName: $name"
          //                     : "",
          //   ),
          // ),
          SliverPadding(
            padding: kVertical8,
          ),
          const _SingleViewBody()
        ],
      ),
    );
  }
}

class _SingleViewBody extends StatelessWidget with Widgets {
  const _SingleViewBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "title".toTitleCase(),
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 32),
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: ClipRRect(
                        borderRadius: getBorderRadius(60),
                        child: Image.asset("assets/images/1.jpg"),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "name".toTitleCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Who we were and what we will become are there, they are around us, they are batting, they are resting and they are being watches ...",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: getBorderRadius(60),
                        child: Image.asset("assets/images/3.jpg"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("highest bid placed by".toTitleCase()),
                        Text(
                          "mary rose".toTitleCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      "15.88 ETH".toTitleCase(),
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  textStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: getBorderRadius(10),
                  ),
                  foregroundColor: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("place bid".toTitleCase()),
                      const SizedBox(
                        width: 18,
                      ),
                      Text("20h:30m:08s".toTitleCase()),
                    ],
                  ),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class _SingleViewAppBar extends ConsumerWidget {
  const _SingleViewAppBar({
    Key? key,
    required this.height,
    required this.id,
    required this.type,
  }) : super(key: key);

  final double height;
  final String id;
  final SinglePageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      pinned: true,
      expandedHeight: height * .45,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .45,
        maxExtent: height * .45,
        child: const ShaderBox(
          child: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: DarkenImage(
                image: AssetImage(
                  "assets/images/2.jpg",
                ),
              ),
            ),
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      actions: [
        if (type == SinglePageType.trendingSingle ||
            type == SinglePageType.topSingle ||
            type == SinglePageType.collection)
          ToggleBookMark(
            index: int.parse(id),
          )
      ],
    );
  }
}
