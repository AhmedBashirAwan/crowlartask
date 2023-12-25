import 'package:flutter/material.dart';
import 'package:movies_app/globals.dart';
import 'package:movies_app/screens/trailer_screen.dart';
import 'package:video_player/video_player.dart';

import '../model/results_model.dart';

// ignore: must_be_immutable
class MovieScreen extends StatefulWidget {
  Movie movie;
  MovieScreen({required this.movie, super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller with the trailer URL
    _controller = VideoPlayerController.network('URL_TO_YOUR_TRAILER_VIDEO');
    _controller!.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose the video player controller when the screen is disposed
    _controller!.dispose();
    super.dispose();
  }

  void _playTrailer() async {
    // Play the trailer
    await _controller!.play();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrailerScreen()),
    );

    if (_controller!.value.isPlaying) {
      _controller!.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(context) * 0.53,
              child: Stack(
                children: [
                  SizedBox(
                    height: getHeight(context) * 0.53,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-0.8, -0.8),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: LIGHT_COLOR,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Watch",
                          style: headingTextStyle(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.37),
                    child: Text(
                      "In Theaters December ${widget.movie.releaseDate}",
                      style: headingTextStyle(),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.64),
                    child: SizedBox(
                      height: getHeight(context) * 0.07,
                      width: getWidth(context) * 0.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BUTTON_COLOR,
                            foregroundColor: LIGHT_COLOR,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Get Ticket',
                            style: smallTextStyle(),
                          )),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.96),
                    child: SizedBox(
                      height: getHeight(context) * 0.07,
                      width: getWidth(context) * 0.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: BUTTON_COLOR, width: 2.0)),
                          ),
                          onPressed: _playTrailer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: LIGHT_COLOR,
                              ),
                              Text(
                                'Watch Trailer',
                                style: smallTextStyle(),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                "Genres",
                style: normalTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.movie.genreIds.length,
                      itemBuilder: (context, index) {
                        int genreId = widget.movie.genreIds[index];
                        String genreName = genresName(genreId);
                        Color genreColor =
                            GENERS_COLORS[index % GENERS_COLORS.length];
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: genreColor,
                          ),
                          child: Center(
                            child: Text(
                              genreName,
                              style: smallTextStyle(),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                "Overview",
                style: normalTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: RichText(
                  text: TextSpan(
                text: widget.movie.overview,
                style: extraSmallTextStyle(Colors.black),
              )),
            ),
          ],
        ),
      )),
    );
  }
}

String genresName(int genreId) {
  String genreName;
  switch (genreId) {
    case 28:
      genreName = "Action";
      break;
    case 12:
      genreName = "Adventure";
      break;
    case 16:
      genreName = "Animation";
      break;
    case 35:
      genreName = "Comedy";
      break;
    case 80:
      genreName = "Crime";
      break;
    case 99:
      genreName = "Documentary";
      break;
    case 18:
      genreName = "Drama";
      break;
    case 10751:
      genreName = "Family";
      break;
    case 14:
      genreName = "Fantasy";
      break;
    case 36:
      genreName = "History";
      break;
    case 27:
      genreName = "Horror";
      break;
    case 10402:
      genreName = "Music";
      break;
    case 9648:
      genreName = "Mystery";
      break;
    case 10749:
      genreName = "Romance";
      break;
    case 878:
      genreName = "Science Fiction";
      break;
    case 10770:
      genreName = "TV Movie";
      break;
    case 53:
      genreName = "Thriller";
      break;
    case 10752:
      genreName = "War";
      break;
    case 37:
      genreName = "Western";
      break;
    default:
      genreName = "Unknown Genre";
      break;
  }
  return genreName;
}
