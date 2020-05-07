import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
//import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/screens/home/book_list.dart';
import 'package:bmslib/src/services/auth.dart';
import 'package:bmslib/src/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:bmslib/src/widgets/drawer/issuer_drawer.dart';
import 'package:bmslib/src/widgets/drawer/admin_drawer.dart';
import 'package:bmslib/src/screens/notification/notification.dart';
import 'package:bmslib/src/enums/book_category.dart';

class HomeScreen extends StatelessWidget {
  final currentUser = AuthService().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    bool isAdmin;
    currentUser.then((user) {
      isAdmin = user.isAdmin;
    });
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final bookList = Provider.of<List<Book>>(context);

    return DefaultTabController(
      length: bookCategory.length,
      child: Scaffold(
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
        drawer: isAdmin ? AdminDrawer() : IssuerDrawer(),
        body: (bookList == null)
            ? emptyWidget("An error has occurred ! Please restart the app")
            : (bookList.isEmpty)
                ? Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: SpinKitWave(
                        color: Colors.blue[800],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(
                      physics: ScrollPhysics(),
                      children: List<Widget>.generate(bookCategory.length,
                          (int index) {
                        return BookList(
                            books: bookList
                                .where((book) =>
                                    book.category == bookCategory[index])
                                .toList());
                      }),
                    ),
                  ),
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => null /*BookAdd()*/));
                },
              )
            : Container(),
      ),
    );
  }
}
