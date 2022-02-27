import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
part 'shelf_list_back.g.dart';

class ShelfListBack = _ShelfListBack with _$ShelfListBack;

// comand: flutter pub run build_runner build --delete-conflicting-outputs
//flutter packages pub run build_runner clean
abstract class _ShelfListBack with Store {
  final _service = ShelfService();

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
        .pushNamed(Routes.SHELF_TO_BOOK_LIST, arguments: shelf)
        .then(refleshList);
  }

  @action
  dispacheDialogSave(BuildContext context, [Shelf shelfRef]) {
    Shelf shelf = Shelf();
    if (shelfRef != null) {
      shelf = shelfRef;
    }

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nova estante'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: shelf.name,
            // validator: (value) {
            //   return _validationIsNullOrEmpty(value);
            // },
            onSaved: (value) => shelf.name = value,
            decoration: const InputDecoration(
              labelText: 'Nome',
              labelStyle: Constants.sdFormTitle,
              hintText: 'Informe um nome para sua estante',
              hintStyle: Constants.sdFormHint,
              focusedBorder: Constants.sdFormFocusedDorder,
            ),
            style: Constants.sdFormText,
            cursorColor: Constants.myGrey,
            textInputAction: TextInputAction.next,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Não'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Sim'),
            onPressed: () {
              _formKey.currentState.validate();
              _formKey.currentState.save();
              save(context, shelf) /*.then((e) => refleshList())*/;
            },
          ),
        ],
      ),
    );
  }

  Future save(BuildContext context, Shelf shelf) async {
    try {
      await _service.save(shelf);
      CommonService.messageSuccess(context, 'Estante salva com sucesso!');
      Navigator.of(context).pop();
      refleshList();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar estante! $e');
      Navigator.of(context).pop();
    }
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();

      Navigator.of(context).pop();
      CommonService.messageSuccess(context, 'Estante deletada com sucesso!');
    } catch (e) {
      CommonService.messageError(context, 'Falha ao deletar estante! $e!');
      Navigator.of(context).pop();
    }
  }
}
