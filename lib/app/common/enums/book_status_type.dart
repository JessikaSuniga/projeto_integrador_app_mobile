enum BookStatusType {
  read,
  notRead,
  reading,
}

extension BookStatusTypeDescription on BookStatusType {
  // ignore: missing_return
  String get description {
    switch (this) {
      case BookStatusType.read:
        return 'Lido';
      case BookStatusType.notRead:
        return 'Não lido';
      case BookStatusType.reading:
        return 'Lendo';
    }
  }

  // ignore: missing_return
  String get cod {
    switch (this) {
      case BookStatusType.read:
        return 'read';
      case BookStatusType.notRead:
        return 'notRead';
      case BookStatusType.reading:
        return 'reading';
    }
  }
}
