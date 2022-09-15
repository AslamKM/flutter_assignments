part of 'data_bloc.dart';

abstract class DataState extends Equatable {}

class DataInitialState extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoadingState extends DataState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DataFetchSuccessState extends DataState {
  final List<DataModel> data;
  bool isSuccess = false;
  DataFetchSuccessState({required this.data,required this.isSuccess});

  @override
  List<Object?> get props => [data];
}

class DataFetchFailedState extends DataState {
  final String error;

  DataFetchFailedState({required this.error});

  @override
  List<Object?> get props => [error];
}

class DataFetchFailedDueToNetworkState extends DataState {
  @override
  List<Object?> get props => [];
}
