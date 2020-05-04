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
      String phone, int borrowed, List<Bag> bag) async {
    return await userCollection.document(uid).setData({
      'libcard': libid,
      'name': name,
      'email': email,
      'phone': phone,
      'borrowed': borrowed,
      'bag': bag,
    });
  }

  // return library card number of current user
  Future<String> getData(String data) async {
    return await userCollection
        .document(uid)
        .get()
        .then((doc) => doc.data[data].toString());
  }

  // get current user strean
  Stream<UserData> get user {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // return current user data
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.documentID,
      libid: snapshot.data['libid'] ?? '',
      name: snapshot.data['name'] ?? '',
      phone: snapshot.data['phone'] ?? '',
      email: snapshot.data['email'] ?? '',
      borrowed: snapshot.data['borrowed'] ?? 0,
      bag: snapshot.data['bag'] ?? [],
    );
  }

  Future<void> updateBookData(String barcode, int edition, int copies,
      double rating, String coverUrl) async {
    return await bookCollection.document(barcode).setData({
      'edition': edition,
      'copies': copies,
      'rating': rating,
      'cover': coverUrl,
    });
  }

  // get books stream
  Stream<List<Book>> get books {
    return bookCollection.snapshots().map(_bookListFromSnapshot);
  }

  // book list from snapshot
  List<Book> _bookListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Book(
        uid: doc.documentID,
        title: doc.data['title'] ?? '',
        author: doc.data['author'] ?? '',
        coverUrl: doc.data['cover'] ?? '',
        category: doc.data['category'] ?? '',
        edition: doc.data['edition'] ?? 0,
        publisher: doc.data['publisher'] ?? '',
        copies: doc.data['copies'] ?? 0,
        rating: doc.data['rating'] ?? 0,
        searchKey: doc.data['searchKey'] ?? '',
      );
    }).toList();
  }
}
