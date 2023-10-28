import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/model/memo.dart';
import 'package:firebase_practice/pages/my_app_bar.dart';
import 'package:flutter/material.dart';

class AddEditMemoPage extends StatefulWidget {
  const AddEditMemoPage({this.currentMemo, super.key});
  final Memo? currentMemo;

  @override
  State<AddEditMemoPage> createState() => _AddMemoEditPage();
}

class _AddMemoEditPage extends State<AddEditMemoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> createMemo() async {
    final memoCollection = FirebaseFirestore.instance.collection('memo');
    await memoCollection.add({
      'title': titleController.text,
      'detail': detailController.text,
      'createdDate': Timestamp.now()
    });
  }

  Future<void> updateMemo() async {
    final doc = FirebaseFirestore.instance
        .collection('memo')
        .doc(widget.currentMemo!.id);
    await doc.update({
      'title': titleController.text,
      'detail': detailController.text,
      'updatedMemo': Timestamp.now(),
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.currentMemo != null) {
      titleController.text = widget.currentMemo!.title;
      detailController.text = widget.currentMemo!.detail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.currentMemo == null ? 'メモ追加' : 'メモ編集'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text('タイトル'),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text('詳細'),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: detailController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await widget.currentMemo == null
                      ? await createMemo()
                      : await updateMemo();
                  Navigator.pop(context);
                },
                child: Text(
                  widget.currentMemo == null ? '追加' : '更新',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
