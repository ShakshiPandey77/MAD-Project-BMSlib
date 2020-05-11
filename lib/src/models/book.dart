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
  List<Map<String, dynamic>> issuers;

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
  final String issueDate; // date of issue
  final String returnDate; // date of return is 3 days later
  final double fine;

  Issuers(
    this.issuerLibID,
    this.issueDate,
    this.fine,
  ) : returnDate =
            DateTime.parse(issueDate).add(new Duration(days: 3)).toString();

  // converts an issuer object to a map
  Map<String, dynamic> toMap() {
    return {
      'issuerLibID': issuerLibID,
      'issueDate': issueDate.toString(),
      'returnDate': returnDate.toString(),
      'fine': fine,
    };
  }

  // converts a map to an issuer object
  static Issuers fromMap(Map<String, dynamic> issuerMap) {
    return Issuers(
      issuerMap['issuerLibID'],
      issuerMap['issueDate'],
      issuerMap['fine'],
    );
  }
}
