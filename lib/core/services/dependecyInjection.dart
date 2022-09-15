// ignore_for_file: file_names

import 'package:flutter_assignment/core/repository/repository.dart';
import 'package:flutter_assignment/core/repository/repository_impl.dart';
import 'package:get_it/get_it.dart';

import 'dio_serices_API.dart';

GetIt locator = GetIt.instance;

void serviceLocators() {
  locator.registerLazySingleton<DioAPIServices>(() => DioAPIServices());
  locator.registerLazySingleton<Repository>(
      () => RepositoryImpl(dioAPIServices: locator()));
}
