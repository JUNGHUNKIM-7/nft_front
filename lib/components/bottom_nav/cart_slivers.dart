import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global.dart';
import 'package:flutter_layout/utils/providers.dart';
import 'package:flutter_layout/utils/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/repository.dart';
import '../global_component.dart';

class CartMain extends ConsumerWidget with Widgets {
  const CartMain({super.key});

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
              const MainAppBar(
                imagePath: "assets/images/cart.jpg",
                type: AppbarType.cart,
                bottom: MainSliverAppBarBottom(
                  type: AppbarType.cart,
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              _CartBody(
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

class _CartBody extends ConsumerWidget with Widgets {
  const _CartBody({
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
