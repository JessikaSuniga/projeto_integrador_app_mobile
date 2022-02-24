// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/enums/book_format_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_language_type.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/domain/models/book_to_genre.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class DesireView extends StatelessWidget {
  const DesireView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = DesireFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Constants.bgColorLigth,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Visualizar desejo",
            style: TextStyle(color: Constants.myOrange),
          ),
          backgroundColor: Constants.headerColorLigth,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Constants.myOrange,
              onPressed: () => _back.goToForm(context, _back.book),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Scroll(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: _back.book.image != null
                              ? Utility.imageFromBase64String(_back.book.image)
                              : Image.asset(ConstantAssets.imgDefault),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                _back.book.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(_back.book.author),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "ISBN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(_back.book.isbn),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gênero",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                FutureBuilder(
                                  future: _back.findAllByBookId(_back.book.id),
                                  builder: (context, result) {
                                    if (!result.hasData) {
                                      return const CircularProgressIndicator();
                                    }
                                    List<BookToGenre> resultData = result.data;

                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: resultData.isNotEmpty
                                          ? resultData
                                              .map(
                                                (e) => Text(e.genre.name),
                                              )
                                              .toList()
                                          : [Text("-")],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Editora",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(_back.book.publishingCompany),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Formato",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(_back.book.format.description),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Páginas",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(_back.book.pages.toString()),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Idioma",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(_back.book.language.description),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Publicação",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(CommonService.formattedDate(
                                    _back.book.publicationDate)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}