enum BookItemType { bought, desire }

extension BookItemTypeDescription on BookItemType {
  // ignore: missing_return
  String get description {
    switch (this) {
      case BookItemType.bought:
        return 'Comprado';
      case BookItemType.desire:
        return 'Desejo';
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case BookItemType.bought:
        return 'bought';
      case BookItemType.desire:
        return 'desire';
    }
  }
}
