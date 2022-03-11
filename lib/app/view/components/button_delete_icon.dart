import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';

class ButtonDeleteIcon extends StatelessWidget {
  final BuildContext _context;
  final Function _onRemove;

  const ButtonDeleteIcon(this._context, this._onRemove, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      label: 'Delete',
      backgroundColor: Constants.myDarkBeige,
      foregroundColor: Colors.black,
      icon: Icons.delete,
      onPressed: (ctx) {
        showDialog(
          context: _context,
          builder: (_) => AlertDialog(
            title: const Text('Excluir livro'),
            content: const Text('Tem certeza?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () => Navigator.of(_context).pop(),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: _onRemove as void Function()?,
              ),
            ],
          ),
        );
      },
    );
  }
}
