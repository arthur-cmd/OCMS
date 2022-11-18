// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ocms/staff_clearance/dean_staff/claims.dart';
import 'package:ocms/staff_clearance/dvc/claims.dart';
import 'package:ocms/staff_clearance/estate/claims.dart';
import 'package:ocms/staff_clearance/health/claims.dart';
import 'package:ocms/staff_clearance/library_staff/claims.dart';
import 'package:ocms/staff_clearance/registry/claims.dart';
import 'package:ocms/staff_clearance/sacoss/claims.dart';
import 'package:ocms/staff_clearance/secretary/claims.dart';
import 'package:ocms/staff_clearance/telephone/claims.dart';
import 'package:ocms/student_clearance/coach/claims.dart';
import 'package:ocms/student_clearance/convacation/claims.dart';
import 'package:ocms/student_clearance/daruso/claims.dart';
import 'package:ocms/student_clearance/dean/claims.dart';
import 'package:ocms/student_clearance/library/claims.dart';
import 'package:ocms/student_clearance/smart_card/claims.dart';
import 'package:ocms/student_clearance/usab/claims.dart';
import 'package:ocms/student_clearance/warden/claims.dart';
import 'package:ocms/students/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login.dart';
import '../staff/staff.dart';
import '../staff_clearance/bursar_staff/claims.dart';
import '../staff_clearance/coach_staff/claims.dart';
import '../staff_clearance/hods/claims.dart';
import '../student_clearance/bursar/claims.dart';
import '../student_clearance/head_of_department/claims.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({Key? key}) : super(key: key);

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  void initState() {
    super.initState();
    _navigatortohome();
  }

  var username;
  var status;
  _navigatortohome() async {
    await getValidationData().whenComplete(() async {
      await Future.delayed(Duration(seconds: 3), () {});
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => username == null ? Login() : Homepage('')));
      if (username == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else if (username != null && status == 'staff') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Staff('')));
      } else if (username != null && status == 'admin') {
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => Homepage('')));
      } else if (username != null && status == 'student') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Student('')));
      } else if (username != null && status == 'bursar') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Bursar()));
      } else if (username != null && status == 'coach') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Coach()));
      } else if (username != null && status == 'daruso') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Daruso()));
      } else if (username != null && status == 'dean') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Dean()));
      } else if (username != null && status == 'library') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Library()));
      } else if (username != null && status == 'warden') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Warden()));
      } else if (username != null && status == 'smart_card') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Smart()));
      } else if (username != null && status == 'usab') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Usab()));
      } else if (username != null && status == 'convacation') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Convocation()));
      } else if (username != null && status == 'coach_staff') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Coachs()));
      } else if (username != null && status == 'dvc') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Dvc()));
      } else if (username != null && status == 'dean_staff') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Dean_staff()));
      } else if (username != null && status == 'estate') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Estate()));
      } else if (username != null && status == 'health') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Health()));
      } else if (username != null && status == 'library_staff') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Library_staff()));
      } else if (username != null && status == 'bursar_staff') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Bursar_staff()));
      } else if (username != null && status == 'registry') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Registry()));
      } else if (username != null && status == 'saccoss') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Saccoss()));
      } else if (username != null && status == 'secretary') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Secretary()));
      } else if (username != null && status == 'head_of_department') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Hod()));
      } else if (username != null && status == 'hods') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Hods()));
      } else if (username != null && status == 'telephone') {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Telephone()));
      }
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    setState(() {
      username = u;
      status = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#013221'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Center(
                child: Image.asset(
              'assets/logo1.png',
              height: 200,
              width: 400,
            )),
            SizedBox(
              height: 15,
            ),
            SpinKitThreeInOut(
              // duration: const Duration(seconds: 3),
              size: 20,
              color: HexColor('#ffffff'),
            ),
            // Center(
            //   child: Card(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Title(color: Colors.black, child: Text('Welcome to OCMS')),
            //         Text(
            //             'Clearance portal where students and \n stafs perorm clearance remotely.'),
            //         // Text('Choose types of user to start'),
            //         ElevatedButton(
            //             onPressed: () {

            //             },
            //             child: Text('Continue'))
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
