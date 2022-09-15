part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {}

class FetchDataEvent extends DataEvent {
  @override
  List<Object?> get props => [];
}

class SearchDataEvent extends DataEvent {
  final String year;
  final String state;

  SearchDataEvent({this.year = "",this.state=""});

  @override
  List<Object?> get props => [year,state];
}
