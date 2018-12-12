import 'package:bloc_study/src/models/item_model.dart';
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
        return Image.network(
          'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
          fit: BoxFit.cover,
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
}

//class MovieList extends StatelessWidget {

//}
