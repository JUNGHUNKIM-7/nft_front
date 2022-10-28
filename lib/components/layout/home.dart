import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_layout/extensions.dart';
import 'package:flutter_layout/providers.dart';
import 'package:flutter_layout/repository.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        floatingActionButton: CustomFloatingActionBtn(),
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

class CustomFloatingActionBtn extends ConsumerWidget {
  const CustomFloatingActionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.amber,
      child: Icon(Icons.search),
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
    final Repository repository = ref.watch(repositoryProvider);
    final Interactor interactor = ref.watch(interactorProvider);

    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      currentIndex: index,
      showUnselectedLabels: false,
      onTap: (int val) {
        repository.setIntEvt.setState = CatchIntEvent.setBottomNav;
        interactor.setBottomNav = val;
      },
      selectedLabelStyle: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
      selectedFontSize: 16,
      unselectedLabelStyle: GoogleFonts.orbitron(fontWeight: FontWeight.bold),
      items: [
        BottomNavigationBarItem(
            label: "home".toTitleCase(), icon: const Icon(Icons.home)),
        BottomNavigationBarItem(
            label: "favorite".toTitleCase(), icon: const Icon(Icons.favorite)),
        BottomNavigationBarItem(
            label: "settings".toTitleCase(), icon: const Icon(Icons.settings)),
      ],
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
          // Inputs(height: height),
          Coins(height: height),
          Categories(height: height),
          SliverPadding(padding: kAll8),
          const GridItems(),
          SliverPadding(padding: kAll8),
          // const InfiniteScroll(),
        ],
      ),
    );
  }
}

class BodyDemo1 extends ConsumerWidget {
  const BodyDemo1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("body2"));
  }
}

class BodyDemo2 extends ConsumerWidget {
  const BodyDemo2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text("body3"));
  }
}
