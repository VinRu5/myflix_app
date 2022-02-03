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
  String imgJumbo =
      'https://www.nerdgate.it/wp-content/uploads/2020/09/unnamed-1-694x1024.jpg';

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
      backgroundColor: Colors.black,
      body: body(),
      drawer: Drawer(
        child: drawer(),
      ),
    );
  }

  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.white12,
        pinned: true,
        expandedHeight: 250,
        flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
            imgJumbo,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
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
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: inputSearch,
              cursorColor: Colors.white54,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchMovie,
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white70,
                  ),
                ),
                filled: true,
                fillColor: Colors.black87,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        );

  Widget body() => Container(
        // width: double.infinity,
        // height: double.infinity,
        // padding: EdgeInsets.all(16),

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
              ///
              return CustomScrollView(
                slivers: [
                  appBar(),
                  gridMovie(snapshot),
                  footer(),
                ],
              );
            }
          },
        ),
      );

  Widget gridMovie(snapshot) => SliverPadding(
        padding: const EdgeInsets.only(top: 16),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
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
                            color: Colors.white,
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
            childCount: snapshot.data!.length,
          ),
        ),
      );

  Widget footer() => SliverToBoxAdapter(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Diritti riservati a Netflix',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ));

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
