import 'package:flutter/material.dart';
import 'package:myflix_app/models/movie_model.dart';

class MovieDetails extends StatelessWidget {
  static const route = '/movie/details';
  MovieDetailsArgs args;

  MovieDetails({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          print(args);
        },
        child: Text('prova'),
      ),
    );
  }
}

class MovieDetailsArgs {
  MovieModel movie;

  MovieDetailsArgs({required this.movie});
}
