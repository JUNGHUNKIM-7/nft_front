import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/extensions.dart';
import '../../utils/repository.dart';
import '../utils/providers.dart';
import '../utils/style.dart';
import 'global_component.dart';

List getInstances(WidgetRef ref) => [
      ref.watch(repositoryProvider),
      ref.watch(interactorProvider),
    ];

enum AppbarType {
  home,
  artistCollection,
  bookmarks,
  cart,
}

enum SinglePageType {
  top,
  trending,
  trendingSingle,
  collection,
  bookmark,
}

enum InfinitePageType {
  top,
  trending,
  artistCollection,
}

enum FloatingButtonType { search, payment }

class MainAppBar extends ConsumerWidget {
  const MainAppBar({
    super.key,
    required this.imagePath,
    required this.type,
    required this.bottom,
  });

  final String imagePath;
  final AppbarType type;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return SliverAppBar(
      expandedHeight: height * .45,
      centerTitle: true,
      pinned: true,
      bottom: bottom,
      flexibleSpace: FlexibleSpaceBar.createSettings(
        currentExtent: height * .45,
        maxExtent: height * .45,
        child: FlexibleSpaceBar(
          background: DarkenImage(
            image: AssetImage(imagePath),
          ),
        ),
      ),
      title: type == AppbarType.home
          ? SizedBox(
              width: 150,
              height: 80,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            )
          : type == AppbarType.bookmarks
              ? Text(
                  "bookmarks".toTitleCase(),
                  style: Theme.of(context).textTheme.headline1,
                )
              : type == AppbarType.artistCollection
                  ? Text(
                      "collection".toTitleCase(),
                      style: Theme.of(context).textTheme.headline1,
                    )
                  : Text(
                      "cart".toTitleCase(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
      leading: type == AppbarType.home
          ? IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          : null,
      actions: [
        if (type == AppbarType.home)
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

class MainSliverAppBarBottom extends StatelessWidget with Widgets {
  const MainSliverAppBarBottom({
    super.key,
    required this.type,
  });
  final AppbarType type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: kAll8,
        child: GlassCard(
          child: FittedBox(
            child: Padding(
              padding: kAll8,
              child: _bottomGlass(context, type: type),
            ),
          ),
        ),
      ),
    );
  }

  Row _bottomGlass(
    BuildContext context, {
    required AppbarType type,
  }) {
    Column col() => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _getChildren(context, type: type),
        );
    switch (type) {
      case AppbarType.home:
        return Row(
          children: [
            col(),
            kWidth30,
            const ShopNowBtn(),
          ],
        );
      case AppbarType.artistCollection:
        return Row(
          children: [
            col(),
            kWidth30,
            const ShopNowBtn(),
          ],
        );
      case AppbarType.bookmarks:
        return Row(
          children: [
            col(),
            kWidth30,
            const ShopNowBtn(),
          ],
        );
      case AppbarType.cart:
        return Row(
          children: [
            col(),
            kWidth30,
            const ShopNowBtn(),
          ],
        );
    }
  }

  List<Widget> _getChildren(
    BuildContext context, {
    required AppbarType type,
  }) {
    switch (type) {
      case AppbarType.home:
        return _getText(context, "monkey#338", "0.25");
      case AppbarType.artistCollection:
        return _getText(context, "monkey#338", "0.25");
      case AppbarType.bookmarks:
        return _getText(context, "monkey#338", "0.25");
      case AppbarType.cart:
        return _getText(context, "monkey#338", "0.25");
    }
  }

  List<Widget> _getText(BuildContext context, String header, String sub) {
    return [
      Text(
        header.toUpperCase(),
        style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 24),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          Text(
            sub,
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          kWidth15,
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Text(
              "ETH",
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    ];
  }
}

class MainFloatingButton extends StatelessWidget with Widgets {
  const MainFloatingButton({
    super.key,
    required FloatingButtonType type,
  }) : _type = type;
  final FloatingButtonType _type;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: getBorderRadius(60),
      ),
      elevation: 10,
      onPressed: () {
        switch (_type) {
          case FloatingButtonType.search:
            _showInputs(context);
            break;
          case FloatingButtonType.payment:
            break;
        }
      },
      backgroundColor: Colors.black54,
      child: Icon(
        _type == FloatingButtonType.search ? Icons.search : Icons.payment,
        color: Colors.white,
      ),
    );
  }

  void _showInputs(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: ((context) {
        return Container(
          height: 600,
          color: Colors.amber,
          child: Center(
            child: Column(
              children: [
                kHeight30,
                Inputs(height: MediaQuery.of(context).size.height * .8),
                kHeight15,
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "back".toTitleCase(),
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              fontSize: 16,
                              letterSpacing: kLetterSpacing,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MainBottomNav extends ConsumerWidget {
  const MainBottomNav({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = getInstances(ref);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: index,
      showUnselectedLabels: false,
      onTap: (int val) {
        (groups.first as ControllerBase).setIntEvt.setState =
            CatchIntEvent.setBottomNav;
        (groups.last as Interactor).setBottomNav = val;
      },
      selectedLabelStyle: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
      selectedFontSize: 16,
      unselectedLabelStyle: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
      items: [
        BottomNavigationBarItem(
            label: "home".toTitleCase(), icon: const Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "bookmarks".toTitleCase(), icon: const Icon(Icons.bookmark)),
        BottomNavigationBarItem(
            label: "cart".toTitleCase(), icon: const Icon(Icons.shopping_cart)),
      ],
    );
  }
}

class MainDrawer extends StatelessWidget with Widgets {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amber,
      child: Column(
        children: [
          kHeight30,
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset("assets/images/logo.png"),
          ),
          const Spacer(),
          Column(
            children: [
              ...List.generate(
                5,
                (index) => ListTile(
                  leading: const Icon(Icons.abc),
                  title: Text(
                    "drawer1: $index".toTitleCase(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: kHorizontal8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  3,
                  (index) => Column(
                    children: [
                      const Icon(
                        Icons.abc,
                        size: 40,
                      ),
                      Text("$index")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
