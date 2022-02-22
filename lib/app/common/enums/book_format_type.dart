enum BookFormatType { paperback, hardCover, pocketBook, ebook }

extension BookFormatTypeDescription on BookFormatType {
  // ignore: missing_return
  String get description {
    switch (this) {
      case BookFormatType.paperback:
        return 'Capa comum';
      case BookFormatType.hardCover:
        return 'Capa dura';
      case BookFormatType.pocketBook:
        return 'Livro de bolso';
      case BookFormatType.ebook:
        return 'Ebook';
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case BookFormatType.paperback:
        return 'paperback';
      case BookFormatType.hardCover:
        return 'hardCover';
      case BookFormatType.pocketBook:
        return 'pocketBook';
      case BookFormatType.ebook:
        return 'ebook';
    }
  }
}
