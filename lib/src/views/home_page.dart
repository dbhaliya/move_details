// ignore_for_file: , invalid_use_of_protected_member, unnecessary_string_interpolations, unnecessary_import, use_build_context_synchronously, avoid_print, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/constant/color.dart';
import 'package:movies/src/constant/string.dart';
import 'package:movies/src/model/home_model.dart';
import 'package:movies/src/utils/authantication.dart';
import 'package:movies/src/utils/collection.dart';
import 'package:movies/src/utils/shardprefrence.dart';
import 'package:movies/src/views/data_page.dart';
import 'package:movies/src/views/details_page.dart';
import 'package:movies/src/views/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController seachtf = TextEditingController();
  List<Temperatures> m1 = [];
  ValueNotifier<List<Temperatures>> searchedMovie = ValueNotifier([]);

  // List<HomeModel> searchedMovie = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key, // Assign the key to Scaffold.
      drawer: Drawer(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colorshelper.grey300,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3.7),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: MediaQuery.of(context).size.height / 8,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/image/film_icon.jpeg"),
                          ),
                          color: Colorshelper.grey100,
                          shape: BoxShape.circle),
                    ),
                  ),
                )
              ],
            ),
            Text(LocalDatabase.localDatabase.sh.getString("Email").toString()),
            Text(LocalDatabase.localDatabase.sh.getString("Uid").toString()),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  try {
                    bool logout =
                        await FirebaseAuthHelper.firebaseAuthHelper.logout();
                    if (logout) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    } else {
                      print("data");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colorshelper.grey200,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  alignment: Alignment.center,
                  child: const Text("Logout"),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            size: 20,
          ),
        ),
        title: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colorshelper.grey100,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: seachtf,
            onChanged: (value) {
              searchedMovie.value = m1
                  .where((element) => element.movieName!.contains(value))
                  .toList();
              searchedMovie.notifyListeners();
            },
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 20,
              ),
              contentPadding: EdgeInsets.all(10),
              border: InputBorder.none,
              hintText: Stringhelper.search,
              hintStyle: TextStyle(color: Colorshelper.grey200),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firebasecollection.firebasecollection.getData1(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.hasData) {
            var docs = snapshot.data!.docs;
            for (var doc in docs) {
              Map data = doc.data();
              Temperatures p1 = Temperatures(
                movieName: data['movie name'],
                details: data['details'],
                director: data['director'],
                movieData: data['movie data'],
                image: data['image'],
                movies: data['movie time'],
              );
              m1.add(p1);
            }
            return ValueListenableBuilder<List<Temperatures>>(
              valueListenable: searchedMovie,
              builder: (context, m2, _) {
                return m2.isNotEmpty
                    ? ListView.builder(
                        itemCount: m2.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    temp: Temperatures(
                                      movieName: m2[index].movieName,
                                      details: m2[index].details,
                                      director: m2[index].director,
                                      image: m2[index].image,
                                      movieData: m2[index].movieData,
                                      movies: m2[index].movies,
                                    ),
                                    doc: docs[index].id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 15,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colorshelper.grey100,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.8,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${m2[index].image}"),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        //color:  Colorshelper.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "${m2[index].movieName}",
                                          style: GoogleFonts.poppins(
                                            color: Colorshelper.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                            // fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      // Text("${m2[index].director}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: m1.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    temp: Temperatures(
                                      movieName: m1[index].movieName,
                                      details: m1[index].details,
                                      image: m1[index].image,
                                      director: m1[index].director,
                                      movieData: m1[index].movieData,
                                      movies: m1[index].movies,
                                      //director: m2[index].director,
                                    ),
                                    doc: docs[index].id,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 15,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colorshelper.grey100,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${m1[index].image}"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${m1[index].movieName}",
                                              style: GoogleFonts.poppins(
                                                color: Colorshelper.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                                // fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 1,
        backgroundColor: Colors.green.shade200,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDataPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
