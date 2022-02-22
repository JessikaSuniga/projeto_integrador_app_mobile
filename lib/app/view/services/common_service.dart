import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonService {
  static messageError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: Colors.red,
    ));
  }

  static messageSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: Colors.green,
    ));
  }

  static String formattedDate(DateTime date) {
    if (date == null) {
      return '';
    }

    return DateFormat('dd/MM/yyyy').format(date);
  }
}
