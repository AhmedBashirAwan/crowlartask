import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/globals.dart';
import 'package:movies_app/screens/movie_panel.dart';

import '../api_services/api_services.dart';
import '../model/results_model.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => DashBoardState();
}

// it is displaying all the movies fetched from the TMDB API
class DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    // Object? genre_ID = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                  Text(
                    'Watch',
                    style: normalTextStyle(),
                  ),
                  const Spacer(),
                  const Icon(Icons.search)
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: GREY_COlOR,
              child: FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Movies movies = snapshot.data as Movies;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: movies.results.length,
                      itemBuilder: (context, index) {
                        Movie movie = movies.results[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MovieScreen(
                                        movie: movie,
                                      )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: getHeight(context) * 0.3,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.7, 0.6),
                                    child: Text(
                                      movie.title,
                                      style: headingTextStyle(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
