import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/providers.dart';
import 'package:flutter_layout/utils/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Cart extends ConsumerWidget with Widgets {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            "x items in cart".toTitleCase(),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SliverFillRemaining(
          child: CartBody(),
        )
      ],
    );
  }
}

class CartBody extends ConsumerWidget with Widgets {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart$ = ref.watch(catchSetProvider(CatchSetEvent.setCart));

    return Expanded(
      child: cart$.when(
        data: (Set<int> c$) {
          final carts = c$.toList();
          return ListView.builder(
            itemCount: carts.length,
            itemBuilder: (context, index) {
              final elem = carts[index];

              return Dismissible(
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    log('delete', name: 'dismissible btn');
                  } else if (direction == DismissDirection.startToEnd) {
                    log('add to bookMark', name: 'dismissable btn');
                  } else {
                    log('nothing to do', name: 'dismissable btn');
                  }
                },
                key: ValueKey("$index"),
                child: CartCard(id: elem),
              );
            },
          );
        },
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class CartCard extends StatelessWidget with Widgets {
  const CartCard({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: getBorderRadius(10),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset("assets/images/3.jpg"),
            ),
          ),
          Text("$id"),
        ],
      ),
    );
  }
}

class CartPaymentFloatingBtn extends StatelessWidget {
  const CartPaymentFloatingBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.payment),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 200,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Modal BottomSheet'),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
