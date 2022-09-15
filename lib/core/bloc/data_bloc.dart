import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data_model.dart';
import '../repository/repository.dart';
import '../services/dependecyInjection.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Repository _repository = locator<Repository>();

  List<DataModel> _list = [];
  List<DataModel> get list => _list;

  DataBloc() : super(DataInitialState()) {
    on<DataEvent>((event, emit) async {
      if (event is FetchDataEvent) {
        emit(DataLoadingState());
        if (!await ConnectivityWrapper.instance.isConnected) {
          emit(DataFetchFailedDueToNetworkState());
        } else {
          try {
            _list = await _repository.getData();

            if (_list.isNotEmpty) {
              emit(DataFetchSuccessState(data: _list, isSuccess: false));
            } else {
              emit(DataFetchFailedState(error: "No data available"));
            }
          } catch (e) {
            emit(DataFetchFailedState(error: "An error occurred $e"));
          }
        }
      }
      if (event is SearchDataEvent) {
        emit(DataLoadingState());
        if (!await ConnectivityWrapper.instance.isConnected) {
          emit(DataFetchFailedDueToNetworkState());
        } else {
          try {
            List<DataModel> modelList = [];
            for (var element in _list) {
              if (element.state == event.state && element.year == event.year) {
                modelList.add(element);
              }
            }

            if (modelList.isNotEmpty) {
              emit(DataFetchSuccessState(data: modelList, isSuccess: true));
            } else {
              emit(DataFetchFailedState(error: "No data there"));
            }
          } catch (e) {
            emit(DataFetchFailedState(error: "An error occurred $e"));
          }
        }
      }
    });
  }
}
