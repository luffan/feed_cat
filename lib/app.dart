import 'package:flutter/material.dart';

import 'page/cat_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CatPage(),
    );
  }
}