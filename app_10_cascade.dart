class Book {
  int? pagesCount;
  String? title;
  int? publishYear;
  String? auther;

  void setPagesCount(int pagesCount) {
    this.pagesCount = pagesCount;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setPublishYear(int publishYear) {
    this.publishYear = publishYear;
  }

  void setAuther(String auther) {
    this.auther = auther;
  }
}

void main() {
  Book b1 = Book();
  b1.setAuther("auther");
  b1.setPagesCount(150);
  b1.setPublishYear(2001);
  b1.setTitle("blabla");

  b1..setAuther("auther")
    ..setPagesCount(50)
    ..setTitle("title")
    ..setPublishYear(2001);


  Book? b2 = getBookFromServer();
  if (b2 != null) {
    b2.setAuther("auther");
    b2.setPagesCount(150);
    b2.setPublishYear(2001);
    b2.setTitle("blabla");
  }
  
    b2?.setAuther("auther");
    b2?.setPagesCount(150);
    b2?.setPublishYear(2001);
    b2?.setTitle("blabla");

  b2 ?..setAuther("auther")
    ..setPagesCount(50)
    ..title ="title"
    ..setPublishYear(2001);
}

Book? getBookFromServer() {
  //simulate backend reterival
  return Book();
}
