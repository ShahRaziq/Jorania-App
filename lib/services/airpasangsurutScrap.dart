import 'dart:developer';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class AirPasangSurut {
  Future<Map<String, Map<String, String>>> extractData(String kawasan) async {
    // Getting the response from the targeted url
    Map<String, String> location = {
      "Pulau Langkawi":
          "https://www.jupem.gov.my/staps/stesen-pulau-langkawi-kedah-1",
      "Pulau Pinang": "https://www.jupem.gov.my/staps/stesen-pulau-pinang-1",
      "Lumut": "https://www.jupem.gov.my/staps/stesen-lumut-perak-1",
      "Pelabuhan Klang":
          "https://www.jupem.gov.my/staps/stesen-pelabuhan-klang-selangor",
      "Tanjung Keling":
          "https://www.jupem.gov.my/staps/stesen-tanjung-keling-melaka-1",
      "Kukup": "https://www.jupem.gov.my/staps/stesen-kukup-johor",
      "Johor Bahru":
          "https://www.jupem.gov.my/staps/stesen-johor-bahru-johor-1",
      "Tanjung Sedili":
          "https://www.jupem.gov.my/staps/stesen-tanjung-sedili-johor-1",
      "Pulau Tioman":
          "https://www.jupem.gov.my/staps/stesen-pulau-tioman-pahang-1",
      "Tanjung Gelang":
          "https://www.jupem.gov.my/staps/stesen-tanjung-gelang-pahang-1",
      "Cendering":
          "https://www.jupem.gov.my/staps/stesen-cendering-terengganu-1",
      "Geting": "https://www.jupem.gov.my/staps/stesen-geting-kelantan-1",
      "Pulau Lakei":
          "https://www.jupem.gov.my/staps/stesen-pulau-lakei-sarawak-1",
      "Sejingkat": "https://www.jupem.gov.my/staps/stesen-sejingkat-sarawak-1",
      "Bintulu": "https://www.jupem.gov.my/staps/stesen-bintulu-sarawak-1",
      "Miri": "https://www.jupem.gov.my/staps/stesen-miri-sarawak-1",
      "Kota Kinabalu":
          "https://www.jupem.gov.my/staps/stesen-kota-kinabalu-sabah-1",
      "Kudat": "https://www.jupem.gov.my/staps/stesen-kudat-sabah-1",
      "Sandakan": "https://www.jupem.gov.my/staps/stesen-sandakan-sabah-1",
      "Lahat Datu": "https://www.jupem.gov.my/staps/stesen-lahad-datu-sabah-1",
      "Tawau": "https://www.jupem.gov.my/staps/stesen-tawau-sabah-1",
      "Labuan": "https://www.jupem.gov.my/staps/stesen-labuan-wp-labuan-1",
    };
    final response =
        await http.Client().get(Uri.parse(location[kawasan].toString()));
    Map<String, Map<String, String>> data = {};
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //date day 1
        var date1 =
            document.getElementsByClassName('card')[0].children[0].text.trim();
        var date2 =
            document.getElementsByClassName('card')[1].children[0].text.trim();

        double table1Size = (document
                    .getElementsByClassName('card')[0]
                    .children[1]
                    .children[0]
                    .children[0]
                    .children[0]
                    .children[1]
                    .nodes
                    .length -
                1) /
            2;
        double table2Size = (document
                    .getElementsByClassName('card')[1]
                    .children[1]
                    .children[0]
                    .children[0]
                    .children[0]
                    .children[1]
                    .nodes
                    .length -
                1) /
            2;

        log(table1Size.toString());
        log(table2Size.toString());

        Map<String, String> data1 = {};
        Map<String, String> data2 = {};

        // for table 1 (current day)
        for (int i = 0; i < table1Size.toInt(); i++) {
          var time = document
              .getElementsByClassName('card')[0]
              .children[1]
              .children[0]
              .children[0]
              .children[0]
              .children[1]
              .children[i]
              .children[0];
          var height = document
              .getElementsByClassName('card')[0]
              .children[1]
              .children[0]
              .children[0]
              .children[0]
              .children[1]
              .children[i]
              .children[1];

          data1.addAll({time.text.trim(): height.text.trim()});
        }
        //   for table 2 (next day)
        for (int i = 0; i < table2Size.toInt(); i++) {
          var time = document
              .getElementsByClassName('card')[1]
              .children[1]
              .children[0]
              .children[0]
              .children[0]
              .children[1]
              .children[i]
              .children[0];
          var height = document
              .getElementsByClassName('card')[1]
              .children[1]
              .children[0]
              .children[0]
              .children[0]
              .children[1]
              .children[i]
              .children[1];

          data2.addAll({time.text.trim(): height.text.trim()});
        }
        log(date1);
        log(data1.toString());
        log(date2);
        log(data2.toString());
        data.addAll({date1: data1});
        data.addAll({date2: data2});
      } catch (e) {
        log(e.toString());
      }
    } else {
      log(response.statusCode.toString());
    }
    return data;
  }
}
