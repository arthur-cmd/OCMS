// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, constant_identifier_names, curly_braces_in_flow_control_structures, unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../authentication/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List claims = [];
  Future fetchData() async {
    http.Response response;
    const API_URL = 'http://192.168.43.132:8080/ocms/staff/home.php';
    response = await http.post(Uri.parse(API_URL), body: {
      "pay_roll": username.toString(),
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          claims = json.decode(response.body);
        });
      // claims[1]['stage'] / 9 * 10;
      // print();
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
    // print(username);
  }

  // var percent = int.parse(claims[0]['stage']) / 9;

  var index = 0;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
                child: Title(
                    color: Colors.black,
                    child: Text(
                      'Welcome to OCMS',
                      style: GoogleFonts.aladin(
                        color: Colors.black,
                        // fontWeight: FontWeight.w500,
                        fontSize: 50,
                      ),
                    ))),
            SizedBox(
              height: 15,
            ),
            Text(
              'Here is Your clearance progress',
              style: GoogleFonts.aladin(
                color: Colors.black,
                fontSize: 15,
                // fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 15.0,
              percent:
                  claims.isNotEmpty ? double.parse(claims[0]['stage']) / 12 : 0,
              center: Text(
                  "${claims.isNotEmpty ? (double.parse(claims[0]['stage']) / 12 * 100).toStringAsFixed(1) : 0}%"),
              progressColor: HexColor('#013221'),
            ),
            SizedBox(height: 15),
            Text(
              '- Day to day progress will be tracked \n - The clearance progress has to reach 100%\n so as to finish the process',
              style: GoogleFonts.aladin(
                color: Colors.black,
                fontSize: 20,
                // fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'BON VOYAGE',
              style: GoogleFonts.aladin(
                color: Colors.black,
                fontSize: 20,
                // fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
