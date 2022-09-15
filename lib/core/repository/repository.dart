import 'package:flutter_assignment/core/models/data_model.dart';

abstract class Repository {
  Future<List<DataModel>> getData();
}
