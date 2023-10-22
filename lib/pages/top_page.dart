import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/model/memo.dart';
import 'package:firebase_practice/pages/memo_detail_page.dart';
import 'package:flutter/material.dart';

class Toppage extends StatefulWidget {
  const Toppage({super.key, required this.title});
  final String title;

  @override
  State<Toppage> createState() => _TopPageState();
}

class _TopPageState extends State<Toppage> {
  List<Memo> memoList = [];

  Future<void> fetchMemo() async {
    final memoCollection =
        await FirebaseFirestore.instance.collection('memo').get();
    final docs = memoCollection.docs;
    for (var doc in docs) {
      Memo fetchMemo = Memo(
        title: doc.data()['title'],
        detail: doc.data()['detail'],
        createdDate: doc.data()['createdDate'],
      );
      memoList.add(fetchMemo);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMemo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(memoList[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoDetailPage(memo: memoList[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
