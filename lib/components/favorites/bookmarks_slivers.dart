import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/global.dart';
import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../../utils/style.dart';
import '../global_component.dart';

class BookMarks extends ConsumerWidget with Widgets {
  const BookMarks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookMark$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));
    final cart$ = ref.watch(catchSetProvider(CatchSetEvent.setCart));

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:BookMark'),
      ),
      child: bookMark$.when(
        data: (Set<int> b$) => cart$.when(
          data: (Set<int> c$) => CustomScrollView(
            slivers: [
              const BookMarkAppBar(),
              BookMarkBody(
                b$: b$,
                c$: c$,
              ),
            ],
          ),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class BookMarkBody extends ConsumerWidget with Widgets {
  const BookMarkBody({
    super.key,
    required this.b$,
    required this.c$,
  });

  final Set<int> b$;
  final Set<int> c$;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: b$.length,
        (context, index) {
          return DismissableBody(
            idx: index,
            b$: b$,
            groups: groups,
            c$: c$,
            kHorizontal8: kHorizontal8,
            onDissmissed: (direction) {
              switch (direction) {
                case DismissDirection.startToEnd:
                  if (b$.contains(index)) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.unsetBookMark;
                    (groups.last as Interactor).unsetBookMark = index;
                  }
                  if (!(c$.contains(index))) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.setCart;
                    (groups.last as Interactor).setCart = index;
                  }
                  break;
                case DismissDirection.endToStart:
                  if (b$.contains(index)) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.unsetBookMark;
                    (groups.last as Interactor).unsetBookMark = index;
                  }
                  break;
                default:
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
class BookMarkAppBar extends StatelessWidget with Widgets {
  const BookMarkAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      imagePath: "assets/images/bookmarks.jpg",
      type: AppbarType.bookmarks,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MainSliverAppBarBottom(type: AppbarType.bookmarks),
      ),
    );
  }
}
