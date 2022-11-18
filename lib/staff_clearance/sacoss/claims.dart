// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, constant_identifier_names, avoid_print, unnecessary_null_comparison, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ocms/staff_clearance/sacoss/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/login.dart';
import '../coach_staff/shimmer.dart';


class Saccoss extends StatefulWidget {
  const Saccoss({Key? key}) : super(key: key);

  @override
  _SaccossState createState() => _SaccossState();
}

class _SaccossState extends State<Saccoss> {
  List claims = [];
  Future fetchData() async {
    // 192.168.43.251
    // 192.168.43.251
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/head_of_unit_staff/saccoss.php';
    response = await http.get(Uri.parse(API_URL));

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

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        title: Text(
          'Control Panel',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Staff clearance Panel',
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
                          'Payroll No',
                          style: TextStyle(color: HexColor("#013221")),
                        ),
                        Text(
                          'Date Departure',
                          style: TextStyle(color: HexColor("#013221")),
                        ),
                        // Text(
                        //   'Date Return',
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
                                 Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => Detailsss(college: claims[index]['college'], contact_address: claims[index]['contact_address'], date_departure: claims[index]['date_departure'], date_return: claims[index]['date_return'], designation: claims[index]['designation'], house_unit: claims[index]['house_unit'], names: claims[index]['names'], pay_roll: claims[index]['pay_roll'], physical_address: claims[index]['physical_address'], reason: claims[index]['reason'], telephone_kin: claims[index]['telephone_kin'],)));
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
                                            claims[index]['names'].toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ), //livescore-api.com/api-client/fixtures/matches.json?competition_id=80&key=de0YMjttm1cqWuft&secret=hK3cwKwZmt1YxfVLtVKgeeJAfW1brgFI
                                        InkWell(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                claims[index]['pay_roll']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        InkWell(
                                          child: Text(
                                              claims[index]['date_departure']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        // InkWell(
                                        //   child: Text(
                                        //       claims[index]['date_return']
                                        //           .toString(),
                                        //       style: TextStyle(
                                        //           color: Colors.white)),
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
