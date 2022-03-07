enum SortFilterAvancedType {
  title,
  author,
  publishingCompany,
}

extension SortFilterAvancedTypeDescription on SortFilterAvancedType {
  // ignore: missing_return
  String get description {
    switch (this) {
      case SortFilterAvancedType.title:
        return 'Título';
      case SortFilterAvancedType.author:
        return 'Autor';
      case SortFilterAvancedType.publishingCompany:
        return 'Editora';
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case SortFilterAvancedType.title:
        return 'title';
      case SortFilterAvancedType.author:
        return 'author';
      case SortFilterAvancedType.publishingCompany:
        return 'publishingCompany';
    }
  }
}
