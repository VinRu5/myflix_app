import 'package:flutter/material.dart';
import 'package:myflix_app/models/movie_model.dart';

class Movie extends StatelessWidget {
  final MovieModel movie;
  const Movie({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Image.network(
            movie.imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Text(
                movie.title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
