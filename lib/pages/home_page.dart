import 'package:flutter/material.dart';

import 'package:myflix_app/models/movie_model.dart';
import 'package:myflix_app/pages/movie_details.dart';
import 'package:myflix_app/repositories/get_movies_data.dart';

class HomePage extends StatefulWidget {
  static const route = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String logoImg = 'asset/images/Netflix-Logo.png';
  bool viewInputSearch = false;
  TextEditingController inputSearch = TextEditingController();

  /// istanzio una variabile che in 'futuro' accoglierà la mia lista di film
  late Future<List<MovieModel>> movies;

  @override
  void initState() {
    super.initState();

    /// al caricamento del widget prendo dalla chiamata http i miei film
    movies = GetMoviesData.popular();
  }

  void returnHome() {
    setState(() {
      movies = GetMoviesData.popular();
    });
    Navigator.pop(context);
  }

  void searchMovie() {
    setState(() {
      movies = GetMoviesData.search(inputSearch.text);
    });
    inputSearch.clear();
  }

  void openViewInpuSearch() {
    setState(() {
      viewInputSearch = true;
    });
  }

  void closeViewInpuSearch() {
    setState(() {
      viewInputSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: Drawer(
        child: drawer(),
      ),
    );
  }

  AppBar appBar() => AppBar(
        title: Image.asset(
          logoImg,
          width: 120,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: [
          !viewInputSearch
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: openViewInpuSearch,
                )
              : IconButton(
                  onPressed: closeViewInpuSearch,
                  icon: Icon(Icons.close),
                ),
        ],
        bottom: inputText(),
      );

  PreferredSize? inputText() => !viewInputSearch
      ? null
      : PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              title: TextField(
                controller: inputSearch,
                cursorColor: Colors.white54,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white54,
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: searchMovie,
              ),
            ),
          ),
        );

  Widget body() => Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16),

        /// il future builder renderizza la mia future(chiamata http)
        /// bisogna passare il tipo di ritorno della future
        child: FutureBuilder<List<MovieModel>>(
          /// qui bisogna passare la mia future
          /// cioè la variabile in cui deposito il contenuto della mia chiamata
          future: movies,

          /// qui gestisco il widget che devo renderizzare
          builder: (context, snapshot) {
            /// verifico se la chiamata ha ricevuto risposta
            if (snapshot.connectionState != ConnectionState.done) {
              /// fin quando la chiamata non riceva risposta visualizzo un loader
              return Center(child: CircularProgressIndicator());
            } else {
              /// questo è il componente da renderizzare se la chiamata è conclusa
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetails.route,
                      arguments: MovieDetailsArgs(movie: snapshot.data![index]),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Stack(
                      children: [
                        Image.network(
                          snapshot.data![index].imagePath,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.darken,
                          color: Colors.black26,
                        ),
                        Positioned(
                          bottom: 0,
                          //top: 100,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );

  Widget drawer() => SafeArea(
        child: ListView(
          children: [
            Image.asset(
              logoImg,
              width: double.infinity,
              height: 60,
            ),
            Divider(),
            InkWell(
              onTap: returnHome,
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            Divider(),
          ],
        ),
      );
}
