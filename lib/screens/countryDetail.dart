import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../requests/countryrequest.dart';

class countryDetail extends StatefulWidget {
  var country;

  countryDetail(
    this.country, {
    Key? key,
  }) : super(key: key);
  @override
  State<countryDetail> createState() => _countryDetailState();
}

class _countryDetailState extends State<countryDetail> {
  var value;
  StreamController countryStream = StreamController();

  @override
  void initState() {
    super.initState();
    value = widget.country;
    countryRequest(value);
  }

  // final args = ModalRoute.of(context).settings.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: countryRequest(value),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          child: Image.network(
                              snapshot.data[0]["flags"]["png"].toString(),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "Official Name: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["name"]["official"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "Common Name: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["name"]["common"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "Region: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["region"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "SubRegion: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["subregion"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "City Capital: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["capital"][0].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "Currency: ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["currencies"][0]["name"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(" "),
                          AutoSizeText(
                            snapshot.data[0]["currencies"][0]["symbol"].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            "start of the week ",
                            style: TextStyle(
                            ),
                          ),
                          AutoSizeText(
                            snapshot.data[0]["startOfWeek"].toString(),
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
