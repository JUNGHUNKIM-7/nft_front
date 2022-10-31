import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
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

class TilesForSliver extends StatelessWidget {
  const TilesForSliver({super.key, required this.child});
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
    required this.type,
  }) : super(key: key);

  final AppbarType type;

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

class CustomChip extends StatelessWidget with Widgets {
  const CustomChip({
    super.key,
    this.label,
    this.labels,
  });
  final Align? label;
  final Row? labels;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Chip(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: getBorderRadius(10),
        ),
        labelStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w500,
            ),
        label: label != null
            ? Align(child: label ?? const Text(""))
            : labels ?? Row(children: const []),
      ),
    );
  }
}
