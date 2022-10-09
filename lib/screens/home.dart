import 'package:flutter/material.dart';
import 'package:movie_app/screens/description.dart';
import 'package:tmdb_api/tmdb_api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = 'adfd35d69baeb189d18b5f7fc3f8df3c';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZkMzVkNjliYWViMTg5ZDE4YjVmN2ZjM2Y4ZGYzYyIsInN1YiI6IjYzM2Q1MWQ1NDJmMTlmMDA4MTk2ZWYzMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._WsS0JXJKTjIgHs7xSKSEUSFaFNT0DU0VL_eBduzOHE';

  List personsList = [];
  List imagesList = [];
  int id = 28782; //just for test

  loadpersons() async {
    TMDB tmdbWithCustomLogs = TMDB(
      //TMDB instance
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true, //must be true than only all other logs will be shown
        showErrorLogs: true,
      ),
    );
    Map personResult = await tmdbWithCustomLogs.v3.people.getPopular();
    Map photoResult = await tmdbWithCustomLogs.v3.people.getImages(id);

    setState(() {
      personsList = personResult['results'];
      imagesList = photoResult['profiles'];
    });
    print(imagesList);
  }

  @override
  void initState() {
    loadpersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("The Movie App🔥"),
      ),
      body: ListView.builder(
          itemCount: personsList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                  name: personsList[index]['name'],
                                  image: 'https://image.tmdb.org/t/p/w500' +
                                      personsList[index]['profile_path'],
                                  info: personsList[index]['known_for'][0]
                                          ['overview']
                                      .toString(),
                                  id: personsList[index]['id'],
                                  images: imagesList,
                                )));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white24,
                    child: Row(
                      children: [
                        Image.network('https://image.tmdb.org/t/p/w500' +
                                    personsList[index]['profile_path']
                                        .toString() !=
                                null
                            ? 'https://image.tmdb.org/t/p/w500' +
                                personsList[index]['profile_path'].toString()
                            : ''.toString()),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              personsList[index]['name'] ?? 'loading',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              personsList[index]['known_for_department'] ??
                                  'loading',
                              style: const TextStyle(
                                  fontSize: 15, letterSpacing: 3.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
