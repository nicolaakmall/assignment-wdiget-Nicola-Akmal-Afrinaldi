import 'package:basic_2/arguments/berita_arguments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBeritaUI extends StatelessWidget {
  static const routeName = '/detail-berita';

  const DetailBeritaUI({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BeritaArguments;

    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    DateTime dateTime = dateFormat.parse(args.publishedAt, true);
    String formattedDate = DateFormat('dd MMMM yyyy - HH:mm').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              args.image,
              width: MediaQuery.of(context).size.width,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    args.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By ${args.author}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1,
                  ),
                  SizedBox(height: 8),
                  Text(
                    formattedDate,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1,
                  ),
                  SizedBox(height: 16),
                  Text(
                    args.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

