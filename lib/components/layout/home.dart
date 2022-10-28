import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/extensions.dart';
import 'package:flutter_layout/providers.dart';
import 'package:flutter_layout/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../style.dart';
import 'elems/home_elems.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}

class HomeBody extends ConsumerWidget with Widgets {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  static final bodys = [
    const BodyMain(),
    const BodyDemo1(),
    const BodyDemo2(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav$ =
        ref.watch(catchIntFamilyProvider(CatchIntEvent.setBottomNav));
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: bottomNav$.when(
          data: (int val) => bodys.elementAt(val),
          error: (err, stk) => Text('$err: $stk'),
          loading: () => const CircularProgressIndicator(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (int val) {
            log('$val', name: 'BottomNavigation');
            repository.setIntEvt.setState = CatchIntEvent.setBottomNav;
            interactor.setBottomNav = val;
          },
          items: [
            BottomNavigationBarItem(
                label: "main".toTitleCase(), icon: const Icon(Icons.abc)),
            BottomNavigationBarItem(
                label: "abc".toTitleCase(), icon: const Icon(Icons.abc)),
            BottomNavigationBarItem(
                label: "abc".toTitleCase(), icon: const Icon(Icons.abc)),
          ],
        ),
      ),
    );
  }
}

class BodyMain extends StatelessWidget with Widgets {
  const BodyMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () => Future.delayed(
        const Duration(seconds: 1),
        () => log('hi', name: 'Refresh:Home'),
      ),
      child: CustomScrollView(
        slivers: [
          CustomSliverAppBar(height: height),
          SliverPadding(padding: kAll8),
          Inputs(height: height),
          SliverPadding(padding: kAll8),
          Coins(height: height),
          SliverPadding(padding: kAll8),
          Categories(height: height),
          SliverPadding(padding: kAll8),
          const GridItems(),
          SliverPadding(padding: kAll8),
          const InfiniteScroll(),
        ],
      ),
    );
  }
}

class BodyDemo1 extends ConsumerWidget {
  const BodyDemo1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(child: Text("body2")),
    );
  }
}

class BodyDemo2 extends ConsumerWidget {
  const BodyDemo2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(child: Text("body3")),
    );
  }
}
