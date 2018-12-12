import 'package:bloc_study/src/models/item_model.dart';
import 'package:bloc_study/src/ui/movie_detail.dart';
import 'package:flutter/material.dart';

import '../blocs/movies_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
              fit: BoxFit.cover,
            ),
            onTap: () => _openDetailPage(snapshot.data, index),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  _openDetailPage(ItemModel data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetail(
        title: data.results[index].title,
        posterUrl: data.results[index].backdropPath,
        description: data.results[index].overview,
        releaseDate: data.results[index].releaseDate,
        voteAverage: data.results[index].voteAverage.toString(),
        movieId: data.results[index].id,
      );
    }));
  }
}

//class MovieList extends StatelessWidget {

//}
