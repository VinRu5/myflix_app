class MovieModel {
  final int id;
  final String imagePath;
  final String title;
  final String language;
  final String description;
  // final double vote;

  MovieModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.language,
    required this.description,
    // required this.vote,
  });

  factory MovieModel.fromData(Map<String, dynamic> data) {
    var mov = MovieModel(
      id: data['id'],
      imagePath: data['poster_path'] == null
          ? 'https://media-assets.wired.it/photos/615ef4b55ccc3b73fb14d5b2/master/pass/wired_placeholder_dummy.png'
          : 'https://image.tmdb.org/t/p/w500${data['poster_path']}',
      title: data['title'],
      language: data['original_language'],
      description: data['overview'],
      // vote: data['vote_average'],
    );
    //print(mov);
    return mov;
  }

  @override
  String toString() => '$id - $title - $language - $imagePath';
}
