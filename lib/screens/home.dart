// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../elements/fetchedData.dart';
import '../requests/countryrequest.dart' as country;

class MyHomePage extends StatefulWidget {
  MyHomePage({key, required this.title}) : super(key: key);
  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myController = TextEditingController();
  StreamController countryStream = StreamController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future countryRequest() async {
    var url = Uri.https('restcountries.com', '/v3.1/all', {'q': '{http}'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print('Number of country about http: $jsonResponse.');
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  loadCountry() async {
    countryRequest().then((value) async {
      countryStream.add(value);
    });
  }

  void initState() {
    // countryStream = new StreamController();
    // countryRequest();
    // loadCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Country Info'),
        ),
        body: SingleChildScrollView(
          child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                    Column(
                      children: [
                        new TextField(
                          decoration:
                              new InputDecoration(labelText: "Enter a Country"),
                          controller: myController,
                        ),
                         RaisedButton(
                      onPressed: () => {
                        // countryRequest(myController.text).then((value) =>
                        //     {print(value), returnData = value, setState(() {})})
                      },
                      child: new Text('Enter'),
                    ),
                      ],
                    ),
                   
                FutureBuilder(
                future: countryRequest(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // return ListView.builder(
                    //       physics: const AlwaysScrollableScrollPhysics(),
                    //       itemBuilder: (context, index) {
                    //         var post = snapshot.data[index];
                    //         return Text(post["name"]["official"].toString());
                    //       },
                    //     );
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text('${index + 1} '+''+snapshot.data[index]["name"]["common"].toString());
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                })
              ],
            ),
          ),
        ));
  }
}
