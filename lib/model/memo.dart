class Memo {
  Memo({
    required this.title,
    required this.detail,
    required this.createdDate,
    this.updatedDate,
  });

  String title;
  String detail;
  DateTime createdDate;
  DateTime? updatedDate;
}
