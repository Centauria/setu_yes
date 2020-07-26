import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:setuyes/Views.dart';

class DataManager {
  DataManager(this.dio, this.host);

  final Dio dio;
  final String host;

  Future<Map<String, dynamic>> getServerInfo() async {
    String url = 'http://$host/setu/latest/status';
    log(url);
    Response r = await dio.get(url);
    return await jsonDecode(r.data.toString());
  }

  getTotal() async {
    String url = 'http://$host/setu/latest/count';
    log(url);
    Response r = await dio.get(url);
    Map<String, dynamic> res = jsonDecode(r.data.toString());
    return await res['number'];
  }

  Future<List<String>> getId(
      {int start = 0, int range = 20, bool ascending = false}) async {
    String url = 'http://$host/setu/latest/view';
    log(url);
    Response r = await dio.get(url, queryParameters: {
      'range': '$start:${start + range}',
      'sort': ascending ? 'A' : 'D'
    });
    return List<String>.from(jsonDecode(r.data.toString()));
  }

  Widget getImageById(String id) {
    String url = 'http://$host/setu/latest/view/direct/$id';
    log(url);
    return loadingImageWidget(url);
  }

  Future<Map<String, dynamic>> getImageStatusById(String id) async {
    String url = 'http://$host/setu/latest/view/info/$id';
    log(url);
    Response r = await dio.get(url);
    return Map<String, dynamic>.from(jsonDecode(r.data.toString()));
  }
}
