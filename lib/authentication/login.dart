// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, use_build_context_synchronously, depend_on_referenced_packages, must_call_super

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ocms/staff_clearance/dean_staff/claims.dart';
import 'package:ocms/staff_clearance/dvc/claims.dart';
import 'package:ocms/staff_clearance/estate/claims.dart';
import 'package:ocms/staff_clearance/health/claims.dart';
import 'package:ocms/staff_clearance/hods/claims.dart';
import 'package:ocms/staff_clearance/library_staff/claims.dart';
import 'package:ocms/staff_clearance/sacoss/claims.dart';
import 'package:ocms/staff_clearance/secretary/claims.dart';
import 'package:ocms/staff_clearance/telephone/claims.dart';
import 'package:ocms/student_clearance/daruso/claims.dart';
import 'package:ocms/students/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../staff/staff.dart';
import '../staff_clearance/bursar_staff/claims.dart';
import '../staff_clearance/coach_staff/claims.dart';
import '../staff_clearance/registry/claims.dart';
import '../student_clearance/bursar/claims.dart';
import '../student_clearance/coach/claims.dart';
import '../student_clearance/convacation/claims.dart';
import '../student_clearance/dean/claims.dart';
import '../student_clearance/head_of_department/claims.dart';
import '../student_clearance/library/claims.dart';
import '../student_clearance/smart_card/claims.dart';
import '../student_clearance/usab/claims.dart';
import '../student_clearance/warden/claims.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future login() async {
    const url = 'http://192.168.43.132:8080/ocms/authentication/login.php';
    var response = await http.post(Uri.parse(url), body: {
      "reg_no": u.text,
      "p": p.text,
    });
    var data = jsonDecode(response.body);

    if (data == "staff") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Staff('')));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'staff');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "admin") {
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => Staff('')));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'admin');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "head_of_department") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Hod()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'head_of_department');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "student") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Student('')));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'student');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "dvc") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dvc()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'dvc');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "dvc") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dvc()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'dvc');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "hods") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Hods()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'hods');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "convacation") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Convocation()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'convacation');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "coach") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Coach()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'coach');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "warden") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Warden()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'warden');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "usab") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Usab()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'usab');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "daruso") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Daruso()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'daruso');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "library") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Library()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'library');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "dean") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Dean()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'dean');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "bursar") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Bursar()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'bursar');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "smart_card") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Smart()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'smart_card');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "dean_staff") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Dean_staff()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'dean_staff');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "estate") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Estate()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'estate');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "health") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Health()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'health');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "library_staff") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Library_staff()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'library_staff');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "bursar_staff") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Bursar_staff()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'bursar_staff');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "saccoss") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Saccoss()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'saccoss');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }else if (data == "secretary") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Secretary()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'secretary');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "registry") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Registry()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'secretary');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "telephone") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Telephone()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'telephone');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }else if (data == "coach_staff") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Coachs()));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', u.text);
      sharedPreferences.setString('status', 'coach_staff');
      Fluttertoast.showToast(
        msg: 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    } else if (data == "wrong") {
      await done();
      Fluttertoast.showToast(
        msg: 'Invalid Username and Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _passwordVisible = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 208, 208, 208),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
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
              Text(
                'Welcome back!',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              Text(
                'Log in to your existing account',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: HexColor('#013221')),
                  controller: u,
                  cursorColor: HexColor('#013221'),
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor('#013221')),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: HexColor('#013221')),
                    ),
                    fillColor: HexColor("#f0f0f0"),
                    hoverColor: HexColor('#013221'),
                    focusColor: HexColor('#013221'),
                    hintText: 'Registration/Staff ID',
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: HexColor('#013221')),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: HexColor('#013221'),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else if (value.isEmpty) {
                      return 'Username is Empty';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                child: TextFormField(
                  style: TextStyle(color: HexColor('#013221')),
                  controller: p,
                  cursorColor: HexColor('#013221'),
                  obscureText: !_passwordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor('#013221')),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: HexColor('#013221')),
                    ),
                    fillColor: HexColor("#f0f0f0"),
                    hoverColor: HexColor('#013221'),
                    focusColor: HexColor('#013221'),
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: HexColor('#013221')),
                    prefixIcon: Icon(
                      Icons.key,
                      color: HexColor('#013221'),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: HexColor('#013221'),
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
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
              // Padding(
              //   padding: const EdgeInsets.only(right: 50, top: 15),
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: InkWell(
              //         child: Text(
              //           'New User, Sign Up?',
              //           style:
              //               TextStyle(color: HexColor('#ef4c2c'), fontSize: 13),
              //         ),
              //         onTap: () {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => Registering()));
              //         }),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              isLoading
                  ? SpinKitCircle(
                      color: HexColor('#013221'),
                    )
                  : SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        height: 55,
                        width: 330,
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
                            'LOGIN',
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
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
