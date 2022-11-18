// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, curly_braces_in_flow_control_structures, non_constant_identifier_names, prefer_typing_uninitialized_variables, constant_identifier_names, unused_local_variable, avoid_print, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ocms/staff/details.dart';
import 'package:ocms/students/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({Key? key}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  List claims = [];
  bool loading = true;
  Future fetchData() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/staff/comments.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "pay_roll": username.toString(),
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          claims = json.decode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          loading = true;
        });
      }

      // print(claims);
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
    });
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Comments/Irregularities',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                color: HexColor("#013221"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(color: HexColor("#013221")),
                        ), //livescore-api.com/api-client/fixtures/matches.json?competition_id=80&key=de0YMjttm1cqWuft&secret=hK3cwKwZmt1YxfVLtVKgeeJAfW1brgFI
                        Text(
                          'Staff Id',
                          style: TextStyle(color: HexColor("#013221")),
                        ),
                        Text(
                          'Designation',
                          style: TextStyle(color: HexColor("#013221")),
                        ),
                        // Text(
                        //   'Hall',
                        //   style: TextStyle(color: HexColor("#013221")),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            loading == true
                ? SingleChildScrollView(
                    child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: buildFoodShimmer(),
                          );
                        },
                      ),
                    ],
                  ))
                : claims.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Center(
                            child: Text('No Comment available at the moment'),
                          )
                        ],
                      ))
                    : SingleChildScrollView(
                        child: Column(
                        children: [
                          // Card(child: Text(mapResponse['success'].toString())),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Detailst(
                                                  college: claims[index]
                                                      ['college'],
                                                      comment: claims[index]
                                                      ['comment'],
                                                  contact_address: claims[index]
                                                      ['contact_address'],
                                                  date_departure: claims[index]
                                                      ['date_departure'],
                                                  date_return: claims[index]
                                                      ['date_return'],
                                                  designation: claims[index]
                                                      ['designation'],
                                                  house_unit: claims[index]
                                                      ['house_unit'],
                                                  names: claims[index]['names'],
                                                  pay_roll: claims[index]
                                                      ['pay_roll'],
                                                  physical_address:
                                                      claims[index]
                                                          ['physical_address'],
                                                  reason: claims[index]
                                                      ['reason'],
                                                  telephone_kin: claims[index]
                                                      ['telephone_kin'],
                                                  fromm: claims[index]
                                                      ['fromm'],
                                                )));
                                  },
                                  child: Container(
                                    color: HexColor("#013221"),
                                    height: 70,
                                    child: Table(
                                      border: TableBorder(
                                          top: BorderSide(
                                              color: HexColor("#013221")),
                                          right: BorderSide(
                                              color: HexColor("#013221")),
                                          left: BorderSide(
                                              color: HexColor("#013221")),
                                          bottom: BorderSide(
                                              color: HexColor("#013221")),
                                          horizontalInside: BorderSide(
                                              color: HexColor("#013221")),
                                          verticalInside: BorderSide(
                                              color: HexColor("#013221"))),
                                      children: [
                                        TableRow(
                                          children: [
                                            InkWell(
                                              child: Text(
                                                claims[index]['names']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ), //livescore-api.com/api-client/fixtures/matches.json?competition_id=80&key=de0YMjttm1cqWuft&secret=hK3cwKwZmt1YxfVLtVKgeeJAfW1brgFI
                                            InkWell(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    claims[index]['pay_roll']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            InkWell(
                                              child: Text(
                                                  claims[index]['designation']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            // InkWell(
                                            //   child: Text(
                                            //       claims[index]['hall'].toString(),
                                            //       style:
                                            //           TextStyle(color: Colors.white)),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: claims == null ? 0 : claims.length,
                          ),
                        ],
                      ))
          ],
        ),
      ),
    );
  }

  Widget buildFoodShimmer() => ListTile(
        title: ShimmerWidget.rectangular(height: 70),
      );
}
