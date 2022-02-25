import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/view/components/button_delete_icon.dart';
import 'package:projeto_integrador_app/app/view/components/button_edit_icon.dart';
import 'package:projeto_integrador_app/app/view/components/tile.dart';
import 'package:projeto_integrador_app/app/view/pages/book/list/book_list_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class BookList extends StatelessWidget {
  BookList({Key key}) : super(key: key);

  final _back = BookListBack();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return FutureBuilder(
        future: _back.list,
        builder: (context, result) {
          if (!result.hasData) {
            return const CircularProgressIndicator();
          }

          List<Book> resultData = result.data;

          return ListView.builder(
            itemCount: resultData.length,
            itemBuilder: (ctx, i) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    ButtonEditIcon(
                        () => _back.goToForm(context, resultData[i])),
                    ButtonDeleteIcon(
                        context, () => _back.remove(resultData[i].id, context)),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => _back.goToView(context, resultData[i]),
                  child: Tile(
                    image: resultData[i].image,
                    title: resultData[i].title,
                    subtitle: resultData[i].author,
                    infoLeft: Row(
                      children: [
                        const Icon(
                          Icons.library_books,
                          color: Constants.myOrange,
                        ),
                        Text(
                          resultData[i].pages.toString(),
                          style: Constants.sdAuxMessages,
                        ),
                      ],
                    ),
                    infoRigth: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: Constants.myOrange,
                        ),
                        Text(
                          CommonService.formattedDate(
                              resultData[i].publicationDate),
                          style: Constants.sdAuxMessages,
                        ),
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
