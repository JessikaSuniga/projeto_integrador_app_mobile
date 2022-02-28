import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/enums/navigations_types.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/book/list/book_list.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/list/borrowed_list.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/list/desire_list.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/list/shelf_list.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/list/shelf_list_back.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _indexTop;
  int _indexBottom;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: NavigationTop.values.length,
      initialIndex: NavigationTop.book.index,
      vsync: this,
    );

    _indexTop = NavigationTop.book.index;
    _indexBottom = NavigationBottom.book.index;
  }

  void _onSetStateTop(int index) {
    setState(() {
      _indexTop = index;
    });
  }

  void _onSetStateBottom(int index) {
    setState(() {
      _indexBottom = index;
    });
  }

  void _onTabTop(int indexTop) {
    _onSetStateTop(indexTop);

    switch (NavigationTop.values[indexTop]) {
      case NavigationTop.book:
        _onSetStateBottom(NavigationBottom.book.index);
        break;
      case NavigationTop.shelf:
      case NavigationTop.borrowed:
        _onSetStateBottom(NavigationBottom.add.index);
        break;
      case NavigationTop.desire:
        _onSetStateBottom(NavigationBottom.desire.index);
        break;
      default:
        return;
    }
  }

  void _onTabBottom(BuildContext context, int indexBottom) {
    if (indexBottom == NavigationBottom.book.index) {
      _onSetStateTop(NavigationTop.book.index);
      _onSetStateBottom(indexBottom);
      _controller.index = NavigationTop.book.index;
      return;
    }

    if (indexBottom == NavigationBottom.desire.index) {
      _onSetStateTop(NavigationTop.desire.index);
      _onSetStateBottom(indexBottom);
      _controller.index = NavigationTop.desire.index;
      return;
    }

    if (indexBottom == NavigationBottom.add.index) {
      switch (NavigationTop.values[_indexTop]) {
        case NavigationTop.book:
          Navigator.of(context).pushNamed(Routes.BOOK_FORM);
          return;
        // case NavigationTop.shelf:
        //   var back = ShelfListBack();
        //   back.dispacheDialogSave(context);
        //   // Navigator.of(context).pushNamed(Routes.SHELF_TO_BOOK_LIST);
        //   return;
        case NavigationTop.borrowed:
          Navigator.of(context).pushNamed(Routes.BORROWED_FORM);
          return;
        case NavigationTop.desire:
          Navigator.of(context).pushNamed(Routes.DESIRE_FORM);
          return;
        default:
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        title: const Text(
          'Folha Amarela',
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu),
        //     color: Constants.myOrange,
        //     onPressed: () {},
        //   ),
        // ],
        bottom: TabBar(
          isScrollable: true,
          onTap: _onTabTop,
          controller: _controller,
          tabs: const <Widget>[
            Tab(text: "Livro"),
            Tab(text: "Estante"),
            Tab(text: "Emprestado"),
            Tab(text: "Desejo"),
          ],
          labelColor: Constants.myOrange,
          unselectedLabelColor: Constants.myBlack,
          labelStyle: const TextStyle(fontSize: 18),
          unselectedLabelStyle: const TextStyle(fontSize: 18),
          indicatorColor: Constants.myOrange,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          BookList(),
          ShelfList(),
          BorrowedList(),
          DesireList(),
        ],
      ),
      bottomNavigationBar: _indexTop != NavigationTop.shelf.index
        ? BottomNavigationBar(
          backgroundColor: Constants.bgColorLigth,
          currentIndex: _indexBottom,
          onTap: (int i) => _onTabBottom(context, i),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined, color: Constants.icColorLigth),
              activeIcon: Icon(Icons.book, color: Constants.icColorPressLigth),
              tooltip: 'Livro',
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, color: Constants.icColorLigth),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline, color: Constants.icColorLigth),
              activeIcon:
                  Icon(Icons.favorite, color: Constants.icColorPressLigth),
              tooltip: 'Desejo',
              label: '',
            ),
          ],
        )
        : null,
    );
  }
}
