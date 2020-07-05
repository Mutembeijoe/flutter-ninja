import 'package:flutter/material.dart';
import 'package:flutter_ninja/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    double availableHeight = MediaQuery.of(context).size.height;
    String image = this.movie.posterPath != null
        ? '$iconBase${this.movie.posterPath}'
        : defaultImage;
    print(image);
    return Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.contain,
                    ),
                  ),
                  height: availableHeight / 2,
                  child: Image.network(image),
                ),
                Container(
                  child: Text(movie.overview, style: TextStyle(fontSize: 24)),
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
        ));
  }
}
