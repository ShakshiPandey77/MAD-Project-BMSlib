import 'package:bmslib/src/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/screens/home/book_tile.dart';

class BookList extends StatefulWidget {
  final List<Book> _books;

  BookList({books}) : _books = books;

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return (widget._books.length > 0)
        ? Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: ((context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Divider(
                        color: Colors.grey.withOpacity(0.3),
                        height: 18.0,
                      ),
                    );
                  }),
                  itemCount: widget._books?.length,
                  itemBuilder: ((context, index) {
                    return BookTile(widget._books?.elementAt(index));
                  }),
                ),
              ),
            ],
          )
        : emptyWidget("Nothing to see here");
  }
}
