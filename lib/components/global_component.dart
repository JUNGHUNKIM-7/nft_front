import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_layout/components/global.dart';

import '../utils/extensions.dart';
import '../utils/style.dart';

enum GlassCardPosition { gridLeft, gridRight, global }

class GlassCard extends StatelessWidget with Widgets {
  const GlassCard({
    super.key,
    required this.child,
    required this.type,
  });
  final Widget child;
  final GlassCardPosition type;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _getBorderRadius(type),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _getBorderRadius(type),
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

  BorderRadius _getBorderRadius(GlassCardPosition type) {
    switch (type) {
      case GlassCardPosition.gridLeft:
        return const BorderRadius.only(
          bottomRight: Radius.circular(10),
        );
      case GlassCardPosition.gridRight:
        return const BorderRadius.only(
          topLeft: Radius.circular(10),
        );
      case GlassCardPosition.global:
        return BorderRadius.circular(10);
    }
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
          RoundedImage(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset("assets/images/1.jpg"),
            ),
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

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: ShaderBox(
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          margin: const EdgeInsets.all(0),
          elevation: 0,
          child: child,
        ),
      ),
    );
  }
}

class MainSliverBottomBtn extends StatelessWidget {
  const MainSliverBottomBtn({
    Key? key,
    required this.type,
  }) : super(key: key);
  final AppbarType type;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      type: GlassCardPosition.global,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          child: Text(
            _getText(type)?.toUpperCase() ?? "",
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 22,
                  color: Colors.white,
                ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  String? _getText(AppbarType type) {
    switch (type) {
      case AppbarType.home:
        return "explore now";
      default:
        return null;
    }
  }
}

class DarkenImage extends StatelessWidget {
  const DarkenImage({super.key, required this.image});
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }
}

class ShaderBox extends StatelessWidget with Widgets {
  const ShaderBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: getBorderRadius(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: child,
    );
  }
}
