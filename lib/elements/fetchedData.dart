import 'package:flutter/material.dart';
import '../requests/countryrequest.dart' as country;

Widget createWidget(var data){
  return SingleChildScrollView(
    child: Row(
      children: [
        Text(data.toString())
      ],
    ),
  );
}
