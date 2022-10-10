part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class onNewPlacesFoundEvent extends SearchEvent{
  final List<Feature> places;
  const onNewPlacesFoundEvent(this.places);
}