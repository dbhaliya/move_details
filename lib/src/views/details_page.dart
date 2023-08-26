import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/src/constant/color.dart';
import 'package:movies/src/model/home_model.dart';

class DetailsPage extends StatefulWidget {
  final HomeModel homeModel;
  const DetailsPage({super.key, required this.homeModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.homeModel.name.toString()),
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
                    widget.homeModel.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                widget.homeModel.name.toString(),
                style: GoogleFonts.poppins(
                  color: Colorshelper.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.homeModel.director.toString(),
                style: GoogleFonts.poppins(
                  color: Colorshelper.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Date :",
              //       style: GoogleFonts.poppins(
              //         color: Colorshelper.black,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Text(
              //       widget.homeModel.date.toString(),
              //       style: GoogleFonts.poppins(
              //         color: Colorshelper.black,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Deatils",
                style: GoogleFonts.poppins(
                  color: Colorshelper.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.homeModel.details.toString(),
                style: GoogleFonts.poppins(
                  color: Colorshelper.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
