import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://dolarapi.com/v1/dolares';
  final String historicalApiUrl = 'https://api.argentinadatos.com/v1/cotizaciones/dolares';

  Future<List<dynamic>> fetchDolares() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar la cotización del dólar');
    }
  }

  Future<Map<String, List<dynamic>>> fetchHistoricalDolares() async {
    final response = await http.get(Uri.parse(historicalApiUrl));

    if (response.statusCode == 200) {
      // Suponemos que la respuesta es una lista de objetos con "casa"
      List<dynamic> data = jsonDecode(response.body);

      // Organizar los datos en un Map por tipo de dólar
      Map<String, List<dynamic>> historicalData = {};
      for (var item in data) {
        String casa = item['casa'];
        if (!historicalData.containsKey(casa)) {
          historicalData[casa] = [];
        }
        historicalData[casa]!.add(item);
      }

      return historicalData;
    } else {
      throw Exception('Error al cargar los datos históricos');
    }
  }

  // Agrega este método
  Future<List<dynamic>> fetchHistoricalDolaresByType(String tipoDolar) async {
    final response = await http.get(Uri.parse('$historicalApiUrl/$tipoDolar'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los datos históricos para $tipoDolar');
    }
  }
}
