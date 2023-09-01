// ignore_for_file: camel_case_types

// class HomeModel {
//   String? time;
//   String? date;
//   String? name;
//   String? director;
//   String? details;
//   String? image;
//   List<ratingModel>? rating;

//   HomeModel({
//     this.date,
//     this.details,
//     this.director,
//     this.name,
//     this.time,
//     this.image,
//     this.rating,
//   });
// }

// class ratingModel {
//   String? disc;
//   String? uid;
//   int? star;

//   ratingModel({this.disc, this.uid, this.star});
// }

// class Temperatures {
//   String? details;
//   String? director;
//   String? image;
//   String? moviesData;
//   String? moviesName;
//   String? moviesTime;
//   List<Rating>? rating;
//   Temperatures({
//      this.details,
//      this.director,
//      this.image,
//      this.moviesData,
//      this.moviesName,
//      this.moviesTime,
//      this.rating,
//   });
// }
// class Rating {
//   String? disc;
//   String? star;
//   String? uid;
//   Rating({
//      this.disc,
//      this.star,
//      this.uid,
//   });
// }
// To parse this JSON data, do

//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

Temperatures temperaturesFromJson(String str) =>
    Temperatures.fromJson(json.decode(str));

String temperaturesToJson(Temperatures data) => json.encode(data.toJson());

class Temperatures {
  String? details;
  String? director;
  String? image;
  String? movieData;
  String? movieName;
  String? movies;
  List<Rating>? rating;

  Temperatures({
    this.details,
    this.director,
    this.image,
    this.movieData,
    this.movieName,
    this.movies,
    this.rating,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
        details: json["details"],
        director: json["director"],
        image: json["image"],
        movieData: json["movies data"],
        movieName: json["movie name"],
        movies: json["movie time"],
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "details": details,
        "director": director,
        "image": image,
        "movie data": movieData,
        "movie name": movieName,
        "movie time": movies,
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
      };
}

class Rating {
  String? disc;
  double? star;
  String? uid;

  Rating({
    this.disc,
    this.star,
    this.uid,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        disc: json["disc"],
        star: json["star"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "disc": disc,
        "star": star,
        "uid": uid,
      };
}
