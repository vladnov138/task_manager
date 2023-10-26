import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/repository/abstract_repository.dart';

class Repository implements AbstractRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Dio dio;
  final ip = "https://51.250.50.197:8000";

  Repository({required this.dio, });

  Future<void> _setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isGuest', false);
    prefs.setBool('isAuthed', true);
    prefs.setString('token', token);
  }

  Future<String> signUp(String login, String password) async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var response = await dio
        .post('$ip/user/register', data: {"login": login, "password": password});
    final data = response.data as Map<String, dynamic>;
    await _setToken(data['token']);
    print(data['description'].toString());
    return data['description'].toString();
  }

  Future<String> signIn(String login, String password) async {
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var response = await dio
        .post('$ip/user/auth', data: {"login": login, "password": password});
    final data = response.data as Map<String, dynamic>;
    await _setToken(data['token']);
    print(data['description'].toString());
    return data['description'].toString();
  }

  // Future<void> downloadData() {
  //   return;
  // }
  //
  // Future<void> uploadData() {}
}
