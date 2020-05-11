import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference bookCollection =
      Firestore.instance.collection('books');

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String libid, String name, String email,
      String phone, int borrowed, List<Map<String, dynamic>> bag) async {
    return await userCollection.document(uid).setData({
      'libcard': libid,
      'name': name,
      'email': email,
      'phone': phone,
      'borrowed': borrowed,
      'bag': bag,
    });
  }

  // return specific data of current user
  Future<String> getData(String data) async {
    return await userCollection
        .document(uid)
        .get()
        .then((doc) => doc.data[data].toString());
  }

  // set specific data of current user
  Future<void> setUserData(String data, dynamic val) async {
    return await userCollection.document(uid).updateData({
      data: val,
    });
  }

  // return bag of current user
  Future<List<Map<String, dynamic>>> getBag() async {
    return await userCollection.document(uid).get().then((doc) {
      var bagList = doc.data['bag'].toList();
      List<Map<String, dynamic>> bag = List<Map<String, dynamic>>.from(bagList);
      return bag;
    });
  }

  // set bag of current user
  Future<void> setBag(List<Map<String, dynamic>> bag) async {
    return await userCollection.document(uid).updateData({
      'bag': bag,
    });
  }

  // get current user strean
  Stream<UserData> get user {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // get current user strean
  Stream<List<UserData>> get users {
    return userCollection.snapshots().map(_userListDataFromSnapshot);
  }

  List<UserData> _userListDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        uid: doc.documentID,
        libid: doc.data['libcard'] ?? '',
        name: doc.data['name'] ?? '',
        phone: doc.data['phone'] ?? '',
        email: doc.data['email'] ?? '',
        borrowed: doc.data['borrowed'] ?? 0,
        bag: List<Map<String, dynamic>>.from(doc.data['bag']) ?? [],
      );
    }).toList();
  }

  // return current user data
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.documentID,
      libid: snapshot.data['libcard'] ?? '',
      name: snapshot.data['name'] ?? '',
      phone: snapshot.data['phone'] ?? '',
      email: snapshot.data['email'] ?? '',
      borrowed: snapshot.data['borrowed'] ?? 0,
      bag: snapshot.data['bag'] ?? [],
    );
  }

  // return issuers of current book
  Future<List<Map<String, dynamic>>> getIssuers(String bookID) async {
    return await bookCollection.document(bookID).get().then((doc) {
      var issuerList = doc.data['issuers'].toList();
      List<Map<String, dynamic>> issuers =
          List<Map<String, dynamic>>.from(issuerList);
      return issuers;
    }).catchError((e) {
      print(e.toString());
      return null;
    });
  }

  // set issuers of current book
  Future<void> setIssuers(
      String bookID, List<Map<String, dynamic>> issuers) async {
    return await bookCollection.document(bookID).updateData({
      'issuers': issuers,
    });
  }

  // set data of current book
  Future<void> setBookData(String bookID, String data, dynamic val) async {
    return await bookCollection.document(bookID).updateData({
      data: val,
    });
  }

  Future<void> updateBookData(Book book) async {
    return await bookCollection.document(book.uid).setData({
      'title': book.title,
      'author': book.author,
      'cover': book.coverUrl,
      'category': book.category,
      'edition': book.edition,
      'publisher': book.publisher,
      'copies': book.copies,
      'rating': book.rating,
      'searchKey': book.searchKey,
      'issuers': book.issuers,
    });
  }

  Future<void> deleteBookData(String bookID) async {
    return await bookCollection.document(bookID).delete();
  }

  // get books stream
  Stream<List<Book>> get books {
    return bookCollection.snapshots().map(_bookListFromSnapshot);
  }

  // book list from snapshot
  List<Book> _bookListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Book(
        uid: doc.documentID ?? '',
        title: doc.data['title'] ?? '',
        author: doc.data['author'] ?? '',
        coverUrl: doc.data['cover'] ?? '',
        category: doc.data['category'] ?? '',
        edition: doc.data['edition'] ?? 0,
        publisher: doc.data['publisher'] ?? '',
        copies: doc.data['copies'] ?? 0,
        rating: doc.data['rating'] ?? 0,
        searchKey: doc.data['searchKey'] ?? '',
        issuers: List<Map<String, dynamic>>.from(doc.data['issuers']) ?? [],
      );
    }).toList();
  }
}
