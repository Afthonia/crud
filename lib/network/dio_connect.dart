import 'package:crud/network/constants.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';

class DioConnect {
  String? key;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    responseType: ResponseType.json,
  ));



  DioConnect(this.key);

  Future<bool> getResponse() async {
    try {
      await _dio.get('/$key/${Constants.endpoint}');
      print('connected');
      return Future<bool>.value(true);
    } on DioError {
      print('connection failed');
      return Future<bool>.value(false);
    }
  }

  Future<List<UserModel>?> getData() async {
    try {
      var resp = await _dio.get('/$key/${Constants.endpoint}');
      print(resp);

      final List<UserModel> users = [];
      for (var item in resp.data) {
        users.add(UserModel.fromJson(item));
      }
      return users;
    } on DioError {
      throw 'the data couldn\'t get fetched';
    }
  }

  Future<void> postData(data) async {
    try {
      await _dio.post('/$key/${Constants.endpoint}', data: data);
    } on DioError {
      print('the info couldn\'t get posted');
    }
  }

  Future<void> updateData(String id, data) async {
    try {
      await _dio.put('/$key/${Constants.endpoint}/$id', data: data);
    } on DioError {
      print('the info couldn\'t get updated');
    }
  }

  Future<void> deleteData(String id, data) async {
    try {
      await _dio.delete('/$key/${Constants.endpoint}/$id', data: data);
    } on DioError {
      print('the info couldn\'t get deleted');
    }
  }
}
