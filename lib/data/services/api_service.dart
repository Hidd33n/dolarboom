import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://dolarapi.com/v1/dolares';

  Future<List<dynamic>> fetchDolares() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar la cotización del dólar');
    }
  }
}
