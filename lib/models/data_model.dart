class DataModel{
  String countryName;
  String cases;
  String deaths;
  String activeCases;
  String totalRecovered;

  DataModel({this.countryName,this.cases,this.deaths,this.activeCases,this.totalRecovered});
}

class CountryModel{
  String country;
  String code;
  CountryModel({this.country,this.code});
}


