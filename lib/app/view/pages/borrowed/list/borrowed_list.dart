import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/borrowed.dart';
import 'package:projeto_integrador_app/app/view/components/button_delete_icon.dart';
import 'package:projeto_integrador_app/app/view/components/button_edit_icon.dart';
import 'package:projeto_integrador_app/app/view/components/tile.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/list/borrowed_list_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class BorrowedList extends StatelessWidget {
  BorrowedList({Key key}) : super(key: key);

  final _back = BorrowedListBack();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return FutureBuilder(
        future: _back.list,
        builder: (context, result) {
          if (!result.hasData) {
            return const CircularProgressIndicator();
          }

          List<Borrowed> resultData = result.data;

          return ListView.builder(
            itemCount: resultData.length,
            itemBuilder: (ctx, i) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          ButtonEditIcon(
                            () => _back.goToForm(context, resultData[i]),
                          ),
                          ButtonDeleteIcon(
                            context,
                            () => _back.remove(resultData[i].id, context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _back.goToView(context, resultData[i]),
                  child: Tile(
                    title: resultData[i].book.title,
                    subtitle: resultData[i].book.author,
                    image: resultData[i].book.image,
                    infoLeft: Row(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          color: Constants.myBlack,
                        ),
                        Text(
                          resultData[i].name,
                          style: Constants.sdAuxMessages,
                        ),
                      ],
                    ),
                    infoRigth: Row(
                      children: [
                        const Text('Início: ', style: Constants.sdAuxMessages),
                        Text(
                            CommonService.formattedDate(
                                resultData[i].startDate),
                            style: Constants.sdAuxMessages),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
