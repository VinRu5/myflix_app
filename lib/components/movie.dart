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
        Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  movie.description,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
