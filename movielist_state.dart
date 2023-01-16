part of 'movielist_cubit.dart';

abstract class MovielistState extends Equatable {
  const MovielistState();
}

class MovielistInitial extends MovielistState {
  @override
  List<Object> get props => [];
}
class MovielistLoading extends MovielistState {
  @override
  List<Object> get props => [];
}
class MovielistLoaded extends MovielistState {
  MovielistLoaded({required this.datalist});
  final List<MovieListModel> datalist;
  @override
  List<Object> get props => [datalist];
}
