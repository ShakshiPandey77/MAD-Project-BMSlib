import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/services/auth.dart';
import 'package:bmslib/src/screens/book/book_add.dart';
import 'package:bmslib/src/services/database.dart';
import 'package:bmslib/src/theme/colors.dart';
import 'package:bmslib/src/screens/home/book_cover.dart';
import 'package:bmslib/src/widgets/error.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/widgets/star_rating.dart';

class BookDetails extends StatelessWidget {
  final Book _book;

  BookDetails(Book book) : _book = book;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return FutureBuilder<User>(
        future: AuthService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Error(text: "An unexpected error has occurred :(");
          }

          return Scaffold(
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: BookCover(
                        url: _book.coverUrl,
                        boxFit: BoxFit.fitHeight,
                        height: 350,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 4.0),
                      child: Text(
                        '${_book.title} \n${_book.edition} Edition',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By ',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            TextSpan(
                              text: '${_book.author}',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            TextSpan(
                              text: '\nPublished by ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: '${_book.publisher}',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category : ',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            TextSpan(
                              text: '${_book.category}',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    StarRating(
                      starCount: 5,
                      rating: (_book.rating).toDouble(),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      height: 38.0,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: SpeedDial(
              overlayOpacity: 0.25,
              overlayColor:
                  themeNotifier.darkModeEnabled ? Colors.black : Colors.white,
              animatedIcon: AnimatedIcons.list_view,
              children: snapshot.data.isAdmin
                  ? [
                      _buildSubFab('Delete Book', Icons.delete,
                          () => _showDeleteDialog(context)),
                      _buildSubFab(
                          "Edit Details",
                          Icons.edit,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BookAdd(book: _book)))),
                      _buildSubFab("View Issuers", Icons.people, () => null),
                      (_book.copies > 0)
                          ? _buildSubFab(
                              "Add to Bag",
                              Icons.collections_bookmark,
                              () => Fluttertoast.showToast(
                                    msg: "Added to Bag",
                                  ))
                          : _buildSubFab(
                              "Unavailable", Icons.cancel, () => null),
                    ]
                  : [
                      (_book.copies > 0)
                          ? _buildSubFab(
                              "Add to Bag",
                              Icons.collections_bookmark,
                              () => Fluttertoast.showToast(
                                    msg: "Added to Bag",
                                  ))
                          : _buildSubFab(
                              "Unavailable", Icons.cancel, () => null),
                    ],
              // children: [
              //   _buildSubFab('Remove', Icons.delete,
              //       () => _showDeleteDialog(context, bookNotifier)),
              //   _buildSubFab(
              //       'Edit',
              //       Icons.edit,
              //       () => Navigator.push(context,
              //           MaterialPageRoute(builder: (_) => BookAdd(book: _book)))),
              //   _buildSubFab(
              //       'Add',
              //       Icons.add,
              //       () => Navigator.push(
              //           context, MaterialPageRoute(builder: (_) => BookAdd())))
              // ],
            ),
          );
        });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Details'),
    );
  }

  SpeedDialChild _buildSubFab(String label, IconData iconData, Function onTap) {
    return SpeedDialChild(
      label: label,
      labelStyle: TextStyle(color: kTextTitleColor),
      child: Icon(iconData),
      onTap: onTap,
    );
  }

  void _showDeleteDialog(BuildContext context) async {
    final dialog = AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Delete book?'),
      content: Text(
        'This will delete the book from the database',
        style: TextStyle(color: Theme.of(context).textTheme.caption.color),
      ),
      actions: [
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(
              color: Theme.of(context).buttonColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(
            'DELETE',
            style: TextStyle(
              //color: Theme.of(context).buttonColor,
              color: Colors.redAccent,
            ),
          ),
          onPressed: () async {
            // function to delete book from database
            await DatabaseService().deleteBookData(_book.uid).then((_) {
              Fluttertoast.showToast(
                  msg: "Deleted successfully", toastLength: Toast.LENGTH_LONG);
              // Pop details screen
              Navigator.of(context).pop();
            }).catchError((error) {
              Fluttertoast.showToast(
                  msg: "Couldn't delete :(", toastLength: Toast.LENGTH_LONG);
              // Pop details screen
              Navigator.of(context).pop();
            });
            Loading();
          },
        ),
      ],
    );

    await showDialog(context: context, builder: (context) => dialog);
  }
}
