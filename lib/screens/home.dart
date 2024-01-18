import 'package:flutter/material.dart';
import 'package:movies_app/api_services/api_services.dart';
import 'package:movies_app/globals.dart';
import 'package:movies_app/screens/dashboard.dart';
import '../model/genre_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

///This Screen is for all the geners, I wasn't able to find any pictures for the geners in the TMDB APi
///so I used the random colors
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Choose Genre',
                    style: headingTextStyle(Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: GREY_COlOR,
              child: FutureBuilder(
                future: fetchGenre(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Genre> genres = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(snapshot.data!.length, (index) {
                        Color genreColor =
                            GENERS_COLORS[index % GENERS_COLORS.length];
                        return InkWell(
                          onTap: () {
                            ///here is the navigation to next screen
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DashBoard(
                                      id: genres[index].id,
                                      generName: genres[index].name,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: genreColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: getHeight(context) * 0.3,
                              child: Stack(
                                children: [
                                  const ClipRRect(
                                      //   borderRadius: BorderRadius.circular(15),
                                      //   child: Image.network(
                                      //     'https://image.tmdb.org/t/p/w500${}',
                                      //     fit: BoxFit.cover,
                                      //     width: double.infinity,
                                      //     height: double.infinity,
                                      //   ),
                                      ),
                                  Align(
                                    alignment: const Alignment(-0.7, 0.8),
                                    child: Text(
                                      genres[index].name,
                                      style: headingTextStyle(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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
