import 'package:corona_tracker/helper/data.dart';
import 'package:corona_tracker/models/data_model.dart';
import 'package:corona_tracker/screens/countryDetail.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DataModel> dataModel = new List<DataModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountry();
  }

  getCountry() async {
    Data newClass = Data(

    );
    await newClass.getData();
    dataModel = newClass.data;
    setState(() {
      _loading = false;
    });
  }

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
        // elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              ),
            )
          : 
          SingleChildScrollView(
              child: Container(
                color: Colors.white,
                // Color(0XC0C0C0),
                // Color(0XF2EAE9),
                // decoration: ,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                //  height: 500,

                child: ListView.builder(
                    itemCount: dataModel.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CountryTile(
                        cases: int.parse(
                            (dataModel[index].cases).replaceAll(',', '')),
                        activeCases: int.parse(
                            (dataModel[index].activeCases).replaceAll(',', '')),
                        deaths: int.parse(
                            (dataModel[index].deaths).replaceAll(',', '')),
                        totalRecovered: int.parse(
                            (dataModel[index].totalRecovered)
                                .replaceAll(',', '')),
                        countryName: dataModel[index].countryName,
                      );
                    }),
              ),
            ),
    );
  }
}

class CountryTile extends StatelessWidget {
  final String countryName;
  final int cases, deaths, activeCases, totalRecovered;

  CountryTile(
      {@required this.countryName,
      @required this.activeCases,
      @required this.cases,
      @required this.deaths,
      @required this.totalRecovered});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryDetail(
                      countryName: countryName,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: <Widget>[
            Container(
              height: 184.0,
              padding: EdgeInsets.only(top: 16),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          countryName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                          child: Icon(Icons.keyboard_arrow_right),
                          backgroundColor: Colors.grey,
                          radius: 17.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 50),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Infected",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cases.toString(),
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 16.0, left: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Deaths',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      deaths.toString(),
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('(' +
                                        ((deaths * 100 / cases))
                                            .toStringAsFixed(2) +
                                        '%)'),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  animation: true,
                                  width: 100.0,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.redAccent,
                                  lineHeight: 8.0,
                                  percent:
                                      double.parse((deaths / cases).toString()),
                                ),
                              ],
                            ),
                            VerticalDivider(
                              thickness: 1.2345,
                              color: Colors.black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Recovered',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      totalRecovered.toString(),
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('(' +
                                        ((totalRecovered * 100 / cases))
                                            .toStringAsFixed(2) +
                                        '%)'),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  animation: true,
                                  width: 100.0,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.greenAccent,
                                  lineHeight: 8.0,
                                  percent: double.parse(
                                      (totalRecovered / cases).toString()),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height: 70.0,
                    ),
                  ),
                ],
              ),
              margin: new EdgeInsets.only(left: 46.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(10.0, 10.0),
                  ),
                ],
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
              alignment: FractionalOffset.centerLeft,
              child: flag(countryName),
              height: 92.0,
              width: 80.0,
              // ),
            )
          ],
        ),
      ),
    );
  }
}

