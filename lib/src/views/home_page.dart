import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/constant/color.dart';
import 'package:movies/src/constant/string.dart';
import 'package:movies/src/model/home_model.dart';
import 'package:movies/src/provider/provider.dart';
import 'package:movies/src/utils/collection.dart';
import 'package:movies/src/utils/shardprefrence.dart';
import 'package:movies/src/views/data_page.dart';
import 'package:movies/src/views/details_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController seachtf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('Movies')
        .where(
          'movie name',
          isEqualTo: seachtf.text,
        )
        .snapshots();
    return Scaffold(
      // Assign the key to Scaffold.
      drawer: Drawer(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  color: Colorshelper.primery,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.8,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 7,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image/film_icon.jpeg")),
                      shape: BoxShape.circle,
                      color: Colorshelper.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(LocalDatabase.localDatabase.sh.getString("Email").toString()),
          ],
        ),
      ),
      appBar: AppBar(
        title: Container(
          width: 300,
          decoration: BoxDecoration(
              color: Colorshelper.grey100,
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: seachtf,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Colors.black,
                size: 20,
              ),
              contentPadding: EdgeInsets.all(10),
              hintText: Stringhelper.search,
              hintStyle: TextStyle(color: Colorshelper.grey200),
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.only(
        //     left: 20,
        //     right: 10,
        //   ),
        //   child: TextField(
        //     controller: seachtf,
        //     decoration: const InputDecoration(
        //       hintText: 'Search',
        //     ),
        //     onChanged: (value) {
        //       setState(() {});
        //     },
        //   ),
        // ),
      ),

      body: seachtf.text.isNotEmpty
          ? StreamBuilder(
              stream: usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  homeModel: HomeModel(
                                    name: context
                                        .read<LoginProvider>()
                                        .data[index]
                                        .name,
                                    details: context
                                        .read<LoginProvider>()
                                        .data[index]
                                        .details,
                                    director: context
                                        .read<LoginProvider>()
                                        .data[index]
                                        .director,
                                    image: context
                                        .read<LoginProvider>()
                                        .data[index]
                                        .image,
                                    date: context
                                        .read<LoginProvider>()
                                        .data[index]
                                        .date,
                                    //director: m2[index].director,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              snapshot
                                  .data!.docChanges[index].doc['movie name'],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : StreamBuilder(
              stream: Firebasecollection.firebasecollection.getData1(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  var docs = snapshot.data!.docs;
                  for (var doc in docs) {
                    Map data = doc.data();
                    HomeModel p1 = HomeModel(
                      name: data['movie name'],
                      details: data['details'],
                      director: data['director'],
                      date: data['movie data'],
                      time: data['movie time'],
                      image: data['image'],
                    );
                    context.read<LoginProvider>().data.add(p1);
                  }
                  return ListView.builder(
                    itemCount: context.read<LoginProvider>().data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                homeModel: HomeModel(
                                  name: context
                                      .read<LoginProvider>()
                                      .data[index]
                                      .name,
                                  details: context
                                      .read<LoginProvider>()
                                      .data[index]
                                      .details,
                                  director: context
                                      .read<LoginProvider>()
                                      .data[index]
                                      .director,
                                  image: context
                                      .read<LoginProvider>()
                                      .data[index]
                                      .image,
                                  date: context
                                      .read<LoginProvider>()
                                      .data[index]
                                      .date,
                                  //director: m2[index].director,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 15,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 2.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colorshelper.grey100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${context.read<LoginProvider>().data[index].image}"),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Text(
                                      "${context.read<LoginProvider>().data[index].name}",
                                      style: GoogleFonts.poppins(
                                        color: Colorshelper.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                      ),
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
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddDataPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
