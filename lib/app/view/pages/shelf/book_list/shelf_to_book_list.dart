import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/components/tile.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/book_list/shelf_to_book_list_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class ShelfToBookList extends StatelessWidget {
  const ShelfToBookList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final _back = ShelfToBookListBack(context);

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.shelf.name,
          style: const TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
      ),
      body: Form(
        key: formKey,
        child: Observer(
          builder: (context) {
            return FutureBuilder(
              future: _back.list,
              builder: (_, result) {
                if (!result.hasData) {
                  return const CircularProgressIndicator();
                }

                List<ShelfToBook> resultData = result.data;

                return ListView.builder(
                  itemCount: resultData.length,
                  itemBuilder: (ctx, i) {
                    return Slidable(
                      key: const ValueKey(0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(ctx).pushNamed(
                          Routes.BOOK_VIEW,
                          arguments: resultData[i].book,
                        ),
                        child: Tile(
                          image: resultData[i].book.image,
                          title: resultData[i].book.title,
                          subtitle: resultData[i].book.author,
                          infoLeft: Row(
                            children: [
                              const Icon(
                                Icons.library_books,
                                color: Constants.myOrange,
                              ),
                              Text(
                                resultData[i].book.pages.toString(),
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
                                    resultData[i].book.publicationDate),
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<ShelfToBook> list;
          _back.list.then((value) => list = value);

          showDialog(
            context: context,
            builder: (ctx) {
              return FutureBuilder(
                future: _back.findAllBook(),
                builder: (_, result) {
                  if (!result.hasData) {
                    return const CircularProgressIndicator();
                  }

                  List<Book> resultData = result.data;

                  return MultiSelectDialog(
                    items: resultData
                        .map((e) => MultiSelectItem(e.id, e.title))
                        .toList(),
                    initialValue: list.map((e) => e.bookId).toList(),
                    onConfirm: (values) {
                      _back.save(ctx, values);
                    },
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Constants.myOrange,
        mini: true,
      ),
    );
  }
}
