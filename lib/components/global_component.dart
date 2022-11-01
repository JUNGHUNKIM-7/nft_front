import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/extensions.dart';
import '../utils/providers.dart';
import '../utils/repository.dart';
import '../utils/style.dart';
import 'global.dart';

class Inputs extends ConsumerStatefulWidget with Widgets {
  const Inputs({
    super.key,
    required this.height,
  });
  final double height;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputsState();
}

class _InputsState extends ConsumerState<Inputs> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = getInstances(ref);

    return SizedBox(
      height: widget.height * .1,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: widget.kHorizontal8.copyWith(left: 20, right: 20),
          child: TextField(
            onSubmitted: (value) {
              (groups.first as Repository).setStringEvt.setState =
                  CatchStringEvent.setSearch;
              (groups.last as Interactor).searchValue = value;
            },
            cursorColor: Colors.amber,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.amber),
              labelText: "search items, collections.. ".toTitleCase(),
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
              enabledBorder: _border(),
              focusedBorder: _border(),
              border: _border(),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black),
      borderRadius: widget.getBorderRadius(20),
    );
  }
}

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
              colors: [Colors.white, Colors.white10],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SliverTiles extends StatelessWidget {
  const SliverTiles({super.key, required this.child});
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

class ToggleBookMark extends StatelessWidget {
  const ToggleBookMark({
    super.key,
    required this.b$,
    required this.groups,
    required this.index,
  });

  final Set<int> b$;
  final List groups;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (b$.contains(index)) {
          (groups.first as Repository).setSetEvent.setState =
              CatchSetEvent.unsetBookMark;
          (groups.last as Interactor).unsetBookMark = index;
        } else {
          (groups.first as Repository).setSetEvent.setState =
              CatchSetEvent.setBookMark;
          (groups.last as Interactor).setBookMark = index;
        }
      },
      icon: Icon(
        Icons.bookmark,
        color: b$.contains(index) ? Colors.redAccent : Colors.black,
      ),
    );
  }
}

class ToggleFavorite extends StatelessWidget {
  const ToggleFavorite({
    Key? key,
    required this.f$,
    required this.groups,
    required this.index,
  }) : super(key: key);

  final Set<int> f$;
  final List groups;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (f$.contains(index)) {
          (groups.first as Repository).setSetEvent.setState =
              CatchSetEvent.unsetFavorite;
          (groups.last as Interactor).unsetFavorite = index;
        } else {
          (groups.first as Repository).setSetEvent.setState =
              CatchSetEvent.setFavorite;
          (groups.last as Interactor).setFavorite = index;
        }
      },
      icon: Icon(
        Icons.favorite,
        color: f$.contains(index) ? Colors.redAccent : Colors.black,
      ),
    );
  }
}

class ShopNowBtn extends StatelessWidget {
  const ShopNowBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[500],
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(
        "shop now".toUpperCase(),
        style: Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: 22,
              color: Colors.white,
            ),
      ),
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

// class CustomChip extends StatelessWidget with Widgets {
//   const CustomChip({
//     super.key,
//     this.label,
//     this.labels,
//   });
//   final Text? label;
//   final Row? labels;

//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       child: Chip(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: getBorderRadius(10),
//         ),
//         labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//         label: label != null
//             ? label ?? const Text("")
//             : labels ?? Row(children: const []),
//       ),
//     );
//   }
// }

class SingleViewAppBar extends ConsumerWidget {
  const SingleViewAppBar({
    Key? key,
    required this.height,
    required this.id,
    required this.type,
  }) : super(key: key);

  final double height;
  final String id;
  final SinglePageType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);
    final b$ = ref.watch(catchSetProvider(CatchSetEvent.setBookMark));

    return SliverAppBar(
      pinned: true,
      expandedHeight: height * .4,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .3,
        minExtent: 0,
        maxExtent: height * .6,
        child: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/2.jpg",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      actions: [
        if (type == SinglePageType.trending ||
            type == SinglePageType.top ||
            type == SinglePageType.collection)
          b$.when(
            data: (Set<int> bookMark$) => ToggleBookMark(
              b$: bookMark$,
              groups: groups,
              index: int.parse(id),
            ),
            error: (err, stk) => Text('$err: $stk'),
            loading: () => const CircularProgressIndicator(),
          ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ShopNowBtn(),
          ),
        ),
      ),
    );
  }
}
