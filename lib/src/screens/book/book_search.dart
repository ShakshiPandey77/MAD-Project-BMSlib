// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:bmslib/src/widgets/book_list.dart';
// import 'package:bmslib/src/models/notifiers/book_notifier.dart';
// import 'package:bmslib/src/models/book.dart';

// class BookSearch extends SearchDelegate<Book> {
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return Theme.of(context);
//   }

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         color: Theme.of(context).iconTheme.color,
//         onPressed: () => query = '',
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       color: Theme.of(context).iconTheme.color,
//       onPressed: () => Navigator.of(context).pop(),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final books = Provider.of<BookNotifier>(context).books;

//     final results = books
//         .where((book) =>
//             book.title.toLowerCase().contains(query) ||
//             book.author.toLowerCase().contains(query))
//         .toList();

//     return BookList(books: results);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final books = Provider.of<BookNotifier>(context).books;

//     final results = books
//         .where((book) =>
//             book.title.toLowerCase().contains(query) ||
//             book.author.toLowerCase().contains(query))
//         .toList();

//     return BookList(books: results);
//   }
// }
