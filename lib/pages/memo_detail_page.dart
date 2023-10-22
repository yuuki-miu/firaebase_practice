import 'package:firebase_practice/pages/my_app_bar.dart';
import 'package:flutter/material.dart';

import '../model/memo.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage({required this.memo, super.key});
  final Memo memo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: memo.title,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'メモ詳細',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              memo.detail,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
