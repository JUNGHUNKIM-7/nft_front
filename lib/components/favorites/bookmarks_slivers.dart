import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/global.dart';
import '../../main.dart';
import '../../utils/providers.dart';
import '../../utils/style.dart';
import '../global_component.dart';

//appbar => bookMarks.first
//tiles => bookMarks.range(1)

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
              bookMarks$: bookMark$.toList(),
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
    return GestureDetector(
      onTap: () {
        context.go("${PathVar.bookmark.caller}/$index");
      },
      child: SliverTiles(
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
            const ItemNameWithTag(),
            const Spacer(),
            Text("${b$[index]}"),
            Padding(padding: kHorizontal8),
          ],
        ),
      ),
    );
  }
}

class BookMarkAppBar extends StatelessWidget with Widgets {
  const BookMarkAppBar({
    Key? key,
    required this.bookMarks$,
  }) : super(key: key);
  final List<int> bookMarks$;

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      imagePath: "assets/images/3.jpg", //bookmark$.first["image path"]
      type: AppbarType.bookmarks,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MainSliverAppBarBottom(type: AppbarType.bookmarks),
      ),
    );
  }
}

// class BookMarkHeaders extends StatelessWidget with Widgets {
//   const BookMarkHeaders({
//     Key? key,
//     required this.texts,
//   }) : super(key: key);
//   final List<String> texts;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               texts.first,
//               style: Theme.of(context).textTheme.headline2?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                     letterSpacing: kLetterSpacing,
//                   ),
//             ),
//             // const Spacer(),
//             Text(
//               texts.last,
//               style: Theme.of(context).textTheme.headline2?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     letterSpacing: kLetterSpacing,
//                   ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
