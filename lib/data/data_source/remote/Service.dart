import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class Service {

  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none ? false : true;
  }

  static http.Response createResponse(String body, int statusCode) {
    return http.Response(utf8.encode(body).toString(), statusCode);
  }

}