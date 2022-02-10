import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Object> countryRequest(name) async {
  List listsample = ['0'];
  var url = Uri.https('restcountries.com', '/v3.1/name/$name', {'q': '{http}'});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print('Number of country about http: $jsonResponse.');
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return listsample;
  }
}
