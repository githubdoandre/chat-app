import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/screens/threads/threads_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
      onGenerateRoute: generateRoute,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/threadsDetail':
      return MaterialPageRoute(
        builder: (_) => ThreadsPage(
           threads: settings.arguments,
        ),
      );
      break;
    case '/':
    default:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );
      break;
  }
}
