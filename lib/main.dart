import 'package:flutter/material.dart';
import 'package:meme/features/meme_view/presentation/pages/meme_view_page.dart';
import 'package:meme/injection_container.dart';

void main() async {
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      title: 'Colombian Memes',
      home: MemeViewPage(),
    );
  }
}
