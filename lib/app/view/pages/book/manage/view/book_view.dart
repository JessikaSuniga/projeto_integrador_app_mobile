// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_details_view.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_notes_view.dart';

class BookView extends StatefulWidget {
  const BookView({Key key}) : super(key: key);

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final back = BookFormBack(context);

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Visualizar livro",
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Constants.myOrange,
            onPressed: () => back.goToForm(context, back.book),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2),
                      ),
                      child: back.book.image != null
                          ? Utility.imageFromBase64String(back.book.image)
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
                            back.book.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(back.book.author),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "ISBN",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(back.book.isbn),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _controller,
              tabs: const <Widget>[
                Tab(text: "Informações"),
                Tab(text: "Notas"),
              ],
              labelColor: Constants.myOrange,
              unselectedLabelColor: Constants.myBlack,
              labelStyle: const TextStyle(fontSize: 18),
              unselectedLabelStyle: const TextStyle(fontSize: 18),
              indicatorColor: Constants.myOrange,
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  BookDetaisView(back: back),
                  BookNotesView(back: back),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}