Widget flag(countryName) {
  if (countryName == 'China') {
    return Flags.getFullFlag('CN', 50, 50);
  }
  if (countryName == 'Italy') {
    return Flags.getFullFlag('IT', 50, 50);
  }
  if (countryName == 'Afghanistan') {
    return Flags.getFullFlag('AF', 50, 50);
  }
  if (countryName == 'Åland Islands') {
    return Flags.getFullFlag('AX', 50, 50);
  }
  if (countryName == 'Albania') {
    return Flags.getFullFlag('AL', 50, 50);
  }
  if (countryName == 'Algeria') {
    return Flags.getFullFlag('DZ', 50, 50);
  }
  if (countryName == 'American Samoa') {
    return Flags.getFullFlag('AS', 50, 50);
  }
  if (countryName == 'Andorra') {
    return Flags.getFullFlag('AD', 50, 50);
  }
  if (countryName == 'Angola') {
    return Flags.getFullFlag('AO', 50, 50);
  }
  if (countryName == 'Anguilla') {
    return Flags.getFullFlag('AI', 50, 50);
  }
  if (countryName == 'Antarctica') {
    return Flags.getFullFlag('AQ', 50, 50);
  }
  if (countryName == 'Antigua and Barbuda') {
    return Flags.getFullFlag('AG', 50, 50);
  }
  if (countryName == 'Argentina') {
    return Flags.getMiniFlag('AR', 50, 50);
  }
  if (countryName == 'Armenia') {
    return Flags.getFullFlag('AM', 50, 50);
  }
  if (countryName == 'Aruba') {
    return Flags.getFullFlag('AW', 50, 50);
  }
  if (countryName == 'Australia') {
    return Flags.getFullFlag('AU', 50, 50);
  }
  if (countryName == 'Austria') {
    return Flags.getFullFlag('AT', 50, 50);
  }
  if (countryName == 'Azerbaijan') {
    return Flags.getFullFlag('AZ', 50, 50);
  }
  if (countryName == 'Bahamas') {
    return Flags.getFullFlag('BS', 50, 50);
  }
  if (countryName == 'Bahrain') {
    return Flags.getFullFlag('BH', 50, 50);
  }
  if (countryName == 'Bangladesh') {
    return Flags.getFullFlag('BD', 50, 50);
  }
  if (countryName == 'Barbados') {
    return Flags.getFullFlag('BB', 50, 50);
  }
  if (countryName == 'Belarus') {
    return Flags.getFullFlag('BY', 50, 50);
  }
  if (countryName == 'Belgium') {
    return Flags.getFullFlag('BE', 50, 50);
  }
  if (countryName == 'Belize') {
    return Flags.getFullFlag('BZ', 50, 50);
  }
  if (countryName == 'Benin') {
    return Flags.getFullFlag('BJ', 50, 50);
  }
  if (countryName == 'Bermuda') {
    return Flags.getFullFlag('BM', 50, 50);
  }
  if (countryName == 'Bhutan') {
    return Flags.getFullFlag('BT', 50, 50);
  }
  if (countryName == 'Bolivia') {
    return Flags.getFullFlag('BO', 50, 50);
  }
  if (countryName == 'Bosnia and Herzegovina') {
    return Flags.getFullFlag('BA', 50, 50);
  }
  if (countryName == 'St. Vincent Grenadines') {
    return Flags.getFullFlag('VC', 50, 50);
  }
  if (countryName == 'Botswana') {
    return Flags.getFullFlag('BW', 50, 50);
  }
  if (countryName == 'Bouvet Island') {
    return Flags.getFullFlag('BV', 50, 50);
  }
  if (countryName == 'Brazil') {
    return Flags.getMiniFlag('BR', 50, 50);
  }
  if (countryName == 'Russia') {
    return Flags.getMiniFlag('RU', 50, 50);
  }
  if (countryName == 'USA') {
    return Flags.getFullFlag('US', 50, 50);
  }
  if (countryName == 'Tunisia') {
    return Flags.getFullFlag('TN', 50, 50);
  }
  if (countryName == 'Brunei') {
    return Flags.getFullFlag('BN', 50, 50);
  }
  if (countryName == 'Bulgaria') {
    return Flags.getFullFlag('BG', 50, 50);
  }
  if (countryName == 'Burkina Faso') {
    return Flags.getFullFlag('BF', 50, 50);
  }
  if (countryName == 'Burundi') {
    return Flags.getFullFlag('BI', 50, 50);
  }
  if (countryName == 'Cambodia') {
    return Flags.getFullFlag('KH', 50, 50);
  }
  if (countryName == 'Cameroon') {
    return Flags.getFullFlag('CM', 50, 50);
  }
  if (countryName == 'Canada') {
    return Flags.getFullFlag('CA', 50, 50);
  }
  if (countryName == 'Cape Verde') {
    return Flags.getFullFlag('CV', 50, 50);
  }
  if (countryName == 'Cayman Islands') {
    return Flags.getMiniFlag('KY', 50, 50);
  }
  if (countryName == 'Cabo Verde') {
    return Flags.getMiniFlag('CV', 50, 50);
  }
  if (countryName == 'CAR') {
    return Flags.getMiniFlag('CF', 50, 50);
  }
  if (countryName == 'St. Barth') {
    return Flags.getMiniFlag('FR', 50, 50);
  }
  if (countryName == 'Central African Republic') {
    return Flags.getFullFlag('CF', 50, 50);
  }
  if (countryName == 'Chad') {
    return Flags.getFullFlag('TD', 50, 50);
  }
  if (countryName == 'Chile') {
    return Flags.getFullFlag('CL', 50, 50);
  }
  if (countryName == 'Christmas Island') {
    return Flags.getFullFlag('CX', 50, 50);
  }
  if (countryName == 'China') {
    return Flags.getFullFlag('CN', 50, 50);
  }
  if (countryName == 'Cocos (Keeling) Islands') {
    return Flags.getFullFlag('CC', 50, 50);
  }
  if (countryName == 'Colombia') {
    return Flags.getFullFlag('CO', 50, 50);
  }
  if (countryName == 'Comoros') {
    return Flags.getFullFlag('KM', 50, 50);
  }
  if (countryName == 'Congo') {
    return Flags.getFullFlag('CG', 50, 50);
  }
  if (countryName == 'Montenegro') {
    return Flags.getFullFlag('ME', 50, 50);
  }
  if (countryName == 'Ivory Coast') {
    return Flags.getFullFlag('CI', 50, 50);
  }
  if (countryName == 'DRC') {
    return Flags.getFullFlag('CD', 50, 50);
  }
  if (countryName == 'Isle of Man') {
    return Flags.getFullFlag('IM', 50, 50);
  }
  if (countryName == 'Cook Islands') {
    return Flags.getFullFlag('CK', 50, 50);
  }
  if (countryName == 'Costa Rica') {
    return Flags.getFullFlag('CR', 50, 50);
  }
  if (countryName == 'Croatia') {
    return Flags.getFullFlag('HR', 50, 50);
  }
  if (countryName == 'Cuba') {
    return Flags.getFullFlag('CU', 50, 50);
  }
  if (countryName == 'Cyprus') {
    return Flags.getFullFlag('CY', 50, 50);
  }
  if (countryName == 'Czech Republic') {
    return Flags.getFullFlag('CZ', 50, 50);
  }
  if (countryName == 'Denmark') {
    return Flags.getFullFlag('DK', 50, 50);
  }
  if (countryName == 'Djibouti') {
    return Flags.getFullFlag('DJ', 50, 50);
  }
  if (countryName == 'Dominica') {
    return Flags.getMiniFlag('DM', 50, 50);
  }
  if (countryName == 'Dominican Republic') {
    return Flags.getFullFlag('DO', 50, 50);
  }
  if (countryName == 'Ecuador') {
    return Flags.getFullFlag('EC', 50, 50);
  }
  if (countryName == 'Egypt') {
    return Flags.getFullFlag('EG', 50, 50);
  }
  if (countryName == 'El Salvador') {
    return Flags.getFullFlag('SV', 50, 50);
  }
  if (countryName == 'Equatorial Guinea') {
    return Flags.getFullFlag('GQ', 50, 50);
  }
  if (countryName == 'Eritrea') {
    return Flags.getFullFlag('ER', 50, 50);
  }
  if (countryName == 'Estonia') {
    return Flags.getFullFlag('EE', 50, 50);
  }
  if (countryName == 'Ethiopia') {
    return Flags.getFullFlag('ET', 50, 50);
  }
  if (countryName == 'Faeroe Islands') {
    return Flags.getFullFlag('FO', 50, 50);
  }
  if (countryName == 'Fiji') {
    return Flags.getFullFlag('FI', 50, 50);
  }
  if (countryName == 'Finland') {
    return Flags.getFullFlag('FI', 50, 50);
  }
  if (countryName == 'France') {
    return Flags.getFullFlag('FR', 50, 50);
  }
  if (countryName == 'French Guiana') {
    return Flags.getFullFlag('GF', 50, 50);
  }
  if (countryName == 'French Polynesia') {
    return Flags.getFullFlag('PF', 50, 50);
  }
  if (countryName == 'French Southern Territories') {
    return Flags.getFullFlag('TF', 50, 50);
  }
  if (countryName == 'Gabon') {
    return Flags.getFullFlag('GA', 50, 50);
  }
  if (countryName == 'Gambia') {
    return Flags.getFullFlag('GM', 50, 50);
  }
  if (countryName == 'Georgia') {
    return Flags.getFullFlag('GE', 50, 50);
  }
  if (countryName == 'Germany') {
    return Flags.getFullFlag('DE', 50, 50);
  }
  if (countryName == 'Ghana') {
    return Flags.getFullFlag('GH', 50, 50);
  }
  if (countryName == 'Gibraltar') {
    return Flags.getFullFlag('GI', 50, 50);
  }
  if (countryName == 'Greece') {
    return Flags.getFullFlag('GR', 50, 50);
  }
  if (countryName == 'Grenada') {
    return Flags.getMiniFlag('GD', 50, 50);
  }
  if (countryName == 'Sint Maarten') {
    return Flags.getMiniFlag('SX', 50, 50);
  }
  if (countryName == 'Guadeloupe') {
    return Flags.getFullFlag('GP', 50, 50);
  }
  if (countryName == 'Guam') {
    return Flags.getFullFlag('GU', 50, 50);
  }
  if (countryName == 'Guatemala') {
    return Flags.getFullFlag('GT', 50, 50);
  }
  if (countryName == 'Guernsey') {
    return Flags.getFullFlag('GG', 50, 50);
  }
  if (countryName == 'Guinea') {
    return Flags.getFullFlag('GN', 50, 50);
  }
  if (countryName == 'Guyana') {
    return Flags.getFullFlag('GY', 50, 50);
  }
  if (countryName == 'Haiti') {
    return Flags.getMiniFlag('HT', 50, 50);
  }
  if (countryName == 'Vatican City') {
    return Flags.getFullFlag('VA', 50, 50);
  }
  if (countryName == 'Honduras') {
    return Flags.getFullFlag('HN', 50, 50);
  }
  if (countryName == 'Hong Kong') {
    return Flags.getFullFlag('HK', 50, 50);
  }
  if (countryName == 'Hungary') {
    return Flags.getFullFlag('HU', 50, 50);
  }
  if (countryName == 'Iceland') {
    return Flags.getFullFlag('IS', 50, 50);
  }
  if (countryName == 'Indonesia') {
    return Flags.getFullFlag('ID', 50, 50);
  }
  if (countryName == 'Iran') {
    return Flags.getFullFlag('IR', 50, 50);
  }
  if (countryName == 'Iraq') {
    return Flags.getFullFlag('IQ', 50, 50);
  }
  if (countryName == 'Ireland') {
    return Flags.getFullFlag('IE', 50, 50);
  }
  if (countryName == 'Isle of Man') {
    return Flags.getFullFlag('IM', 50, 50);
  }
  if (countryName == 'Israel') {
    return Flags.getFullFlag('IL', 50, 50);
  }
  if (countryName == 'Jamaica') {
    return Flags.getFullFlag('JM', 50, 50);
  }
  if (countryName == 'Japan') {
    return Flags.getFullFlag('JP', 50, 50);
  }
  if (countryName == 'Jersey') {
    return Flags.getFullFlag('JE', 50, 50);
  }
  if (countryName == 'Jordan') {
    return Flags.getFullFlag('JO', 50, 50);
  }
  if (countryName == 'Kazakhstan') {
    return Flags.getFullFlag('KZ', 50, 50);
  }
  if (countryName == 'Kenya') {
    return Flags.getFullFlag('KE', 50, 50);
  }
  if (countryName == 'Kiribati') {
    return Flags.getFullFlag('KI', 50, 50);
  }
  if (countryName == 'S. Korea') {
    return Flags.getFullFlag('KR', 50, 50);
  }
  if (countryName == 'Kuwait') {
    return Flags.getFullFlag('KW', 50, 50);
  }
  if (countryName == 'Kyrgyzstan') {
    return Flags.getFullFlag('KG', 50, 50);
  }
  if (countryName == 'Latvia') {
    return Flags.getFullFlag('LV', 50, 50);
  }
  if (countryName == 'Lebanon') {
    return Flags.getFullFlag('LB', 50, 50);
  }
  if (countryName == 'Lesotho') {
    return Flags.getFullFlag('LS', 50, 50);
  }
  if (countryName == 'Liberia') {
    return Flags.getFullFlag('LR', 50, 50);
  }
  if (countryName == 'Liechtenstein') {
    return Flags.getFullFlag('LI', 50, 50);
  }
  if (countryName == 'Lithuania') {
    return Flags.getFullFlag('LT', 50, 50);
  }
  if (countryName == 'Luxembourg') {
    return Flags.getFullFlag('LU', 50, 50);
  }
  if (countryName == 'Macao') {
    return Flags.getFullFlag('MO', 50, 50);
  }
  if (countryName == 'North Macedonia') {
    return Flags.getFullFlag('MK', 50, 50);
  }
  if (countryName == 'Madagascar') {
    return Flags.getFullFlag('MG', 50, 50);
  }
  if (countryName == 'Malawi') {
    return Flags.getFullFlag('MW', 50, 50);
  }
  if (countryName == 'Malaysia') {
    return Flags.getFullFlag('MY', 50, 50);
  }
  if (countryName == 'Maldives') {
    return Flags.getFullFlag('MV', 50, 50);
  }
  if (countryName == 'Mali') {
    return Flags.getFullFlag('ML', 50, 50);
  }
  if (countryName == 'Malta') {
    return Flags.getFullFlag('MT', 50, 50);
  }
  if (countryName == 'Martinique') {
    return Flags.getFullFlag('MQ', 50, 50);
  }
  if (countryName == 'Mauritania') {
    return Flags.getFullFlag('MR', 50, 50);
  }
  if (countryName == 'Mauritius') {
    return Flags.getFullFlag('MU', 50, 50);
  }
  if (countryName == 'Mayotte') {
    return Flags.getFullFlag('YT', 50, 50);
  }
  if (countryName == 'Mexico') {
    return Flags.getFullFlag('MX', 50, 50);
  }
  if (countryName == 'Micronesia') {
    return Flags.getFullFlag('FM', 50, 50);
  }
  if (countryName == 'Czechia') {
    return Flags.getFullFlag('CZ', 50, 50);
  }
  if (countryName == 'Diamond Princess') {
    return Flags.getFullFlag('FM', 50, 50);
  }
  if (countryName == 'Moldova') {
    return Flags.getFullFlag('MD', 50, 50);
  }
  if (countryName == 'Monaco') {
    return Flags.getFullFlag('MC', 50, 50);
  }
  if (countryName == 'Mongolia') {
    return Flags.getFullFlag('MN', 50, 50);
  }
  if (countryName == 'Montserrat') {
    return Flags.getFullFlag('MS', 50, 50);
  }
  if (countryName == 'Morocco') {
    return Flags.getFullFlag('MA', 50, 50);
  }
  if (countryName == 'Mozambique') {
    return Flags.getFullFlag('MZ', 50, 50);
  }
  if (countryName == 'Namibia') {
    return Flags.getFullFlag('NA', 50, 50);
  }
  if (countryName == 'Nauru') {
    return Flags.getFullFlag('NR', 50, 50);
  }
  if (countryName == 'Nepal') {
    return Flags.getMiniFlag('NP', 50, 50);
  }
  if (countryName == 'Netherlands') {
    return Flags.getFullFlag('NL', 50, 50);
  }
  if (countryName == 'Netherlands Antilles') {
    return Flags.getFullFlag('AN', 50, 50);
  }
  if (countryName == 'New Caledonia') {
    return Flags.getFullFlag('NC', 50, 50);
  }
  if (countryName == 'New Zealand') {
    return Flags.getFullFlag('NZ', 50, 50);
  }
  if (countryName == 'Nicaragua') {
    return Flags.getFullFlag('NI', 50, 50);
  }
  if (countryName == 'Greenland') {
    return Flags.getFullFlag('GL', 50, 50);
  }
  if (countryName == 'Eswatini') {
    return Flags.getFullFlag('SZ', 50, 50);
  }
  if (countryName == 'Niger') {
    return Flags.getFullFlag('NE', 50, 50);
  }
  if (countryName == 'Nigeria') {
    return Flags.getFullFlag('NG', 50, 50);
  }
  if (countryName == 'Niue') {
    return Flags.getFullFlag('NU', 50, 50);
  }
  if (countryName == 'Norfolk Island') {
    return Flags.getFullFlag('NF', 50, 50);
  }
  if (countryName == 'Northern Mariana Islands') {
    return Flags.getFullFlag('MP', 50, 50);
  }
  if (countryName == 'Norway') {
    return Flags.getFullFlag('NO', 50, 50);
  }
  if (countryName == 'Oman') {
    return Flags.getMiniFlag('OM', 50, 50);
  }
  if (countryName == 'Pakistan') {
    return Flags.getFullFlag('PK', 50, 50);
  }
  if (countryName == 'Palau') {
    return Flags.getFullFlag('PW', 50, 50);
  }
  if (countryName == 'Palestine') {
    return Flags.getFullFlag('PS', 50, 50);
  }
  if (countryName == 'Panama') {
    return Flags.getFullFlag('PA', 50, 50);
  }
  if (countryName == 'Papua New Guinea') {
    return Flags.getFullFlag('PG', 50, 50);
  }
  if (countryName == 'Peru') {
    return Flags.getMiniFlag('PE', 50, 50);
  }
  if (countryName == 'Paraguay') {
    return Flags.getFullFlag('PY', 50, 50);
  }
  if (countryName == 'Philippines') {
    return Flags.getFullFlag('PH', 50, 50);
  }
  if (countryName == 'Pitcairn') {
    return Flags.getFullFlag('PN', 50, 50);
  }
  if (countryName == 'Poland') {
    return Flags.getFullFlag('PL', 50, 50);
  }
  if (countryName == 'Portugal') {
    return Flags.getFullFlag('PT', 50, 50);
  }
  if (countryName == 'Puerto Rico') {
    return Flags.getFullFlag('PR', 50, 50);
  }
  if (countryName == 'Qatar') {
    return Flags.getFullFlag('QA', 50, 50);
  }
  if (countryName == 'Channel Islands') {
    return Flags.getFullFlag('GB', 50, 50);
  }
  if (countryName == 'Réunion') {
    return Flags.getFullFlag('RE', 50, 50);
  }
  if (countryName == 'Romania') {
    return Flags.getFullFlag('RO', 50, 50);
  }
  if (countryName == 'Rwanda') {
    return Flags.getFullFlag('RW', 50, 50);
  }
  if (countryName == 'Saint Helena') {
    return Flags.getFullFlag('SH', 50, 50);
  }
  if (countryName == 'Saint Martin') {
    return Flags.getFullFlag('FR', 50, 50);
  }
  if (countryName == 'Curaçao') {
    return Flags.getFullFlag('CW', 50, 50);
  }
  if (countryName == 'Saint Lucia') {
    return Flags.getFullFlag('LC', 50, 50);
  }
  if (countryName == 'Samoa') {
    return Flags.getFullFlag('WS', 50, 50);
  }
  if (countryName == 'San Marino') {
    return Flags.getFullFlag('SM', 50, 50);
  }
  if (countryName == 'Saudi Arabia') {
    return Flags.getFullFlag('SA', 50, 50);
  }
  if (countryName == 'Senegal') {
    return Flags.getFullFlag('SN', 50, 50);
  }
  if (countryName == 'Serbia') {
    return Flags.getMiniFlag('RS', 50, 50);
  }
  if (countryName == 'Seychelles') {
    return Flags.getFullFlag('SC', 50, 50);
  }
  if (countryName == 'Singapore') {
    return Flags.getFullFlag('SG', 50, 50);
  }
  if (countryName == 'Slovakia') {
    return Flags.getFullFlag('SK', 50, 50);
  }
  if (countryName == 'Slovenia') {
    return Flags.getFullFlag('SI', 50, 50);
  }
  if (countryName == 'Somalia') {
    return Flags.getFullFlag('SO', 50, 50);
  }
  if (countryName == 'South Africa') {
    return Flags.getMiniFlag('ZA', 50, 50);
  }
  if (countryName == 'Spain') {
    return Flags.getFullFlag('ES', 50, 50);
  }
  if (countryName == 'Sri Lanka') {
    return Flags.getMiniFlag('LK', 50, 50);
  }
  if (countryName == 'Sudan') {
    return Flags.getFullFlag('SD', 50, 50);
  }
  if (countryName == 'Suriname') {
    return Flags.getFullFlag('SR', 50, 50);
  }
  if (countryName == 'Sweden') {
    return Flags.getFullFlag('SE', 50, 50);
  }
  if (countryName == 'Switzerland') {
    return Flags.getFullFlag('CH', 50, 50);
  }
  if (countryName == 'Syria') {
    return Flags.getFullFlag('SY', 50, 50);
  }
  if (countryName == 'Taiwan') {
    return Flags.getMiniFlag('TW', 50, 50);
  }
  if (countryName == 'Tajikistan') {
    return Flags.getFullFlag('TJ', 50, 50);
  }
  if (countryName == 'Tanzania') {
    return Flags.getFullFlag('TZ', 50, 50);
  }
  if (countryName == 'Thailand') {
    return Flags.getFullFlag('TH', 50, 50);
  }
  if (countryName == 'Timor-Leste') {
    return Flags.getFullFlag('TL', 50, 50);
  }
  if (countryName == 'Togo') {
    return Flags.getFullFlag('TG', 50, 50);
  }
  if (countryName == 'Tokelau') {
    return Flags.getFullFlag('TK', 50, 50);
  }
  if (countryName == 'Tonga') {
    return Flags.getFullFlag('TO', 50, 50);
  }
  if (countryName == 'Trinidad and Tobago') {
    return Flags.getFullFlag('TT', 50, 50);
  }
  if (countryName == 'Turkmenistan') {
    return Flags.getFullFlag('TM', 50, 50);
  }
  if (countryName == 'Turkey') {
    return Flags.getFullFlag('TR', 50, 50);
  }
  if (countryName == 'Uganda') {
    return Flags.getFullFlag('UG', 50, 50);
  }
  if (countryName == 'Ukraine') {
    return Flags.getFullFlag('UA', 50, 50);
  }
  if (countryName == 'UAE') {
    return Flags.getFullFlag('AE', 50, 50);
  }
  if (countryName == 'UK') {
    return Flags.getFullFlag('GB', 50, 50);
  }
  if (countryName == 'USA') {
    return Flags.getFullFlag('US', 50, 50);
  }
  if (countryName == 'Uruguay') {
    return Flags.getFullFlag('UY', 50, 50);
  }
  if (countryName == 'Uzbekistan') {
    return Flags.getFullFlag('UZ', 50, 50);
  }
  if (countryName == 'Vanuatu') {
    return Flags.getFullFlag('VU', 50, 50);
  }
  if (countryName == 'Venezuela') {
    return Flags.getFullFlag('VE', 50, 50);
  }
  if (countryName == 'Vietnam') {
    return Flags.getFullFlag('VN', 50, 50);
  }
  if (countryName == 'U.S. Virgin Islands') {
    return Flags.getFullFlag('VG', 50, 50);
  }
  if (countryName == 'Yemen') {
    return Flags.getFullFlag('YE', 50, 50);
  }
  if (countryName == 'Zambia') {
    return Flags.getFullFlag('ZM', 50, 50);
  }
  if (countryName == 'Zimbabwe') {
    return Flags.getFullFlag('ZW', 50, 50);
  } else {
    return Flags.getFullFlag('IN', 50, 50);
  }
}
