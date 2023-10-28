import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  Memo({
    required this.id,
    required this.title,
    required this.detail,
    required this.createdDate,
    this.updatedDate,
  });

  String id;
  String title;
  String detail;
  Timestamp createdDate;
  Timestamp? updatedDate;
}
