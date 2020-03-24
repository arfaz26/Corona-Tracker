// import 'dart:convert';
// import 'dart:ffi';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:corona_tracker/models/data_model.dart';
import 'package:http/http.dart' as http;

class Data {
  List<DataModel> data = [];
  List<CountryModel> countryCode = [];
  String code;
  Future<void> getData() async {
    var response = await http.get(
        "https://coronavirus-monitor.p.rapidapi.com/coronavirus/cases_by_country.php",
        headers: {
          "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
          "x-rapidapi-key": "f13ab8c596msh449868faeeda79ep1abd35jsneb419eeecc82"
        });

    var jsonData = jsonDecode(response.body);

    jsonData['countries_stat'].forEach((element) {
      if (element['country_name'] != null &&
          element['deaths'] != null &&
          element['active_cases'] != null &&
          element['cases'] != null &&
          element['total_recovered'] != null) {
        DataModel dataModel = DataModel(
            countryName: element['country_name'],
            deaths: element['deaths'],
            activeCases: element['active_cases'],
            cases: element['cases'],
            totalRecovered: element['total_recovered']);
        
        data.add(dataModel);
      }
    });
  }
}
