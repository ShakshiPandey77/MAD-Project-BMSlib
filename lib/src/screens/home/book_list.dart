import 'package:bmslib/src/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/screens/home/book_tile.dart';

class BookList extends StatelessWidget {
  final List<Book> _books;

  BookList({books}) : _books = books;

  @override
  Widget build(BuildContext context) {
    return (_books.length == 0)
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
                  itemCount: _books?.length,
                  itemBuilder: ((context, index) {
                    return BookTile(_books?.elementAt(index));
                  }),
                ),
              ),
            ],
          )
        : emptyWidget();
  }
}
