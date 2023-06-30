import 'package:flutter/material.dart';
import 'package:roxy1/model/movis.dart';
import 'package:roxy1/widget/cover_custom.dart';
import 'package:roxy1/widget/text_custom.dart';

class FutureBuilderCustom extends StatelessWidget {
  final Future<List<Movie>> fetch;
  const FutureBuilderCustom({super.key, required this.fetch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextCustom(
          text: "Populaires",
          fontSise: 25,
          fontWeight: FontWeight.bold,
          marginleft: 10,
          marginBottom: 20,
          marginTop: 20,
        ),
        FutureBuilder<List<Movie>>(
          future: fetch ,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final movies = snapshot.data;
              return Container(
                height: 350,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movies!.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return CoverCustom(
                        image:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        title: movie.title,
                        voteAverage: 1);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
