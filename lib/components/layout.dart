import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
import '../utils/style.dart';
import 'details_page/detail_page_slivers.dart';
import 'favorites/favorites.dart';
import 'global.dart';
import 'home/home_slivers.dart';
import 'settings/settings.dart';

//scaffold + stream lev

class Home extends ConsumerWidget with Widgets {
  const Home({
    Key? key,
  }) : super(key: key);

  static final bodys = [
    const HomeBody(),
    const Favorites(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setBottomNav));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: MainDrawer(kHeight30: kHeight30, kHorizontal8: kHorizontal8),
        floatingActionButton: const MainFloatingActionBtn(),
        backgroundColor: Colors.grey[300],
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
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
    required this.kHeight30,
    required this.kHorizontal8,
  }) : super(key: key);

  final SizedBox kHeight30;
  final EdgeInsets kHorizontal8;

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

//for making id page
class DetailsPageNavBodies {
  DetailsPageNavBodies({
    required this.id,
  }) : _bodies = [
          DetailsPageHome(id: id),
          const Favorites(),
          const Settings(),
        ];

  final String id;
  late final List<Widget> _bodies;
  List<Widget> get bodies => _bodies;
}

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  late DetailsPageNavBodies bodies;

  @override
  void initState() {
    super.initState();
    bodies = DetailsPageNavBodies(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final bottomNav$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setBottomNav));

    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: bottomNav$.when(
        data: (int $index) => MainBottomNav(index: $index),
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
      body: bottomNav$.when(
        data: (int $index) => bodies.bodies[$index],
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
