import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_layout/utils/extensions.dart';
import 'package:flutter_layout/utils/repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/providers.dart';
import '../utils/style.dart';

List getInstances(WidgetRef ref) =>
    [ref.watch(repositoryProvider), ref.watch(interactorProvider)];

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
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: widget.getBorderRadius(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: widget.getBorderRadius(20),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: widget.getBorderRadius(20),
              ),
            ),
          ),
        ),
      ),
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
      elevation: 10,
      onPressed: () {
        _showInputs(context);
      },
      backgroundColor: Colors.amber,
      child: const Icon(
        Icons.search,
        color: Colors.black,
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

class MainSliverAppBarBottom extends StatelessWidget with Widgets {
  const MainSliverAppBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: GlassCard(
              child: FittedBox(
                child: Padding(
                  padding: kAll8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "monkey #338".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(fontSize: 24),
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
                                ?.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          kWidth15,
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Text(
                              "ETH",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
        BottomNavigationBarItem(
            label: "settings".toTitleCase(), icon: const Icon(Icons.settings)),
      ],
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: getBorderRadius(20),
        border: Border.all(width: 2, color: Colors.white30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Colors.white60, Colors.white10],
        ),
      ),
      child: child,
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
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
          ((groups.last as Interactor)).unsetFavorite = index;
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
