import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
import '../utils/style.dart';
import 'global_component.dart';

List getInstances(WidgetRef ref) =>
    [ref.watch(repositoryProvider), ref.watch(interactorProvider)];

enum AppbarType { home, bookmarks }

class MainAppBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
          background: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
      ),
      title: type == AppbarType.home
          ? const FlutterLogo()
          : Text(
              "bookmarks".toTitleCase(),
              style: Theme.of(context).textTheme.headline1,
            ),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
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

class MainFloatingActionBtn extends ConsumerWidget with Widgets {
  const MainFloatingActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: getBorderRadius(60),
      ),
      elevation: 10,
      onPressed: () {
        _showInputs(context);
      },
      backgroundColor: Colors.black54,
      child: const Icon(
        Icons.search,
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
        (groups.first as Repository).setIntEvt.setState =
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
            label: "favorites".toTitleCase(), icon: const Icon(Icons.bookmark)),
        // BottomNavigationBarItem(
        //     label: "settings".toTitleCase(), icon: const Icon(Icons.settings)),
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
          const SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              child: FlutterLogo(),
            ),
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

class MainSliverAppBarBottom extends StatelessWidget with Widgets {
  const MainSliverAppBarBottom(
      {super.key, required this.type, this.bookMarks$});

  final AppbarType type;
  final List<int>? bookMarks$;

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
              child: type == AppbarType.home
                  ? _bottomGlass(context)
                  : _bottomGlass(context),
            ),
          ),
        ),
      ),
    );
  }

  Row _bottomGlass(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "monkey #338".toUpperCase(),
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "0.25",
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
          ],
        ),
        kWidth30,
        const ShopNowBtn(),
      ],
    );
  }
}
