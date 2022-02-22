import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/view/components/button_delete_icon.dart';
import 'package:projeto_integrador_app/app/view/components/button_edit_icon.dart';
import 'package:projeto_integrador_app/app/view/components/my_divider.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/list/shelf_list_back.dart';

class ShelfList extends StatelessWidget {
  ShelfList({Key key}) : super(key: key);

  final _back = ShelfListBack();

  dynamic _imageBook(List<ShelfToBook> books) {
    var uri = books.isNotEmpty ? books[0].book.image : null;

    if (uri != null) {
      return CircleAvatar(
          backgroundImage: Utility.imageFromBase64String(uri).image);
    }
    return const CircleAvatar(child: Icon(Icons.menu_book));
  }

  Text _createTextAux(int length) {
    var myString = ' (' + length.toString() + ') ';

    return Text(myString, style: const TextStyle(color: Constants.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return FutureBuilder(
        future: _back.list,
        builder: (context, result) {
          if (!result.hasData) {
            return const CircularProgressIndicator();
          }

          List<Shelf> resultData = result.data;

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
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          bottom: 0, left: 15, right: 15, top: 10),
                      leading: _imageBook(resultData[i].books),
                      title: Row(
                        children: [
                          Text(resultData[i].name,
                              style: Constants.sdListTitle),
                          _createTextAux(resultData[i].books.length),
                        ],
                      ),
                    ),
                    const MyDivider(),
                  ],
                ),
              );
            },
          );
        },
      );
    });
  }
}
