import 'package:flutter/material.dart';
import 'package:flutter_layout/components/cart/cart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
import '../utils/style.dart';
import 'bookmark/bookmarks_slivers.dart';
import 'global.dart';
import 'home/home_slivers.dart';

class Home extends ConsumerWidget with Widgets {
  const Home({
    Key? key,
  }) : super(key: key);

  static final bodys = [
    const HomeBody(),
    const BookMarks(),
    const Cart(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav$ = ref.watch(catchIntProvider(CatchIntEvent.setBottomNav));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: const MainDrawer(),
        body: bottomNav$.when(
          data: (int index$) => bodys.elementAt(index$),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
        bottomNavigationBar: bottomNav$.when(
          data: (int index$) => MainBottomNav(index: index$),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
        floatingActionButton: bottomNav$.when(
          data: (int index$) => index$ == 2
              ? const MainFloatingButton(type: FloatingButtonType.payment)
              : const MainFloatingButton(type: FloatingButtonType.search),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
