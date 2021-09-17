import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schooluniform/configs/api/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class NetworkHandler {
  String baseurl = ApiConfig.BASE_URI;

  Future get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("x-access-token");
    url = formater(url);
    try {
      var response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "x-access-token": token,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);

        return json.decode(response.body);
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (err) {
      print('err message');
      print(err);
    }
  }

  Future post(String url, Map<dynamic, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("x-access-token");
    url = formater(url);
    print(body);
    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token,
        },
        body: json.encode(body),
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err message');
      print(err);
      return null;
    }
  }

  Future put(String url, Map<dynamic, dynamic> body) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("x-access-token");
    url = formater(url);
    print(body);
    try {
      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-access-token": token,
        },
        body: json.encode(body),
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err message');
      print(err);
      return null;
    }
  }

  Future putImage({String filePath, String uniformId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("x-access-token");
      var uri = Uri.parse("${ApiConfig.SERVER_URI}/uploads");
      var request = http.MultipartRequest('POST', uri);
      var timestemp = DateTime.now().millisecondsSinceEpoch;
      var filename = uniformId + '_$timestemp.png';

      request.files.add(await http.MultipartFile.fromPath("imageFile", filePath,
          filename: filename,
          contentType: MediaType('image', 'image/png', {'charset': 'utf-8'})));
      request.headers.addAll({
        "Content-type": "multipart/form-data",
        "x-access-token": token,
      });
      request.send();
      return 'uploads/$filename';
    } catch (err) {
      print(err);
      return null;
    }
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageSrc) {
    String url = formater('/' + imageSrc);
    return NetworkImage(url);
  }
}
