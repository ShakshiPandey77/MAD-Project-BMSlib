class Book {
  final String uid; // barcode of the book
  final String title; // title of book
  final String author; // author(s) of book
  final String publisher; // publisher of book
  final String coverUrl; // cover page of the book
  final String category; // category of the book
  final String searchKey; // searchKey of the book
  num rating; // rating of the book
  num copies; // available copies of the book
  num edition; // edition of the book

  Book(
    this.uid,
    this.title,
    this.author,
    this.coverUrl,
    this.category,
    this.rating,
    this.publisher,
    this.searchKey,
  );
}
