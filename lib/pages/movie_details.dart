import 'package:flutter/material.dart';
import 'package:myflix_app/components/movie.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Movie(movie: args.movie),
    );
  }
}

class MovieDetailsArgs {
  MovieModel movie;

  MovieDetailsArgs({required this.movie});
}
