import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../elements/fetchedData.dart';
import '../requests/countryrequest.dart' as country;

class MyHomePage extends StatefulWidget {
  MyHomePage({key}) : super(key: key);

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myController = TextEditingController();
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


  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Countries'),
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
                        Navigator.of(context)
                            .pushNamed('/country', arguments: myController)
                      },
                      child: new Text('Enter'),
                    ),
                  ],
                ),
                FutureBuilder(
                    future: countryRequest(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return 
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                          Text('${index + 1} ' +
                                              '' +
                                              snapshot.data[index]["name"]
                                                      ["common"]
                                                  .toString()),
                                          Container(
                                            child: GestureDetector(
                                              onTap:(){
                                                Navigator.of(context)
                            .pushNamed('/country', arguments: snapshot.data[index]["name"]
                                                        ["common"]);
                                              } ,
                                              child: Image.network(snapshot.data[index]["flags"]
                                                        ["png"].toString(),
                                                        width: 80,
                                                        height: 50,
                                                      fit: BoxFit.fill),
                                            ),
                                          )
                                        ]);
                                     
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
