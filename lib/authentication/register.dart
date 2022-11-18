// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_collection_literals, prefer_if_null_operators, prefer_typing_uninitialized_variables, unused_local_variable, avoid_init_to_null, unnecessary_null_comparison, curly_braces_in_flow_control_structures, avoid_print, constant_identifier_names, body_might_complete_normally_nullable, non_constant_identifier_names, must_be_immutable, library_private_types_in_public_api, depend_on_referenced_packages, use_build_context_synchronously

// import 'dart:html';

// import 'dart:html';
// import 'dart:io';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/login.dart';

// void main() {
// }

class Registering extends StatefulWidget {
  const Registering({Key? key}) : super(key: key);

  @override
  _RegisteringState createState() => _RegisteringState();
}

class _RegisteringState extends State<Registering> {
//text controllers
  TextEditingController first_name = TextEditingController();
  TextEditingController middle_name = TextEditingController();
  TextEditingController sur_name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController registration_number = TextEditingController();

  Future upload() async {
    // 192.168.43.251
    // 192.168.43.251
    const url = 'http://192.168.43.132:8080/ocms/authentication/registration.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['first_name'] = first_name.text;
    request.fields['middle_name'] = middle_name.text;
    request.fields['sur_name'] = sur_name.text;
    request.fields['email'] = email.text;
    request.fields['password'] = password.text;
    request.fields['phonenumber'] = phonenumber.text;
    request.fields['registration_number'] = registration_number.text;
    var response = await request.send();

    try {
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Login(
                    // u,
                    )));
      } else {
        await done();
        Fluttertoast.showToast(
          msg: 'Input Fields contain an Error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    } catch (e) {
      {
        await done();
        // Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
        Fluttertoast.showToast(
          msg: 'Could not connect',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    }
  }

  bool isLoading = false;
  done() {
    Timer t = Timer(Duration(seconds: 20), () {
      setState(() {
        isLoading = false;
        // cancel();
      });
    });
    t.cancel();
  }

  cancel() {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => Failure(
    //             // u,
    //             )));
  }

  var u;
  Future get_username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.get('username');
    setState(() {
      u = name;
    });
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

  @override
  void dispose() {
    // _audioPlayer = null;
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final fileName = _file != null ? Text(_file!.path) : 'No file selected';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: HexColor("#ffffff")),
        shadowColor: Colors.black,
        bottomOpacity: 1.0,
        toolbarOpacity: 1.0,
        // toolbarHeight: 100,
        title:
            Text('REGISTRATION', style: TextStyle(color: HexColor("#ffffff"))),
        centerTitle: true,
        backgroundColor: HexColor("#013221"),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'User ',
                style: GoogleFonts.poppins(
                  color: HexColor('#013221'),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                'Registration',
                style: GoogleFonts.poppins(
                  color: HexColor('#013221'),
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Divider(
              color: Colors.grey.shade100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Text(
              'The information supplied in this form will only be used to enhance user performance',
              style: GoogleFonts.poppins(color: HexColor('#013221')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Divider(
              color: HexColor('#530c1a'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  child: Text(
                    'Already a user, Sign In?',
                    style: TextStyle(color: HexColor('#ef4c2c'), fontSize: 13),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Registering()));
                  }),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('First Name:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: first_name,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Middle Name:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: middle_name,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Sur Name:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: sur_name,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Registration Number:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: registration_number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Email:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Phone Number:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        controller: phonenumber,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor('#013221'),
                          focusColor: HexColor('#013221'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Title(
                            color: Colors.black,
                            child: Text('Password:',
                                style: TextStyle(fontWeight: FontWeight.w900))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              controller: password,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#013221')),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: HexColor('#013221')),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                fillColor: HexColor("#f0f0f0"),
                                hoverColor: HexColor('#013221'),
                                focusColor: HexColor('#013221'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 30,
              ),
              isLoading
                  ? SpinKitFadingCircle(
                      // duration: const Duration(seconds: 3),
                      // size: 100,
                      color: HexColor('#013221'),
                    )
                  : Container(
                      width: 370,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  HexColor('#013221')),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  HexColor('#013221')),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(
                                          color: HexColor('#013221'))))),
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                              upload();
                              done();
                            });
                            // Navigator.pushReplacement(
                            //     context, MaterialPageRoute(builder: (_) => Home(u)));
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
              SizedBox(
                height: 120,
              )
            ],
          )
        ]),
      )),
    );
  }
}
