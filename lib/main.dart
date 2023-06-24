import 'package:comic_cabinet/screens/comic_list.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        useMaterial3: true,
        scaffoldBackgroundColor: white,
      ),
      home: const ComicList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
