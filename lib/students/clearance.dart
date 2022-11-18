// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names, curly_braces_in_flow_control_structures, constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login.dart';

class Clearance extends StatefulWidget {
  Clearance(
    String s, {
    Key? key,
  }) : super(key: key);

  @override
  _ClearanceState createState() => _ClearanceState();
}

class _ClearanceState extends State<Clearance> {
  Future login() async {
    // 192.168.43.251
    // 192.168.43.251
    const url = 'http://192.168.43.132:8080/ocms/student/start_clearance.php';
    var response = await http.post(Uri.parse(url), body: {
      "name": names.toString(),
      "reg_no": username.toString(),
      "program_degree": program_degree.text,
      "hall": hall.text,
      "room_no": room_no.text,
      "sponcer": sponcer.text,
    });
    var data = jsonDecode(response.body);

    if (data == "reg") {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Registration number already exists',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "name") {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Name number already exists',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "done") {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Clearance started succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'Clearance Unsucceful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  List claims = [];
  Future fetch() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/student/home.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "reg_no": username.toString(),
    });
    var datas = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          claims = json.decode(response.body);
        });
    } //
  }

  var names;
  List claimss = [];
  Future fetchData() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/student/start.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "reg_no": username.toString(),
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          claimss = json.decode(response.body);
          names = claimss[0]['first_name'].toString() +
              ' ' +
              claimss[0]['last_name'].toString();
        });
    } //
  }

  var username;
  Future get_username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.get('username');
    setState(() {
      username = name;
      fetchData();
      fetch();
    });
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

  TextEditingController program_degree = TextEditingController();
  TextEditingController hall = TextEditingController();
  TextEditingController room_no = TextEditingController();
  TextEditingController sponcer = TextEditingController();
  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#013221'),
          actions: [
            IconButton(
                onPressed: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('username');
                  sharedPreferences.remove('status');
                  Navigator.of(context).pushAndRemoveUntil(
                      // the new route
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),

                      // this function should return true when we're done removing routes
                      // but because we want to remove all other screens, we make it
                      // always return false
                      (Route route) => false);
                },
                icon: Icon(Icons.person_off))
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 208, 208, 208),
        body: claims.isEmpty
            ? SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'STUDENT CLEARANCE FORMS',
                        style: GoogleFonts.aladin(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text(
                        'Let\'s Get Started!',
                        // style: TextStyle(color: HexColor('#013221')),
                      )),
                      Center(
                          child: Text(
                        'Fill in the table below to start your clearance',
                        style: GoogleFonts.aladin(
                          color: Colors.black,
                          fontSize: 15,
                          // fontWeight: FontWeight.w500,
                        ),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: HexColor('#013221')),
                          controller: program_degree,
                          cursorColor: HexColor('#013221'),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: HexColor('#013221'),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: HexColor('#013221'),
                            hoverColor: HexColor('#013221'),
                            focusColor: HexColor('#013221'),
                            hintText: 'Degree program',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: HexColor('#013221')),
                            prefixIcon: Icon(
                              Icons.menu_book,
                              color: HexColor('#013221'),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return 'Phone is Empty';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          style: TextStyle(color: HexColor('#013221')),
                          controller: hall,
                          cursorColor: HexColor('#013221'),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: HexColor('#013221'),
                            hoverColor: HexColor('#013221'),
                            focusColor: HexColor('#013221'),
                            hintText: 'Hall',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: HexColor('#013221')),
                            prefixIcon: Icon(
                              Icons.home,
                              color: HexColor('#013221'),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return 'Password is Empty';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          style: TextStyle(color: HexColor('#013221')),
                          controller: room_no,
                          cursorColor: HexColor('#013221'),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: HexColor('#013221'),
                            hoverColor: HexColor('#013221'),
                            focusColor: HexColor('#013221'),
                            hintText: 'Room No',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: HexColor('#013221')),
                            prefixIcon: Icon(
                              Icons.holiday_village,
                              color: HexColor('#013221'),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return 'Password is Empty';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          style: TextStyle(color: HexColor('#013221')),
                          controller: sponcer,
                          cursorColor: HexColor('#013221'),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor('#013221')),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            fillColor: HexColor('#013221'),
                            hoverColor: HexColor('#013221'),
                            focusColor: HexColor('#013221'),
                            hintText: 'Sponcer',
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: HexColor('#013221')),
                            prefixIcon: Icon(
                              Icons.family_restroom,
                              color: HexColor('#013221'),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            } else if (value.isEmpty) {
                              return 'Password is Empty';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      isLoading
                          ? SpinKitCircle(
                              // duration: const Duration(seconds: 3),
                              // size: 100,
                              color: HexColor('#013221'),
                            )
                          : SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                height: 55,
                                width: 200,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: HexColor('#013221'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(
                                              // color: HexColor('#cbdd33')
                                              ))),
                                  onPressed: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    login();
                                  },
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 200),
                    Center(
                      child: Text('Clearance in progress...'),
                    )
                  ],
                ),
              ));
  }
}
