import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/model/memo.dart';
import 'package:firebase_practice/pages/add_edit_memo_page.dart';
import 'package:firebase_practice/pages/memo_detail_page.dart';
import 'package:flutter/material.dart';

class Toppage extends StatefulWidget {
  const Toppage({super.key, required this.title});
  final String title;

  @override
  State<Toppage> createState() => _TopPageState();
}

class _TopPageState extends State<Toppage> {
  final memoCollection = FirebaseFirestore.instance.collection('memo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      //StreamBuilderを用いることで更新があるかチェックしている
      body: StreamBuilder<QuerySnapshot>(
        stream: memoCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('データがありません'),
            );
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;
              final Memo fetchMemo = Memo(
                id: docs[index].id,
                title: data['title'],
                detail: data['detail'],
                createdDate: data['createdDate'],
                updatedDate: data['updatedData'],
              );
              return ListTile(
                title: Text(fetchMemo.title),
                trailing: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AddEditMemoPage(
                                            currentMemo: fetchMemo,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  leading: Icon(Icons.edit),
                                  title: const Text('編集'),
                                ),
                                ListTile(
                                  onTap: () {},
                                  leading: Icon(Icons.delete),
                                  title: const Text('削除'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemoDetailPage(memo: fetchMemo),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditMemoPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
