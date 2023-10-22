import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:flutter/material.dart';

import 'pages/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
