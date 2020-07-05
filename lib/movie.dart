class Movie {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overview;
  String posterPath;

  Movie(
      {this.id,
      this.title,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.voteAverage});

  Movie.fromJson(Map<String, dynamic> movieMap) {
    this.id = movieMap['id'];
    this.overview = movieMap['overview'];
    this.posterPath = movieMap['poster_path'];
    this.releaseDate = movieMap['release_date'];
    this.title = movieMap['title'];
    this.voteAverage = movieMap['vote_average'] * 1.0;
  }
}
