//import 'package:bmslib/src/models/user.dart';
import 'package:bmslib/src/models/book.dart';
import 'package:bmslib/src/services/database.dart';
import 'package:bmslib/src/widgets/network.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmslib/src/services/connectivity.dart';

//import 'package:bmslib/src/services/auth.dart';
import 'package:bmslib/src/models/notifiers/theme_notifier.dart';
import 'package:bmslib/src/theme/theme.dart' as libraryTheme;
import 'package:bmslib/src/screens/current_screen.dart';

void main() => runApp(BMSLib());

class BMSLib extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        StreamProvider<ConnectionStatus>.value(
          value: ConnectivityService().connectivityController.stream,
        ),
        StreamProvider<List<Book>>.value(
          value: DatabaseService().books,
          initialData: [],
          catchError: (_, __) {
            print(__.toString());
            return null;
          },
        ),
      ],
      child: MaterialAppWithTheme(), //add wrapper here
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'BMSLib',
      darkTheme: libraryTheme.Theme.darkTheme,
      theme: themeNotifier.darkModeEnabled
          ? libraryTheme.Theme.darkTheme
          : libraryTheme.Theme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: NetworkWidget(
        child: CurrentScreen(),
      ),
    );
  }
}
