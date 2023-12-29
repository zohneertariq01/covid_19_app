import 'dart:convert';

import 'package:covid_19_app/Services/Utilities/api_url.dart';

import '../Model/world_state_model.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> getWorldApi() async {
    var response = await http.get(Uri.parse(AppUrl.worldStateUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getCountriesApi() async {
    var response = await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
