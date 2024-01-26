import 'package:basic_2/pages/navigation_appbar.dart';
import 'package:flutter/material.dart';
import '../api/berita.dart';
import 'package:basic_2/api/berita.dart' as berita_api;
import '../models/berita_models.dart';
import 'detail_pages.dart';
import '../arguments/berita_arguments.dart';
import 'package:google_fonts/google_fonts.dart';

class ListBeritaUI extends StatelessWidget {
  const ListBeritaUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Berita>>(
        future: berita_api.loadBerita(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news found.'));
          }

          final beritaList = snapshot.data!;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Bagian 'Today News', 'Latest News', dan 'Hot News'
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today News',
                                style: GoogleFonts.k2d(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                'Wes, 08 January 2024',
                                style: GoogleFonts.k2d(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('assets/json/image/profil.jpg'),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Latest News Widget dengan data dinamis
                    Column(
                      children: [
                        // Row untuk judul 'Latest News'
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Latest News',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 220,
                          child: ListView.separated(
                            separatorBuilder: (_, __) => const SizedBox(
                              width: 12,
                            ),
                            itemCount: beritaList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final berita = beritaList[index];
                              return Container(
                                width: 250,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailBeritaUI.routeName,
                                      arguments: BeritaArguments(
                                        title: berita.title,
                                        description: berita.description,
                                        image: berita.urlToImage,
                                        author: berita.author,
                                        publishedAt: berita.publishedAt,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              berita.urlToImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        // berita.title.substring(1, 10),
                                        berita.title,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'by ${berita.author}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      // Text(
                                      //   // berita.description.substring(1, 45),
                                      //   berita.description,
                                      //   style: const TextStyle(
                                      //     fontSize: ,
                                      //     color: Colors.grey,
                                      //   ),
                                      //   maxLines: 1,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),

                    // Hot News Widget dengan data dinamis
                    Column(
                      children: [
                        // Row untuk judul 'Hot News'
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hot News',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: beritaList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final berita = beritaList[index];
                            return ListTile(
                              title: Text(
                                berita.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                berita.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: Container(
                                width: 60,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      berita.urlToImage,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailBeritaUI.routeName,
                                  arguments: BeritaArguments(
                                    title: berita.title,
                                    image: berita.urlToImage,
                                    description: berita.description,
                                    author: berita.author,
                                    publishedAt: berita.publishedAt,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [NavigationAppBar()],
                    // )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Headlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
