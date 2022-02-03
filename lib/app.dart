import 'package:flutter/material.dart';
import 'package:myflix_app/models/movie_model.dart';
import 'package:myflix_app/pages/home_page.dart';
import 'package:myflix_app/pages/movie_details.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.route,
      onGenerateRoute: (settings) {
        final routes = {
          HomePage.route: (_) => HomePage(),
          MovieDetails.route: (_) =>
              MovieDetails(args: (settings.arguments as MovieDetailsArgs)),
        };

        return MaterialPageRoute(builder: routes[settings.name]!);
      },
    );
  }
}
