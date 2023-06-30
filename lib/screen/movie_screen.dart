// ignore_for_file: sort_child_properties_last, unnecessary_null_comparison
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:roxy1/screen/details_screen.dart';
import 'package:roxy1/service/api_movis.dart';
import 'package:roxy1/constant/colors.dart';
import 'package:roxy1/model/movis.dart';
import 'package:roxy1/widget/cover_custom.dart';
import 'package:roxy1/widget/text_custom.dart';

class MovieScreen extends StatefulWidget {
  final List<dynamic>? movies;
  const MovieScreen({
    super.key,
    this.movies,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<dynamic> tv = [];
  List<dynamic> animations = [];
  List<dynamic> people = [];
  @override
  void initState() {
    super.initState();
    fetchTv();
    fetchAnimations();
    fetchPeople();
  }

  Future<void> fetchTv() async {
    try {
      final data = await MovieApi.getTVShows();
      setState(() {
        tv = data;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  Future<void> fetchAnimations() async {
    try {
      final data = await MovieApi.getAnimations();
      setState(() {
        animations = data;
      });
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }

  Future<void> fetchPeople() async {
    try {
      final data = await MovieApi.getPopularPeople();
      setState(() {
        people = data;
      });
    } catch (e) {
      print('Error fetching popular people: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return tv == null || tv.isEmpty
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.danger,
            ),
          )
        : Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'ROXY',
                style: TextStyle(
                    color: AppColors.danger, fontSize: 35, letterSpacing: 10),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<Movie>>(
                    future: MovieApi.fetchTrendingMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 80),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.danger,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        final movies = snapshot.data;
                        return CarouselSlider.builder(
                          itemCount: movies!.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                              int pageIndex) {
                            final movie = movies[itemIndex];
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                    fit: BoxFit.cover,
                                    width: 500,
                                  ),
                                ),
                                Container(
                                  child: TextCustom(
                                    textAlign: TextAlign.center,
                                    text: movie.title.toUpperCase(),
                                    fontSise: 18,
                                    marginBottom: 60,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  decoration: const BoxDecoration(
                                      gradient: AppColors.bgCarde),
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40.0),
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors
                                            .danger, // Text Color (Foreground color)
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsScreen(
                                                movieId: movie.id,
                                              ),
                                            ));
                                      },
                                      child: Text("play")),
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                              height: 400,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              reverse: true),
                        );
                      }
                    },
                  ),
                  const TextCustom(
                    text: "Populaires",
                    fontSise: 25,
                    fontWeight: FontWeight.bold,
                    marginleft: 10,
                    marginBottom: 20,
                    marginTop: 20,
                  ),
                  FutureBuilder<List<Movie>>(
                    future: MovieApi.fetchMovies(),
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
                                  body: movie.overview,
                                  voteAverage: movie.voteAverage);
                            },
                          ),
                        );
                      }
                    },
                  ),
                  const TextCustom(
                    text: "TV Shows",
                    fontSise: 25,
                    fontWeight: FontWeight.bold,
                    marginleft: 10,
                    marginBottom: 20,
                    marginTop: 20,
                  ),
                  Container(
                    height: 350,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: tv.length,
                        itemBuilder: (context, index) {
                          final tvindex = tv[index];
                          return CoverCustom(
                            image:
                                'https://image.tmdb.org/t/p/w500${tvindex['poster_path']}',
                            title: tvindex['original_name'],
                            voteAverage: 4.6,
                            body: tvindex['overview'],
                          );
                        }),
                  ),
                  const TextCustom(
                    text: "Animations",
                    fontSise: 25,
                    fontWeight: FontWeight.bold,
                    marginleft: 10,
                    marginBottom: 20,
                    marginTop: 20,
                  ),
                  SizedBox(
                    height: 350,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: animations.length,
                        itemBuilder: (context, index) {
                          final animationindex = animations[index];
                          return CoverCustom(
                            width: 300,
                            image:
                                'https://image.tmdb.org/t/p/w500${animationindex['backdrop_path']}',
                            title: animationindex['original_title'],
                            body: animationindex['overview'],
                            voteAverage: 7.6,
                          );
                        }),
                  ),
                  const TextCustom(
                    text: "persone",
                    fontSise: 25,
                    fontWeight: FontWeight.bold,
                    marginleft: 10,
                    marginBottom: 20,
                    marginTop: 20,
                  ),
                  // Container(
                  //   height: 360,
                  //   child: ListView.builder(
                  //       itemCount: people.length,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         final peopleIndex = people[index];
                  //         return Container(
                  //           child: ClipRRect(
                  //             child: Image.network(
                  //                'https://image.tmdb.org/t/p/w200${peopleIndex['backdrop_path']}',
                  //               fit: BoxFit.cover,
                  //               width: 100,
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  // )
                ],
              ),
            ),
          );
  }
}
