import 'dart:developer';

import 'package:flutter_assignment/core/constants/api_constants.dart';
import 'package:flutter_assignment/core/models/data_model.dart';
import 'package:flutter_assignment/core/repository/repository.dart';
import 'package:flutter_assignment/core/services/dio_serices_API.dart';

import 'package:json_store/json_store.dart';

class RepositoryImpl extends Repository {
  final DioAPIServices dioAPIServices;

  RepositoryImpl({
    required this.dioAPIServices,
  });

  @override
  Future<List<DataModel>> getData() async {
    List<DataModel> list = [];
    JsonStore jsonStore = JsonStore();

    var data = await jsonStore.getItem('data');
    log(data.toString());
    // ignore: unnecessary_null_comparison
    if (data != null) {
      await jsonStore.getItem('data').then((value) {
        log(value.toString());
        list = List<DataModel>.from(
            value!["data"].map((x) => DataModel.fromJson(x)));
      });
    } else {
      dynamic res = await dioAPIServices.getAPI(url: baseUrl);

      await jsonStore.setItem('data', res);
      log(res.toString());
      list =
          List<DataModel>.from(res!["data"].map((x) => DataModel.fromJson(x)));
    }

    return list;
  }
}
