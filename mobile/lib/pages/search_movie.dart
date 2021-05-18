import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:weeb_dev_my_movie_list/bloc/movies_bloc/movies_bloc.dart';
import 'package:weeb_dev_my_movie_list/models/movie.dart';
import 'package:weeb_dev_my_movie_list/models/response/movie_response.dart'; 
import 'package:weeb_dev_my_movie_list/util/helpers/screen_manager.dart';
import 'package:weeb_dev_my_movie_list/widgets/movie_cards.dart';
import 'package:weeb_dev_my_movie_list/widgets/movie_search_bar.dart';

class SearchMoviePage extends StatefulWidget {
  SearchMoviePage({Key key}) : super(key: key);

  @override
  _SearchMoviePageState createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  MoviesBloc _moviesBloc;

  @override
  void initState() { 
    super.initState();
    _moviesBloc = MoviesBloc(); 
  }
  
  @override
  void dispose() { 
    _moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return BlocProvider<MoviesBloc>(
      create: (context) => _moviesBloc ,
      child: SingleChildScrollView(
        child: Column(
          children: [
            MovieSearchBar(),
            _buildBody()        
          ],
        ),
      ),
    );
  }


  Widget _buildBody(){
    return Container( 
      padding: EdgeInsets.symmetric(
        horizontal: ScreenManager.wp(5), 
      ),
      child: StreamBuilder<MovieResponse>(
        stream: _moviesBloc.movieController.stream,
        builder: (context, snapshot){
          if(snapshot.hasData){
              if(snapshot.data.error.isNotEmpty){
                
              print('buildingdasd');
                return Container(); // TODO: ADD error component
              } 
              if(snapshot.data.movies.isEmpty){
                
              print('buildingas');
                return Container(); // TODO: ADD empty state
              } 
              print('building'); 
              return _buildMovieCards(snapshot.data.movies); 
          }
          return Container(); // TODO: ADD empty state
        },
      )
    );
  }

  Widget _buildMovieCards(List<Movie> movies){
    List<Widget> movieCards = [];
    movies.forEach((element) { 
      movieCards.add(MovieCard(element));
    }); 
    return Wrap(
      children: movieCards,
    );
  }
}