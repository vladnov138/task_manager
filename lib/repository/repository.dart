import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/repository/abstract_repository.dart';
import 'package:task_manager/services/json_serializer_service.dart';

class Repository implements AbstractRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Dio dio;
  final ip = "https://51.250.50.197:8000";

  Repository({
    required this.dio,
  });

  Future<void> _setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isGuest', false);
    prefs.setBool('isAuthed', true);
    prefs.setString('token', token);
  }

  Future<String> signUp(String login, String password) async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var response = await dio.post('$ip/user/register',
        data: {"login": login, "password": password});
    final data = response.data as Map<String, dynamic>;
    await _setToken(data['token']);
    print(data['description'].toString());
    return data['description'].toString();
  }

  Future<String> signIn(String login, String password) async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var response = await dio
        .post('$ip/user/auth', data: {"login": login, "password": password});
    final data = response.data as Map<String, dynamic>;
    _setToken(data['token']);
    print(data['description'].toString());
    return data['description'].toString();
  }

  @override
  Future<void> downloadData() async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token')!;
    print(token);
    print(GetIt.I<JsonSerializerService>().toJson().toString());
    var response = await dio.post('$ip/data/synch/download', data: {
      "token": token
    });
    final data = response.data as Map<String, dynamic>;
    print(data.toString());
    GetIt.I<JsonSerializerService>().fromJson(data["data"]);
  }

  @override
  Future<void> uploadData() async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    final SharedPreferences prefs = await _prefs;
    String token = prefs.getString('token')!;
    print(token);
    print(GetIt.I<JsonSerializerService>().toJson().toString());
    var response = await dio.post('$ip/data/synch/upload', data: {
      "token": token,
      "data": GetIt.I<JsonSerializerService>().toJson()
    });
    final data = response.data as Map<String, dynamic>;
    print(data["description"].toString());
  }
}
