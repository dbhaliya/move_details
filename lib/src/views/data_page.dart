// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:movies/src/constant/color.dart';
import 'package:movies/src/constant/string.dart';
import 'package:movies/src/views/home_page.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  String? urlDownload;
  XFile? image;
  UploadTask? uploadTask;
  TextEditingController datetxt = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController titletxt = TextEditingController();
  TextEditingController disctxt = TextEditingController();
  TextEditingController directxt = TextEditingController();
  GlobalKey<FormState> detailskey = GlobalKey<FormState>();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage stref = FirebaseStorage.instance;

  Future<void> uploadurl() async {
    String uploadFilename = '${DateTime.now().microsecondsSinceEpoch}.jpg';

    Reference refrence = stref.ref().child('Movies').child(uploadFilename);
    UploadTask uploadTask = refrence.putFile(File(image!.path));

    uploadTask.snapshotEvents.listen((event) {});

    await uploadTask.whenComplete(
      () async {
        var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

        try {
          if (uploadPath.isNotEmpty) {
            await firebaseFirestore.collection('Movie').doc().set(
              {
                'movie name': titletxt.text,
                'image': uploadPath,
                'director': directxt.text,
                'details': disctxt.text,
                'movie time': timeinput.text,
                'movie data': datetxt.text,
              },
            ).then(
              (value) => const Text("record insert"),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data is not inser'),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('error'),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Page"),
      ),
      body: Form(
        key: detailskey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        setState(() {});
                      } catch (e) {
                        print("**********error");
                      }
                    },
                    child: image == null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: const BoxDecoration(),
                            child: Image.asset("assets/image/film_icon.jpeg"),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(File(image!.path),
                                  fit: BoxFit.cover),
                            ),
                          ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Stringhelper.title;
                    }
                    return null;
                  },
                  controller: titletxt,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colorshelper.grey300),
                    ),
                    hintText: Stringhelper.title,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 4,
                  maxLines: 6,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Stringhelper.desc;
                    }
                    return null;
                  },
                  controller: disctxt,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colorshelper.grey300),
                    ),
                    hintText: Stringhelper.desc,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return Stringhelper.director;
                    }
                    return null;
                  },
                  controller: directxt,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colorshelper.grey300),
                    ),
                    hintText: Stringhelper.director,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: datetxt,
                        readOnly: true,
                        onTap: () async {
                          await datePicker();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Stringhelper.release;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colorshelper.grey300),
                          ),
                          hintText: Stringhelper.release,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: timeinput,
                        onTap: () {
                          timePicker();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Stringhelper.reviews;
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colorshelper.grey300),
                          ),
                          hintText: Stringhelper.reviews,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colorshelper.primery,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            Stringhelper.cancel,
                            style: TextStyle(
                              color: Colorshelper.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          try {
                            if (detailskey.currentState!.validate()) {
                              uploadurl();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('error'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colorshelper.primery,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            Stringhelper.submit,
                            style: TextStyle(
                              color: Colorshelper.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future datePicker() async {
    final DateTime? result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (result != null) {
      dateTime = result;
      datetxt.text = result.toString().substring(0, 10);
      setState(() {});
    }
  }

  Future timePicker() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      timeOfDay = time;
      timeinput.text = time.format(context);
      setState(() {});
    }
  }
}
