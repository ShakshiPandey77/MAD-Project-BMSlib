//import 'package:barcode_scan/barcode_scan.dart';
import 'package:bmslib/src/services/database.dart';
import 'package:bmslib/src/widgets/loading/loading.dart';
import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/widgets/buttons/confirm_button.dart';
import 'package:bmslib/src/widgets/inputs/book_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bmslib/src/enums/book_category.dart';

class BookAdd extends StatelessWidget {
  // adds or edits book details
  final Book book;

  BookAdd({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title == null ? 'Add Book' : 'Update Book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: AddBookForm(book: book),
        ),
      ),
    );
  }
}

class AddBookForm extends StatefulWidget {
  final Book book;

  AddBookForm({this.book});

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading;

  String _barcode;
  String _title = '';
  String _author = '';
  String _coverUrl = '';
  String _category = '';
  String _searchKey = '';
  String _publisher = '';
  num _copies = 0;
  num _rating = 0.0;
  num _edition = 0;
  List _issuers = [];

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _barcode = widget.book?.uid;
    _category = widget.book?.category;
    _edition = widget.book?.edition ?? 0;
    _copies = widget.book?.copies ?? 0;
    _rating = widget.book?.rating ?? 0.0;
    _issuers = widget.book?.issuers ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            initialValue: _barcode,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.title.color,
                ),
            decoration: InputDecoration(
                labelText: "BarCode",
                errorStyle: TextStyle(
                  fontSize: 15.0,
                  height: 0.9,
                ),
                labelStyle: TextStyle(color: Colors.grey)),
            readOnly: true,
          ),
          BookTextFormField(
            labelText: 'Title',
            errorText: 'Enter book title',
            initialValue: widget.book?.title,
            onSaved: (value) {
              _title = value;
              _searchKey = value
                  .toString()
                  .substring(0, 1); // first letter of title is search key
            },
          ),
          BookTextFormField(
            labelText: 'Author',
            errorText: 'Enter the author',
            onSaved: (value) => _author = value,
            initialValue: widget.book?.author,
          ),
          BookTextFormField(
            labelText: 'Publisher',
            errorText: 'Enter the publsher',
            initialValue: widget.book?.publisher,
            onSaved: (value) => _publisher = value,
          ),
          BookTextFormField(
            labelText: 'Edition',
            errorText: 'Enter the edition',
            initialValue: _edition.toString(),
            onSaved: (value) => _edition = num.parse(value),
          ),
          BookTextFormField(
            labelText: 'Cover url',
            errorText: 'Enter a cover url',
            initialValue: widget.book?.coverUrl,
            onSaved: (value) => _coverUrl = value,
          ),
          DropdownButtonFormField(
              hint: Text(
                'Category',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              value: widget.book?.category,
              onChanged: (value) {
                setState(() => _category = value);
              },
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.title.color,
                  ),
              items: bookCategory.map((category) {
                return DropdownMenuItem(
                  child: Text(category),
                  value: category,
                );
              }).toList(),
              validator: (value) {
                if (value.isEmpty || value.trim().isEmpty) {
                  return 'Enter the category';
                }
                return null;
              }),
          BookTextFormField(
            labelText: 'Copies',
            errorText: 'Enter the available copies',
            initialValue: _copies.toString(),
            onSaved: (value) => _copies = num.parse(value),
          ),
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Rating',
              labelStyle: TextStyle(color: Colors.grey),
              suffixIcon: Chip(
                label: Text(_rating.toStringAsFixed(1)),
              ),
            ),
            child: Slider(
              value: _rating.roundToDouble(),
              min: 0.0,
              max: 5.0,
              divisions: 50,
              onChanged: (value) => setState(() => _rating = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: ConfirmButton(
              text: widget.book?.title == null ? 'Add Book' : 'Update Book',
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  _formKey.currentState.save();
                  final book = Book(
                    uid: _barcode,
                    title: _title,
                    author: _author,
                    coverUrl: _coverUrl,
                    category: _category,
                    edition: _edition,
                    publisher: _publisher,
                    copies: _copies,
                    rating: _rating,
                    searchKey: _searchKey,
                    issuers: _issuers,
                  );

                  await DatabaseService().updateBookData(book).then((_) {
                    String msg = (widget.book?.title == null)
                        ? "Added book details"
                        : "Updated book details";
                    Fluttertoast.showToast(
                        msg: msg, toastLength: Toast.LENGTH_LONG);
                    Navigator.pop(context);
                  }).catchError((error) {
                    String msg = (widget.book?.title == null)
                        ? "Couldn't add book details :("
                        : "Couldn't update book details :(";
                    Fluttertoast.showToast(
                        msg: msg, toastLength: Toast.LENGTH_LONG);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
