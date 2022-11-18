// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names, constant_identifier_names, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

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
  var newdate;
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var day = pickedDate.toString();
        var separated = day.split(" ");
        newdate = separated[0];
      });
    }
  }

  var newdate1;
  DateTime currentDate1 = DateTime.now();
  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var day = pickedDate.toString();
        var separated = day.split(" ");
        newdate1 = separated[0];
      });
    }
  }

  Future login() async {
    const url = 'http://192.168.43.132:8080/ocms/staff/start_clearance.php';
    var response = await http.post(Uri.parse(url), body: {
      "names": names.toString(),
      "pay_roll": payroll.toString(),
      "designation": designation.text,
      "college": college.text,
      "reason": reason.toString(),
      "house_unit": house_unit.toString(),
      "date_departure": newdate.toString(),
      "date_return": newdate1.toString(),
      "contact_address": contact_address.text,
      "physical_address": physical_address.text,
      "telephone_kin": telephone_kin.text,
    });
    var data = jsonDecode(response.body);

    if (data == "payroll") {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: 'staff ID number already exists',
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
        msg: 'Name already exists',
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

  TextEditingController designation = TextEditingController();
  TextEditingController college = TextEditingController();
  // TextEditingController reason = TextEditingController();
  TextEditingController date_departure = TextEditingController();
  TextEditingController date_return = TextEditingController();
  TextEditingController contact_address = TextEditingController();
  TextEditingController physical_address = TextEditingController();
  TextEditingController telephone_kin = TextEditingController();
  // TextEditingController house_unit = TextEditingController();

  var reason;
  List reasons = [
    'LWP',
    'DISMISSED',
    'TERMINATION',
    'RESIGNATION',
    'SECONDMENT',
    'RETIREMENT',
    'RETIRENCHMENT',
    'DEATH'
  ];
  var house_unit;
  List house_units = ['YES', 'NO'];

  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  List claimss = [];
  Future fetchData() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/staff/home.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "pay_roll": payroll.toString(),
    });
    var datas = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          claimss = json.decode(response.body);
        });
    } //
  }

  var names;
  List claims = [];
  Future fetch() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/staff/homes.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "pay_roll": payroll.toString(),
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          claims = json.decode(response.body);
          names = claims[0]['first_name'].toString() +
              ' ' +
              claims[0]['last_name'].toString();
        });
    } //
  }

  var payroll;
  Future get_username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var name = sharedPreferences.get('username');
    setState(() {
      payroll = name;
      fetchData();
      fetch();
    });
    // print(email);
  }

  @override
  void initState() {
    super.initState();
    get_username();
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
      body: claimss.isEmpty
          ? SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'STAFF CLEARANCE FORMS',
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
                        style: TextStyle(color: HexColor('#013221')),
                        controller: designation,
                        cursorColor: HexColor('#013221'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor("#013221"),
                          focusColor: HexColor("#013221"),
                          hintText: 'Designation(Post)',
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
                            return 'designation is Empty';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 38, right: 38),
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            color: HexColor('#f0f0f0'),
                            border: Border.all(
                                color: HexColor("#013221"), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonFormField(
                          menuMaxHeight: 300,
                          isExpanded: true,
                          focusColor: Colors.white,
                          dropdownColor: Colors.white,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                            hoverColor: null,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          // underline: SizedBox(),
                          hint: Text(
                            'Reason for leaving',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "This field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          value: reason,
                          onChanged: (newValue1) {
                            setState(() {
                              reason = newValue1;
                            });
                          },
                          items: reasons.map((valueItem1) {
                            return DropdownMenuItem(
                              value: valueItem1,
                              child: Text(valueItem1 != null
                                  ? valueItem1
                                  : 'default value'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 38, right: 38),
                      child: Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                            color: HexColor('#f0f0f0'),
                            border: Border.all(
                                color: HexColor("#013221"), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonFormField(
                          menuMaxHeight: 300,
                          isExpanded: true,
                          focusColor: Colors.white,
                          dropdownColor: Colors.white,
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          decoration: InputDecoration(
                            hoverColor: null,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          // underline: SizedBox(),
                          hint: Text(
                            'Occupying University housing unit?',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "This field cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          value: house_unit,
                          onChanged: (newValue2) {
                            setState(() {
                              house_unit = newValue2;
                            });
                          },
                          items: house_units.map((valueItem2) {
                            return DropdownMenuItem(
                              value: valueItem2,
                              child: Text(valueItem2 != null
                                  ? valueItem2
                                  : 'default value'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: HexColor('#013221')),
                        controller: college,
                        cursorColor: HexColor('#013221'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: HexColor('#013221'),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor("#013221"),
                          focusColor: HexColor("#013221"),
                          hintText:
                              'College/School?Institute/Directorate/Bureau',
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
                            return 'college is Empty';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextFormField(
                            enabled: false,
                            // controller: TextEditingController()..text = newdate,
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor("#415812")),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: HexColor("#415812")),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.black,
                              ),
                              hintText: 'Date of Depature-${newdate}',
                              hintStyle: TextStyle(color: Colors.black),
                              fillColor: HexColor("#f0f0f0"),
                              hoverColor: HexColor("#013221"),
                              focusColor: HexColor("#013221"),
                            ),
                            // validator: (value) {
                            //   if (value!.isNotEmpty) {
                            //     return null;
                            //   } else if (value.isEmpty) {
                            //     return 'This field cannot be empty';
                            //   }
                            // },
                            // controller: newdat
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    // height: 15,
                    //),
                    //Padding(
                    //padding: const EdgeInsets.only(left: 25, right: 25),
                    //child: InkWell(
                    //onTap: () => _selectDate1(context),
                    //child: Padding(
                    //padding: const EdgeInsets.only(left: 16, right: 16),
                    //child: TextFormField(
                    //enabled: false,
                    // controller: TextEditingController()..text = newdate,
                    //decoration: InputDecoration(
                    //filled: true,
                    //contentPadding:
                    // const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    //focusedBorder: OutlineInputBorder(
                    //borderSide:
                    // BorderSide(color: HexColor("#415812")),
                    //borderRadius: BorderRadius.circular(0.0),
                    //),
                    //enabledBorder: OutlineInputBorder(
                    //borderSide:
                    //  BorderSide(color: HexColor("#415812")),
                    //borderRadius: BorderRadius.circular(0.0),
                    //),
                    //suffixIcon: Icon(
                    //Icons.calendar_today_rounded,
                    //color: Colors.black,
                    //),
                    //hintText: 'Date of Depature-${newdate1}',
                    //hintStyle: TextStyle(color: Colors.black),
                    //fillColor: HexColor("#f0f0f0"),
                    //hoverColor: HexColor("#013221"),
                    //focusColor: HexColor("#013221"),
                    //),
                    // validator: (value) {
                    //   if (value!.isNotEmpty) {
                    //     return null;
                    //   } else if (value.isEmpty) {
                    //     return 'This field cannot be empty';
                    //   }
                    // },
                    // controller: newdat
                    //),
                    //),
                    //),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        style: TextStyle(color: HexColor('#013221')),
                        controller: contact_address,
                        cursorColor: HexColor('#013221'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor("#013221"),
                          focusColor: HexColor("#013221"),
                          hintText: 'Contact Address',
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
                            return 'Contact Address is Empty';
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
                        controller: physical_address,
                        cursorColor: HexColor('#013221'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor("#013221"),
                          focusColor: HexColor("#013221"),
                          hintText: 'Physical Address',
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
                            return 'Physical Address is Empty';
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
                        controller: telephone_kin,
                        cursorColor: HexColor('#013221'),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#013221')),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          fillColor: HexColor("#f0f0f0"),
                          hoverColor: HexColor("#013221"),
                          focusColor: HexColor("#013221"),
                          hintText: 'Telephone of next kin',
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
                            return 'Telephone is Empty';
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
                                        borderRadius: BorderRadius.circular(5),
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
            ),
    );
  }
}
