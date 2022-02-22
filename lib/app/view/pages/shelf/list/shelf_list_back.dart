import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
part 'shelf_list_back.g.dart';

class ShelfListBack = _ShelfListBack with _$ShelfListBack;

// comand: flutter pub run build_runner build --delete-conflicting-outputs
//flutter packages pub run build_runner clean
abstract class _ShelfListBack with Store {
  final _service = GetIt.I.get<ShelfService>();

  @observable
  Future<List<Shelf>> list;

  @action
  refleshList([dynamic value]) {
    list = _service.findAll();
  }

  _ShelfListBack() {
    refleshList();
  }

  goToForm(BuildContext context, [Shelf shelf]) {
    Navigator.of(context)
        .pushNamed(Routes.SHELF_FORM, arguments: shelf)
        .then(refleshList);
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();
      Navigator.of(context).pop();
      CommonService.messageSuccess(context, 'Estante deletada com sucesso!');
    } catch (e) {
      CommonService.messageSuccess(context, 'Falha ao deletar estante! $e!');
      Navigator.of(context).pop();
    }
  }
}
