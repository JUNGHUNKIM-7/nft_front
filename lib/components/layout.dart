import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
import '../utils/style.dart';
import 'details_page/detail_page_slivers.dart';
import 'favorites/bookmarks_slivers.dart';
import 'global.dart';
import 'home/home_slivers.dart';

//scaffold + stream lev

class Home extends ConsumerWidget with Widgets {
  const Home({
    Key? key,
  }) : super(key: key);

  static final bodys = [
    const HomeBody(),
    const BookMarks(),
    // const Settings(),
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
        backgroundColor: Colors.grey[300],
        drawer: const MainDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const MainFloatingActionBtn(),
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

//for making id page
class DetailsPageNavBodies {
  DetailsPageNavBodies({
    required this.id,
  }) : _bodies = [
          DetailsPageHome(id: id),
          const BookMarks(),
          // const Settings(),
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
      body: bottomNav$.when(
        data: (int $index) => bodies.bodies[$index],
        error: (err, stk) => Text('$err: $stk'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
