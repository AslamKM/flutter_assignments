import 'package:flutter/material.dart';
import 'package:flutter_assignment/Views/homeScreenView.dart';
import 'package:flutter_assignment/core/bloc/data_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/dependecyInjection.dart';

void main() {
  serviceLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DataBloc>(
            create: (context) => DataBloc()..add(FetchDataEvent()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreenView(),
      ),
    );
  }
}
