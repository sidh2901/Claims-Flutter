import 'dart:io';

import 'package:web_admin/models/claims.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Claims>?> getClaims() async {
    var client = http.Client();
    var uri = Uri.parse('http://20.62.171.46:9000/claims');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return claimsFromJson(json);
    }
  }
}
