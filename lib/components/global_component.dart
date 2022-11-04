import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/extensions.dart';
import '../utils/style.dart';

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
      padding: const EdgeInsets.all(4.0),
      child: ShaderBox(
        child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          child: child,
        ),
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
            offset: const Offset(2, 4), // Shadow position
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
