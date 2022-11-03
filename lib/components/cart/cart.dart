import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global.dart';
import 'package:flutter_layout/utils/providers.dart';
import 'package:flutter_layout/utils/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/repository.dart';
import '../global_component.dart';

class Cart extends ConsumerWidget with Widgets {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookMark$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));
    final cart$ = ref.watch(catchSetProvider(CatchSetEvent.setCart));

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('cart', name: 'cart'),
      ),
      child: bookMark$.when(
        data: (Set<int> b$) => cart$.when(
          data: (Set<int> c$) => CustomScrollView(
            slivers: [
              const CartAppBar(),
              CartBody(
                b$: b$,
                c$: c$,
              )
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

class CartBody extends ConsumerWidget with Widgets {
  const CartBody({
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
        childCount: c$.length,
        (context, index) {
          return DismissableBody(
            b$: b$,
            c$: c$,
            groups: groups,
            idx: index,
            kHorizontal8: kHorizontal8,
            onDissmissed: (direction) {
              switch (direction) {
                case DismissDirection.startToEnd:
                  if (c$.contains(index)) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.unsetCart;
                    (groups.last as Interactor).unsetCart = index;
                  }
                  if (!(b$.contains(index))) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.setBookMark;
                    (groups.last as Interactor).setBookMark = index;
                  }
                  break;
                case DismissDirection.endToStart:
                  if (c$.contains(index)) {
                    (groups.first as ControllerBase).setSetEvent.setState =
                        CatchSetEvent.unsetCart;
                    (groups.last as Interactor).unsetCart = index;
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

class CartAppBar extends StatelessWidget {
  const CartAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainAppBar(
      imagePath: "assets/images/bookmarks.jpg",
      type: AppbarType.cart,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MainSliverAppBarBottom(
          type: AppbarType.cart,
        ),
      ),
    );
  }
}
