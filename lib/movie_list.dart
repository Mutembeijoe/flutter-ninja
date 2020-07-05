import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ninja/http_helper.dart';
import 'package:flutter_ninja/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Widget appBar = Text("Movies");
  Icon visibleIcon = Icon(Icons.search);
  List movies;
  int moviesCount;
  HttpHelper helper;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Future initialize() async {
    var movies = await helper.getUpcoming();
    print((movies[0]));
    setState(() {
      this.movies = movies;
      this.moviesCount = movies.length;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar,
        actions: <Widget>[
          IconButton(
              icon: visibleIcon,
              onPressed: () {
                if (visibleIcon.icon == Icons.search) {
                  setState(() {
                    visibleIcon = Icon(Icons.cancel);
                    appBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      onSubmitted: (value) {
                        helper.searchMovie(value).then((value) {
                          setState(() {
                            moviesCount = value.length;
                            movies = value;
                          });
                        });
                      },
                    );
                  });
                } else {
                  setState(() {
                    visibleIcon = Icon(Icons.search);
                    appBar = Text('Movies');
                  });
                }
              }),
        ],
      ),
      body: ListView.builder(
          itemCount: moviesCount != null ? moviesCount : 0,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              color: Colors.white,
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(builder: (_) {
                    return MovieDetail(movies[index]);
                  });
                  Navigator.push(context, route);
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(movies[index].posterPath != null
                      ? '$iconBase${movies[index].posterPath}'
                      : '$defaultImage'),
                ),
                title: Text(movies[index].title),
                subtitle: Text(
                    'Released: ${movies[index].releaseDate}  Vote: ${movies[index].voteAverage}'),
              ),
            );
          }),
    );
  }
}
