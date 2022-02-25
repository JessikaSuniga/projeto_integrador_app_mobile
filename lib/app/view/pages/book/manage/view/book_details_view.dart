import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/enums/book_format_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_language_type.dart';
import 'package:projeto_integrador_app/app/domain/models/book_to_genre.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class BookDetaisView extends StatefulWidget {
  final BookFormBack back;

  const BookDetaisView({Key key, this.back}) : super(key: key);

  @override
  _BookDetaisViewState createState() => _BookDetaisViewState();
}

class _BookDetaisViewState extends State<BookDetaisView> {
  // String _validationIsNullOrEmpty(value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Informe um valor válido';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _descriptionInfo,
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _genresInfo,
                      _publishingCompanyInfo,
                      _formatInfo,
                      _publicationDateInfo,
                      _serieInfo,
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _pagesInfo,
                        _languageInfo,
                        _volumeInfo,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get _descriptionInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Descrição:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.description),
        ],
      ),
    );
  }

  Widget get _genresInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gênero",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          FutureBuilder(
            future: widget.back.findAllByBookId(widget.back.book.id),
            builder: (context, result) {
              if (!result.hasData) {
                return const CircularProgressIndicator();
              }
              List<BookToGenre> resultData = result.data;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: resultData.isNotEmpty
                    ? resultData
                        .map(
                          (e) => Text(e.genre.name),
                        )
                        .toList()
                    : [const Text("-")],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get _publishingCompanyInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Editora",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.publishingCompany),
        ],
      ),
    );
  }

  Widget get _serieInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Série",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.serie),
        ],
      ),
    );
  }

  Widget get _formatInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Formato",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.format.description),
        ],
      ),
    );
  }

  Widget get _pagesInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Páginas",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.pages.toString()),
        ],
      ),
    );
  }

  Widget get _volumeInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Volume",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.volume.toString()),
        ],
      ),
    );
  }

  Widget get _languageInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Idioma",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(widget.back.book.language.description),
        ],
      ),
    );
  }

  Widget get _publicationDateInfo {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Publicação",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(CommonService.formattedDate(widget.back.book.publicationDate)),
        ],
      ),
    );
  }
}