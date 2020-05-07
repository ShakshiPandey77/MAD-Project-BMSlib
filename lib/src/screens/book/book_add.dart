import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/widgets/buttons/confirm_button.dart';
import 'package:bmslib/src/widgets/inputs/book_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookAdd extends StatelessWidget {
  // adds or edits book details
  final Book book;

  BookAdd({this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book == null ? 'Add Book' : 'Update Book'),
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
  String barcode = '';
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
    _rating = widget.book?.rating ?? 0.0;
    _issuers = widget.book?.issuers ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
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
            initialValue: widget.book?.edition.toString(),
            onSaved: (value) => _edition = num.parse(value),
          ),
          BookTextFormField(
            labelText: 'Cover url',
            errorText: 'Enter a cover url',
            initialValue: widget.book?.coverUrl,
            onSaved: (value) => _coverUrl = value,
          ),
          BookTextFormField(
            // drop down
            labelText: 'Category',
            errorText: 'Enter a category',
            initialValue: widget.book?.category,
            onSaved: (value) => _category = value,
          ),
          BookTextFormField(
            labelText: 'Copies',
            errorText: 'Enter the available copies',
            initialValue: widget.book?.copies.toString(),
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
              divisions: 5,
              onChanged: (value) => setState(() => _rating = value),
            ),
          ),

          // button to scan bar code

          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: ConfirmButton(
              text: widget.book == null ? 'Add Book' : 'Update Book',
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // _formKey.currentState.save();
                  // final book = Book(_title, _author, _description, _coverUrl,
                  //     _category, _rating);

                  // if (widget.book == null) {
                  //   bookNotifier.addBook(book);
                  //   Navigator.pop(context);
                  // } else {
                  //   bookNotifier.updateBook(widget.book, book);
                  //   Navigator.of(context).pop();
                  // }

                  // add or edit book details

                  String msg = (widget.book == null)
                      ? "Added book details"
                      : "Updated book details";
                  Fluttertoast.showToast(
                      msg: msg, toastLength: Toast.LENGTH_LONG);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
