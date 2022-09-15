import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/bloc/data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/home_sub.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("US population data"),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async =>
            BlocProvider.of<DataBloc>(context).add(FetchDataEvent()),
        child: ListView(
          children: [
            BlocConsumer<DataBloc, DataState>(
              listener: ((context, state) {
                if (state is DataFetchFailedDueToNetworkState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('No internet Connection'),
                  ));
                }
              }),
              builder: ((context, state) {
                if (state is DataFetchSuccessState) {
                  return HomeSub(
                    list: state.data,
                  );
                } else if (state is DataFetchFailedState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is DataLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Some Error occurred"),
                  );
                }
              }),
            ),
          ],
        ),
      )),
    );
  }
}
