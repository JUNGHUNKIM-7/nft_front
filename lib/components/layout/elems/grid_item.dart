import 'package:flutter/material.dart';
import 'package:flutter_layout/main.dart';
import 'package:go_router/go_router.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(id),
            ElevatedButton(
              onPressed: () => context.go(PathVar.home.path),
              child: const Text("go home"),
            )
          ],
        ),
      ),
    );
  }
}
