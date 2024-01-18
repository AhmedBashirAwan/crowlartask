import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/globals.dart';
import 'package:movies_app/screens/movie_panel.dart';

import '../api_services/api_services.dart';
import '../model/results_model.dart';

class DashBoard extends StatefulWidget {
  int id;
  String generName;
  DashBoard({super.key, required this.id, required this.generName});

  @override
  State<DashBoard> createState() => DashBoardState();
}

// it is displaying all the movies fetched from the TMDB API
class DashBoardState extends State<DashBoard> {
  bool barVisiblity = true;
  TextEditingController _searchingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  Visibility(
                    visible: barVisiblity,
                    child: Text(
                      widget.generName,
                      style: normalTextStyle(),
                    ),
                  ),
                  Visibility(
                    visible: barVisiblity == false ? true : false,
                    child: Container(
                      height: getHeight(context) * 0.055,
                      width: getWidth(context) * 0.73,
                      decoration: BoxDecoration(
                          color: GREY_COlOR,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _searchingController,
                            style: normalTextStyle(),
                            decoration: InputDecoration(
                              helperStyle: extraSmallTextStyle(),
                              hintText: "Search for the movie",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (barVisiblity == true) {
                            barVisiblity = false;
                          } else {
                            barVisiblity = true;
                          }
                        });
                      },
                      child: const Icon(Icons.search))
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: GREY_COlOR,
              child: FutureBuilder(
                future: fetchData(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Movies movies = snapshot.data as Movies;
                    bool filter = _searchingController.text.isEmpty;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: movies.results.length,
                      itemBuilder: (context, index) {
                        Movie movie = movies.results[index];
                        bool containsQuery = movie.title
                            .toLowerCase()
                            .contains(_searchingController.text.toLowerCase());
                        if (!filter && !containsQuery) {
                          return Container(); 
                        }
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
