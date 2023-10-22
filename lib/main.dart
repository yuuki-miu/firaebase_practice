import 'package:flutter/material.dart';

import 'pages/top_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 41, 249, 225)),
        useMaterial3: true,
      ),
      home: const Toppage(title: 'Flutter × Firebase'),
    );
  }
}
