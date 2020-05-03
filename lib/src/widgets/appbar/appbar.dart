import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
import 'package:bmslib/src/widgets/appbar/book_search.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);

    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('BMS Lib'),
      ),
      actions: [
        IconButton(
          icon: themeNotifier.darkModeEnabled
              ? Icon(Icons.brightness_7)
              : Icon(Icons.brightness_2),
          color: Theme.of(context).iconTheme.color,
          onPressed: () => themeNotifier.toggleTheme(),
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: null /*BookSearch()*/);
          },
        ),
      ],
    );
  }
}
