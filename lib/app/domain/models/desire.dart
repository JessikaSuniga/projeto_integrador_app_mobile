class Desire {
  int id;
  String title;
  String author;
  String publishingCompany;
  String isbn;
  int format;
  DateTime publication;
  int pages;
  String language;

  Desire({
    this.id,
    this.title,
    this.author,
    this.publishingCompany,
    this.isbn,
    this.format,
    this.publication,
    this.pages,
    this.language,
  });

  Desire.fromMap(dynamic obj) {
    id = obj['desire_id'];
    title = obj['title'];
    author = obj['author'];
    publishingCompany = obj['publishingCompany'];
    isbn = obj['isbn'];
    format = obj['format'];
    publication = obj['publication'];
    pages = obj['pages'];
    language = obj['language'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'author': author,
      'publishingCompany': publishingCompany,
      'isbn': isbn,
      'format': format,
      'publication': publication,
      'pages': pages,
      'language': language,
    };

    return map;
  }
}
