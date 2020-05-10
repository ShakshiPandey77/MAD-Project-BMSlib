import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/screens/home/book_cover.dart';
import 'package:bmslib/src/widgets/star_rating.dart';
import 'package:bmslib/src/screens/book/book_details.dart';
//import 'package:bmslib/src/style.dart';

class BookTile extends StatelessWidget {
  final Book _book;

  BookTile(this._book);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BookDetails(_book)));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: BookCover(url: _book.coverUrl),
            ),
            Flexible(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 4.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20.0, 18.0, 0.0, 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${_book.title} ${_book.edition} Edition',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'By ${_book.author}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                    StarRating(
                      starCount: 5,
                      rating: (_book.rating).toDouble(),
                    ),
                    Text(
                      '${_book.category}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
