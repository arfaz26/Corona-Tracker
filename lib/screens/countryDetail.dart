import 'package:flutter/material.dart';

class CountryDetail extends StatefulWidget {
  String countryName;
  CountryDetail({this.countryName});
  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Corona',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            Text('Tracker',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 25)),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.train),
            ),
          )
        ],
        // elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Text(widget.countryName),
        ),
      ),
    );
  }
}
