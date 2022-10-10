part of 'search_bloc.dart';

class SearchState extends Equatable {

  final List<Feature> places;

  const SearchState({
    this.places = const []
  });

  SearchState copyWith({
    List<Feature>?  places
  })=> SearchState(
    places: places ?? this.places
  );
  
  @override
  List<Object> get props => [places];
}

