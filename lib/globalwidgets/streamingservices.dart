// lib/widgets/streaming_services_list.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StreamingServicesList extends StatelessWidget {
  final List<Map<String, dynamic>> services;

  const StreamingServicesList({
    Key? key,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatterARS = NumberFormat.currency(locale: 'es_AR', symbol: '\$');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: services.map((service) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ExpansionTile(
            leading: SvgPicture.asset(
              service['iconPath'],
              width: 40,
              height: 40,
            ),
            title: Text(
              service['name'],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            children: service['subscriptions'].map<Widget>((subscription) {
              return ListTile(
                title: Text(
                  subscription['type'],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Text(
                  formatterARS.format(subscription['priceARS']),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
