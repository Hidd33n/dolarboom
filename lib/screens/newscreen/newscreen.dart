import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatelessWidget {
  // Datos simulados de noticias
  final List<Map<String, String>> _newsArticles = [
    {
      'title': 'El dólar alcanza un nuevo máximo histórico',
      'description': 'El dólar ha subido un 5% en las últimas semanas debido a...'
    },
    {
      'title': 'Impacto del dólar en la economía local',
      'description': 'La fluctuación del dólar ha tenido efectos significativos en...'
    },
    {
      'title': 'Consejos para proteger tus ahorros del dólar',
      'description': 'Aquí te presentamos algunas estrategias para mitigar el impacto...'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _newsArticles.isEmpty
        ? Center(
            child: Text(
              'No hay noticias disponibles.',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _newsArticles.length,
            itemBuilder: (context, index) {
              final article = _newsArticles[index];
              return Card(
                color: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    article['title']!,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    article['description']!,
                    style: GoogleFonts.poppins(color: Colors.white70),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white),
                  onTap: () {
                    // Navegar a una pantalla de detalles de la noticia
                  },
                ),
              );
            },
          );
  }
}
