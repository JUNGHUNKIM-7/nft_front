import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/enums.dart';
import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../../utils/style.dart';
import '../global.dart';
import '../global_component.dart';

class BookMarkMain extends ConsumerWidget with Widgets {
  const BookMarkMain({super.key});

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
              const MainAppBar(
                imagePath: "assets/images/bookmarks.jpg",
                type: AppbarType.bookmarks,
                bottom: MainSliverAppBarBottom(type: AppbarType.bookmarks),
              ),
              SliverPadding(
                padding: kVertical8,
              ),
              _BookMarkBody(
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

class _BookMarkBody extends ConsumerWidget with Widgets {
  const _BookMarkBody({
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
          return SliderBtnBody(
            b$: b$,
            c$: c$,
            groups: groups,
            idx: index,
            kHorizontal8: kHorizontal8,
            onDismissed: (direction) {
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
