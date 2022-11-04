import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/extensions.dart';
import '../utils/providers.dart';
import '../utils/repository.dart';
import '../utils/style.dart';
import 'global.dart';

class GlassCard extends StatelessWidget with Widgets {
  const GlassCard({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: getBorderRadius(20),
            border: Border.all(width: 2, color: Colors.white30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white10,
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(0),
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(color: Colors.black),
      ),
      child: child,
    );
  }
}

class ToggleFavorite extends ConsumerWidget {
  const ToggleFavorite({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final f$ = ref.watch(catchSetProvider(CatchSetEvent.setFavorite));
    final groups = getInstances(ref);

    return f$.when(
      data: (Set<int> fav$) => IconButton(
        onPressed: () {
          if (fav$.contains(index)) {
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
          color: fav$.contains(index) ? Colors.redAccent : Colors.black,
        ),
      ),
      error: (err, stk) => const Text(''),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class ToggleCart extends ConsumerWidget {
  const ToggleCart(this.index, {super.key});
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
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));
    final groups = getInstances(ref);

    return b$.when(
      data: (Set<int> bookMark$) => IconButton(
        onPressed: () {
          if (bookMark$.contains(index)) {
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
          color: bookMark$.contains(index) ? Colors.redAccent : Colors.black,
        ),
      ),
      error: (err, stk) => const Text(''),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class ItemNameWithTag extends StatelessWidget {
  const ItemNameWithTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
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
    );
  }
}

class DismissableBody extends StatelessWidget {
  const DismissableBody({
    Key? key,
    required this.b$,
    required this.groups,
    required this.c$,
    required this.kHorizontal8,
    required this.idx,
    required Function(DismissDirection direction) onDissmissed,
  })  : _onDissmissed = onDissmissed,
        super(key: key);

  final Set<int> b$;
  final List groups;
  final Set<int> c$;
  final EdgeInsets kHorizontal8;
  final int idx;
  final Function(DismissDirection direction) _onDissmissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: const Icon(Icons.shopping_cart),
      ),
      key: UniqueKey(),
      onDismissed: _onDissmissed,
      child: BodyTiles(
        idx: idx,
        kHorizontal8: kHorizontal8,
      ),
    );
  }
}

class BodyTiles extends StatelessWidget {
  const BodyTiles({
    Key? key,
    required this.kHorizontal8,
    required this.idx,
  }) : super(key: key);

  final EdgeInsets kHorizontal8;
  final int idx;

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
          const Spacer(),
          const ItemNameWithTag(),
          const Spacer(),
          //for debug
          Text("$idx"),
          const SizedBox(
            width: 10,
          ),
          const Text("0.33ETH"),
          Padding(padding: kHorizontal8),
        ],
      ),
    );
  }
}
