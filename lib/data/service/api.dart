import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newtronic_apps/data/model/response_api_model.dart';

class Api {
  static const String _baseUrl = 'http://103.183.75.112/api/directory/dataList';

  Future<ResponseApiModel?> fetchApi() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      ResponseApiModel responseApiModel = ResponseApiModel.fromJson(jsonData);
      return responseApiModel;
    } else {
      throw Exception('Failed Get Api');
    }
  }
}
