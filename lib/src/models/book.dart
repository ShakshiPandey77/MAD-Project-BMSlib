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
  List issuers;

  Book({
    this.uid,
    this.title,
    this.author,
    this.coverUrl,
    this.category,
    this.edition,
    this.publisher,
    this.copies,
    this.rating,
    this.searchKey,
    this.issuers,
  });
}

class Issuers {
  final String issuerLibID; // id of the borrowed book
  final DateTime issueDate; // date of issue
  final DateTime returnDate; // date of return is 3 days later
  final double fine;

  Issuers(
    this.issuerLibID,
    this.issueDate,
    this.fine,
  ) : returnDate = issueDate.add(new Duration(days: 3));
}
