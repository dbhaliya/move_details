// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

import 'package:movies/src/provider/signup_provider.dart';
import 'package:movies/src/utils/authantication.dart';
import 'package:movies/src/views/login.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  CreateProvider? ProviderTrue;
  CreateProvider? ProviderFalse;
  @override
  Widget build(BuildContext context) {
    ProviderTrue = Provider.of<CreateProvider>(context, listen: true);
    ProviderFalse = Provider.of<CreateProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: ProviderTrue!.key,
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/image/create.png",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 8.h,
                      //color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: ProviderTrue!.txtEmail,
                        decoration: InputDecoration(
                            hintText: "E-mail",
                            hintStyle:
                                TextStyle(fontSize: 15.sp, color: Colors.black),
                            suffixIcon: const Icon(
                              Icons.mail,
                              color: Colors.blueAccent,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your E-mail";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please Enter Valid Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      height: 8.h,
                      //color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      child: TextFormField(
                        controller: ProviderTrue!.txtPassword,
                        obscureText: ProviderTrue!.hide,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                          suffixIcon: InkWell(
                            onTap: () {
                              ProviderTrue!.chnageicon(!ProviderTrue!.hide);
                            },
                            child: Icon(
                              ProviderTrue!.hide
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Password";
                          } else if (value.length != 8) {
                            return "Please Enter Maximum 8 Character";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: InkWell(
                        onTap: () async {
                          if (ProviderTrue!.key.currentState!.validate()) {
                            bool signup = await FirebaseAuthHelper
                                .firebaseAuthHelper
                                .sign_up(ProviderTrue!.txtEmail.text,
                                    ProviderTrue!.txtPassword.text);

                            if (signup) {
                              ProviderTrue!.txtEmail.clear();
                              ProviderTrue!.txtPassword.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("error")));
                            }
                          }
                        },
                        child: Container(
                          height: 6.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Colors.blueAccent.shade700,
                            Colors.blue.shade300,
                          ])),
                          alignment: Alignment.center,
                          child: Text(
                            "Sigh up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21.sp),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: Container(
                        height: 6.h,
                        width: 80.w,
                        alignment: Alignment.center,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            InkWell(
                              onTap: () {
                                try {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ));
                                } catch (e) {
                                  print('$e');
                                }
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                  fontSize: 15.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
