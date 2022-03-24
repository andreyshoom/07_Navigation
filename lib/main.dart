import 'package:flutter/material.dart';
import 'package:flutter_navigation/navigation_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: (settings) {
      switch (settings.name) {
        case HomeView.routeName:
          return MaterialPageRoute(builder: (BuildContext context) {
            return HomeView();
          });
        case AlbumsView.routeName:
          // return MaterialPageRoute(builder: (BuildContext context) {
          //   return AlbumsView();
          return PageRouteBuilder(pageBuilder: (
            BuildContext context,
            Animation animation1,
            Animation animation2,
          ) {
            return AlbumsView();
          }, transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            CurvedAnimation _curved =
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);
            Animation<double> _animate =
                Tween<double>(begin: 0.0, end: 1.0).animate(_curved);
            return ScaleTransition(
              scale: _animate,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          });
      }
    });
  }
}
