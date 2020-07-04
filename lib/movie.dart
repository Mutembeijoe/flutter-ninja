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
    this.posterPath = movieMap['posterPath'];
    this.releaseDate = movieMap['releaseDate'];
    this.title = movieMap['title'];
    this.voteAverage = movieMap['voteAverage'];
  }
}
