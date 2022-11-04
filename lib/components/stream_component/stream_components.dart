import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/providers.dart';
import '../../utils/repository.dart';
import '../global.dart';

class ToggleFavorite extends ConsumerWidget {
  const ToggleFavorite({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fav$ = ref.watch(catchSetProvider(CatchSetEvent.setFavorite));
    final groups = getInstances(ref);

    return fav$.when(
      data: (Set<int> f$) => IconButton(
        onPressed: () {
          if (f$.contains(index)) {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.unsetFavorite;
            (groups.last as Interactor).unsetFavorite = index;
          } else {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.setFavorite;
            (groups.last as Interactor).setFavorite = index;
          }
        },
        icon: Icon(
          Icons.favorite,
          color: f$.contains(index) ? Colors.redAccent : Colors.black,
        ),
      ),
      error: (err, stk) => const Text(''),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class ToggleCart extends ConsumerWidget {
  const ToggleCart({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart$ = ref.watch(catchSetProvider(CatchSetEvent.setCart));
    final groups = getInstances(ref);

    return cart$.when(
      data: (Set<int> c$) => IconButton(
        onPressed: () {
          if (c$.contains(index)) {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.unsetCart;
            (groups.last as Interactor).unsetCart = index;
          } else {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.setCart;
            (groups.last as Interactor).setCart = index;
          }
        },
        icon: Icon(
          Icons.shopping_cart,
          color: c$.contains(index) ? Colors.redAccent : Colors.black,
        ),
      ),
      error: (err, stk) => Text('$err: $stk'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class ToggleBookMark extends ConsumerWidget {
  const ToggleBookMark({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookMark$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));
    final groups = getInstances(ref);

    return bookMark$.when(
      data: (Set<int> b$) => IconButton(
        onPressed: () {
          if (b$.contains(index)) {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.unsetBookMark;
            (groups.last as Interactor).unsetBookMark = index;
          } else {
            (groups.first as ControllerBase).setSetEvent.setState =
                CatchSetEvent.setBookMark;
            (groups.last as Interactor).setBookMark = index;
          }
        },
        icon: Icon(
          Icons.bookmark,
          color: b$.contains(index) ? Colors.redAccent : Colors.black,
        ),
      ),
      error: (err, stk) => const Text(''),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
