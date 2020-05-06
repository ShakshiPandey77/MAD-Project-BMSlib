// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:bmslib/src/models/book.dart';
// import 'package:bmslib/src/screens/book/book_details.dart';
// import 'package:bmslib/src/models/notifiers/book_notifier.dart';
// import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
// import 'package:bmslib/src/screens/book/book_add.dart';
// import 'package:bmslib/src/widgets/book_list.dart';
// import 'package:bmslib/src/style.dart';
// import 'package:bmslib/src/widgets/appbar/appbar.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var themeNotifier = Provider.of<ThemeNotifier>(context);
//     var bookNotifier = Provider.of<BookNotifier>(context);
// FIXME: Want to set wideScreen here but it can't be null
// Don't know why it is not possible to initialize it here

//   return Scaffold(
//     appBar: CustomAppBar(),
//     body: Container(
//       child: MediaQuery.of(context).size.width > wideLayoutThreshold
//           ? Row(
//               children: <Widget>[
//                 Flexible(
//                   flex: 4,
//                   child: BookList(),
//                 ),
//                 Flexible(
//                   flex: 6,
//                   child: BookDetails(
//                       bookNotifier.books[bookNotifier.selectedIndex]),
//                 ),
//               ],
//             )
//           : BookList(),
//     ),
//     floatingActionButton:
//         MediaQuery.of(context).size.width < wideLayoutThreshold
//             ? FloatingActionButton(
//                 child: Icon(Icons.add),
//                 onPressed: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (_) => BookAdd()));
//                 },
//               )
//             : Container(),
//   );
// }

// AppBar _buildAppBar(BuildContext context, ThemeNotifier themeNotifier) {
//   return AppBar(
//     title: Text('BMS Lib'),
//     actions: [
//       IconButton(
//         icon: themeNotifier.darkModeEnabled
//             ? Icon(Icons.brightness_7)
//             : Icon(Icons.brightness_2),
//         color: Theme.of(context).iconTheme.color,
//         onPressed: () => themeNotifier.toggleTheme(),
//       ),
//       IconButton(
//         icon: Icon(Icons.search),
//         onPressed: () {
//           showSearch(context: context, delegate: BookSearch());
//         },
//       ),
//     ],
//   );
// }
//}

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

import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
import 'package:bmslib/src/screens/home/book_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

//import 'package:bmslib/src/screens/book/book_details.dart';
//import 'package:bmslib/src/models/notifiers/book_notifier.dart';
//import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
//import 'package:bmslib/src/screens/book/book_add.dart';
//import 'package:bmslib/src/widgets/book_list.dart';
//import 'package:bmslib/src/widgets/appbar/appbar.dart';
import 'package:bmslib/src/widgets/drawer/issuer_drawer.dart';
import 'package:bmslib/src/screens/notification/notification.dart';
import 'package:bmslib/src/enums/book_category.dart';
//import 'package:bmslib/src/screens/home/book_tile.dart';
//import 'package:bmslib/src/style.dart';
//import 'package:bmslib/src/services/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(length: bookCategory.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final bookList = Provider.of<List<Book>>(context);
    //bookList.forEach((book) => print(book.title));
    //var bookNotifier = Provider.of<BookNotifier>(context);
    // FIXME: Want to set wideScreen here but it can't be null
    // Don't know why it is not possible to initialize it here

    // Column _buildBookList(List<Book> bookList) {
    //   return Column(
    //     children: <Widget>[
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: bookList.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return BookTile(
    //               book: bookList[index],
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('BMSLib'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: null /*BookSearch()*/);
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotification(),
                ),
              );
            },
          ),
          IconButton(
            icon: themeNotifier.darkModeEnabled
                ? Icon(Icons.brightness_7)
                : Icon(Icons.brightness_2),
            color: Theme.of(context).iconTheme.color,
            onPressed: () => themeNotifier.toggleTheme(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          isScrollable: true,
          tabs: List<Widget>.generate(bookCategory.length, (int index) {
            return Tab(
              text: bookCategory[index],
            );
          }),
        ),
      ),
      drawer: IssuerDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          children: List<Widget>.generate(bookCategory.length, (int index) {
            if (bookList == null) {
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: SpinKitWave(
                    color: Colors.blue[800],
                  ),
                ),
              );
            } else {
              return BookList(
                  books: bookList
                      .where((book) => book.category == bookCategory[index])
                      .toList());
            }
          }),
        ),
      ),
      // floatingActionButton: MediaQuery.of(context).size.width <
      //         wideLayoutThreshold
      //     ? FloatingActionButton(
      //         child: Icon(Icons.add),
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (_) => null /*BookAdd()*/));
      //         },
      //       )
      //     : Container(),
    );
  }
}
