import 'package:projeto_integrador_app/app/domain/models/book.dart';

class Borrowed {
  int id;
  int bookId;
  Book book;
  String name;
  DateTime startDate;
  DateTime endDate;

  Borrowed({
    this.id,
    this.bookId,
    this.book,
    this.name,
    this.startDate,
    this.endDate,
  });

  Borrowed.fromMap(dynamic obj) {
    id = obj['id'];
    bookId = obj['book_id'];
    name = obj['name'];
    startDate = _millisecondsToDatetime(obj['start_date'] as int);
    endDate = _millisecondsToDatetime(obj['end_date'] as int);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'book_id': bookId,
      'name': name,
      'start_date': _datetimeToMilliseconds(startDate),
      'end_date': _datetimeToMilliseconds(endDate),
    };

    return map;
  }

  _millisecondsToDatetime(int date) {
    if (date == null) {
      return date;
    }
    return DateTime.fromMillisecondsSinceEpoch(date);
  }

  _datetimeToMilliseconds(DateTime date) {
    if (date == null) {
      return date;
    }
    return date.millisecondsSinceEpoch;
  }
}
