import 'package:example/pages/add_chain.dart';
import 'package:flutter/material.dart';

import 'utils/routes.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.addChainRoute,
      routes: {
        Routes.addChainRoute: (context) => const AddChainScreen(),
      },
    );
  }
}
