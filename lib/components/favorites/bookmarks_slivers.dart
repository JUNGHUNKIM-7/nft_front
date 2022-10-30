import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/providers.dart';
import '../global_component.dart';

class BookMarks extends ConsumerWidget {
  const BookMarks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:BookMark'),
      ),
      child: b$.when(
        data: (Set<int> bookMark$) => CustomScrollView(
          slivers: [
            BookMarkAppBar(
              bookMark$: bookMark$.toList(),
            ),
            BookMarkList(
              bookMark$: bookMark$.toList(),
            ),
          ],
        ),
        error: (err, stk) => const Text(''),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class BookMarkList extends StatelessWidget {
  const BookMarkList({
    Key? key,
    required this.bookMark$,
  }) : super(key: key);

  final List<int> bookMark$;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return BookMarkCards(
            b$: bookMark$.toList(),
            index: index,
          );
        },
        childCount: bookMark$.toList().length,
      ),
    );
  }
}

class BookMarkCards extends StatelessWidget with Widgets {
  const BookMarkCards({
    Key? key,
    required this.b$,
    required this.index,
  }) : super(key: key);
  final List<int> b$;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/1.jpg"),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              text: "titles".toTitleCase(),
              style: Theme.of(context).textTheme.headline1,
              children: [
                TextSpan(
                  text: "#338",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text("${b$[index]}"),
          Padding(padding: kHorizontal8),
        ],
      ),
    );
  }
}

class BookMarkAppBar extends StatelessWidget with Widgets {
  const BookMarkAppBar({
    Key? key,
    required this.bookMark$,
  }) : super(key: key);
  final List<int> bookMark$;

  @override
  Widget build(BuildContext context) {
    return MainAppBar(
      imagePath: "assets/images/3.jpg",
      type: AppbarType.bookmarks,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BookMarkHeaders(
                  texts: ["bookmarks".toTitleCase(), "${bookMark$.length}"],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookMarkHeaders extends StatelessWidget {
  const BookMarkHeaders({
    Key? key,
    required this.texts,
  }) : super(key: key);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Text(
            texts.first,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Spacer(),
          Text(
            texts.last,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}
