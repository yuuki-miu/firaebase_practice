import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  Memo({
    required this.title,
    required this.detail,
    required this.createdDate,
    this.updatedDate,
  });

  String title;
  String detail;
  Timestamp createdDate;
  Timestamp? updatedDate;
}
