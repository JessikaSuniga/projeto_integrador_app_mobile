import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/domain/models/borrowed.dart';
import 'package:projeto_integrador_app/app/domain/services/borrowed_service.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

// flutter pub run build_runner build
class BorrowedFormBack {
  Borrowed borrowed;
  final _service = GetIt.I.get<BorrowedService>();

  BorrowedFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context).settings.arguments;
    borrowed = (parameter == null) ? Borrowed() : parameter;
  }

  Future<List<Book>> findAllBookAvailable(int id) {
    return _service.findAllBookAvailable(id);
  }

  save(BuildContext context) async {
    try {
      await _service.save(borrowed);
      CommonService.messageSuccess(context, 'Livro salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageSuccess(context, 'Falha ao salvar livro! $e');
      Navigator.of(context).pop();
    }
  }
}
