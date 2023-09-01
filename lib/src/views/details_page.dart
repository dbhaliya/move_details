// ignore_for_file: iterable_contains_unrelated_type, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/constant/color.dart';
import 'package:movies/src/model/home_model.dart';
import 'package:movies/src/utils/collection.dart';

class DetailsPage extends StatefulWidget {
  final Temperatures temp;
  final String doc;
  const DetailsPage({
    super.key,
    required this.temp,
    required this.doc,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double num = 0.0;
  TextEditingController review = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.temp.movieName.toString(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 15,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.height / 1,
                    child: Image.network(
                      widget.temp.image.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      widget.temp.movieName.toString(),
                      style: GoogleFonts.poppins(
                        color: Colorshelper.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.temp.director.toString(),
                  style: GoogleFonts.poppins(
                    color: Colorshelper.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: num,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        num = rating;
                        setState(() {});
                        print(rating);
                      },
                    ),
                    Text(num.toString()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Details",
                  style: GoogleFonts.poppins(
                    color: Colorshelper.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  widget.temp.details.toString(),
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 132, 132, 132),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rating'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: num,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 20,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(
                    () {
                      num = rating;
                    },
                  );
                  print(rating);
                },
              ),
              Text(num.toString()),
              TextFormField(
                controller: review,
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                Firebasecollection.firebasecollection.update(
                  Temperatures(
                    rating: [
                      Rating(disc: review.text, star: num, uid: widget.doc),
                    ],
                  ),
                  widget.doc,
                );
              },
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
            ),
          ],
        );
      },
    );
  }
}