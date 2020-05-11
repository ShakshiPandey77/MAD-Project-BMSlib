class User {
  final String uid;
  final String username;
  final String email;
  final bool isAdmin;

  const User({
    this.uid,
    this.username,
    this.email,
    this.isAdmin,
  });
}

class UserData {
  final String uid; //user id in database
  final String libid; //library card number
  final String name; // user name
  final String email; // user email
  final String phone; // user phone number
  final int borrowed; // number of borrowed books
  final List<Map<String, dynamic>> bag; // user's bag

  const UserData({
    this.uid,
    this.libid,
    this.name,
    this.email,
    this.phone,
    this.borrowed,
    this.bag,
  });
}

class Bag {
  final String bookID; // id of the borrowed book
  final String bookTitle; // title of the book
  final String issueDate; // date of issue
  final String returnDate; // date of return is 3 days later
  final double fine;

  Bag(
    this.bookID,
    this.bookTitle,
    this.issueDate,
    this.fine,
  ) : returnDate =
            DateTime.parse(issueDate).add(new Duration(days: 3)).toString();

  // converts a bag object to a map
  Map<String, dynamic> toMap() {
    return {
      'bookID': bookID,
      'bookTitle': bookTitle,
      'issueDate': issueDate.toString(),
      'returnDate': returnDate.toString(),
      'fine': fine,
    };
  }

  // converts a map to a bag object
  static Bag fromMap(Map<String, dynamic> bagMap) {
    return Bag(
      bagMap['bookID'],
      bagMap['bookTitle'],
      bagMap['issueDate'],
      bagMap['fine'],
    );
  }
}
