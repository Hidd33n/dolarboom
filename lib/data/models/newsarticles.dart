// lib/data/models/newsarticles.dart

import 'package:webfeed/domain/rss_item.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class NewsArticle {
  final String title;
  final String description;
  final String link;
  final DateTime pubDate;
  final String imageUrl; // Nuevo campo para la imagen

  NewsArticle({
    required this.title,
    required this.description,
    required this.link,
    required this.pubDate,
    required this.imageUrl, // Inicializado en el constructor
  });

  factory NewsArticle.fromXml(RssItem item) {
    // Intentamos extraer la imagen del RSS
    String imageUrl = '';

    // webfeed soporta media:content y enclosures
    if (item.media?.thumbnails != null && item.media!.thumbnails!.isNotEmpty) {
      imageUrl = item.media!.thumbnails!.first.url ?? '';
    } else if (item.enclosure != null && item.enclosure!.url != null) {
      imageUrl = item.enclosure!.url!;
    }

    // Limpiar la descripción eliminando etiquetas HTML
    String cleanedDescription = '';
    if (item.description != null) {
      dom.Document document = html_parser.parse(item.description!);
      cleanedDescription = document.body?.text ?? '';
    }

    // Limpiar el título para eliminar posibles etiquetas HTML
    String cleanedTitle = '';
    if (item.title != null) {
      dom.Document titleDocument = html_parser.parse(item.title!);
      cleanedTitle = titleDocument.body?.text ?? 'Sin título';
    }

    return NewsArticle(
      title: cleanedTitle, // Usar el título limpio
      description: cleanedDescription, // Usar la descripción limpia
      link: item.link ?? '',
      pubDate: item.pubDate ?? DateTime.now(),
      imageUrl: imageUrl,
    );
  }
}
